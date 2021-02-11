#Region Variables

Var STATUS_CODE_OK;
Var STATUS_CODE_CLIENT_ERROR;

Var Headers Export;
Var StatusCode Export;
Var Encoding Export;
Var URL Export;

Var HTTPResponse;

#EndRegion

#Region Public

Procedure RaiseForStatus() Export 
    
    If StatusCode <> STATUS_CODE_OK Then 
        Raise RuntimeError(StrTemplate(
            NStr("en = 'Got status <%1> for <%2>.';
                 |ru = 'Получен статус <%1> при запросе <%2>.'"),
            StatusCode,
            URL.Href
        ));
    EndIf;
    
EndProcedure

Function BinaryData() Export
    
    ContentEncoding = HTTPRequests.HeaderValue(Headers, "content-encoding", "none");
    
#If Not MobileAppServer Then
    If Lower(ContentEncoding) = "gzip" Then
        Return GZipStreamToBinaryData(HTTPResponse.GetBodyAsStream());
    EndIf;
#EndIf
    
    Return HTTPResponse.GetBodyAsBinaryData();
    
EndFunction

Function Text() Export
    
    BinaryData = BinaryData();
    If Not ValueIsFilled(BinaryData) Then
        Return "";
    EndIf;
    
    Stream = BinaryData.OpenStreamForRead();
    
    TextReader = New TextReader(Stream, Encoding);
    Text = TextReader.Read();
    TextReader.Close();
    
    Return Text; 
    
EndFunction

Function Json(DeserializerSettings = Undefined) Export
    
    If DeserializerSettings = Undefined Then
        DeserializerSettings = Json.DeserializerSettings();
        DeserializerSettings.Encoding = Encoding;
    EndIf;
    
    Return Json.Loads(BinaryData(), DeserializerSettings);
    
EndFunction

// Returns True if status_code is less than 400, False if not.
// This attribute checks if the status code of the response
// is between 400 and 600 to see if there was a client error or a server error.
// If the status code is between 200 and 400, this will return True.
// This is not a check to see if the response code is 200 OK.
//
Function Ok() Export 
    
    Return StatusCode >= STATUS_CODE_OK
        And StatusCode < STATUS_CODE_CLIENT_ERROR;
    
EndFunction

// Textual reason of responded HTTP Status, e.g. "Not Found" or "OK'.
//
Function Reason() Export 
    
    // TODO:
    Raise NotImplementedError();
    
EndFunction

#EndRegion

#Region Private

Procedure Ctor(HTTPResponse_, URL_) Export 
    
    HTTPResponse = HTTPResponse_;
    Headers = New FixedMap(HTTPResponse.Headers);
    StatusCode = HTTPResponse.StatusCode;
    Encoding = ResponseEncoding(HTTPResponse);
    URL = URL_;
    
EndProcedure

Function ResponseEncoding(HTTPResponse)
    
    ContentType = HTTPRequests.HeaderValue(HTTPResponse.Headers, "content-type", "");
    
    Options = Strings.SplitTrimAll(ContentType, ";");
    
    For Each Option In Options Do
        If StrStartsWith(Option, "charset=") Then
            Return Mid(Option, 9);
        EndIf;
    EndDo;
    
    Return "us-ascii";
    
EndFunction

#Region GZip

#If Not MobileAppServer Then

Function GZipStreamToBinaryData(Stream)
    
    GZipPrefixSize = 10;
    GZipPostfixSize = 8;
    LHFSize = 34;
    DDSize = 16;
    CDHSize = 50;
    EOCDSize = 22;
    
    DataReader = New DataReader(Stream);
    DataReader.Skip(GZipPrefixSize);
    CompresedSize = DataReader.SourceStream().Size() - GZipPrefixSize - GZipPostfixSize;
    
    ZipStream = New MemoryStream(LHFSize + CompresedSize + DDSize + CDHSize + EOCDSize);
    
    DataASCII = GetBinaryDataBufferFromString("data", "ascii", False);
    
    LHF = New BinaryDataBuffer(LHFSize);
    LHF.WriteInt32(0, 67324752);  // signature 0x04034b50
    LHF.WriteInt16(4, 20);  // version
    LHF.WriteInt16(6, 10);  // bit flags
    LHF.WriteInt16(8, 8);   // compression method
    LHF.WriteInt16(10, 0);  // time
    LHF.WriteInt16(12, 0);  // date
    LHF.WriteInt32(14, 0);  // crc-32
    LHF.WriteInt32(18, 0);  // compressed size
    LHF.WriteInt32(22, 0);  // uncompressed size
    LHF.WriteInt16(26, 4);  // filename legth - "data"
    LHF.WriteInt16(28, 0);  // extra field length
    LHF.Write(30, DataASCII);
    
    DataWriter = New DataWriter(ZipStream);
    DataWriter.WriteBinaryDataBuffer(LHF);
    
    DataReader.CopyTo(DataWriter, CompresedSize);
    
    DataWriter.Close();
    
    CRC32 = DataReader.ReadInt32();
    UncopressedSize = DataReader.ReadInt32();
    
    DataReader.Close();
    
    DD = New BinaryDataBuffer(DDSize);
    DD.WriteInt32(0, 134695760);
    DD.WriteInt32(4, CRC32);
    DD.WriteInt32(8, CompresedSize);
    DD.WriteInt32(12, UncopressedSize);
    
    CDH = New BinaryDataBuffer(CDHSize);
    CDH.WriteInt32(0, 33639248);  // signature 0x02014b50
    CDH.WriteInt16(4, 798); // version made by
    CDH.WriteInt16(6, 20);  // version needed to extract
    CDH.WriteInt16(8, 10);  // bit flags
    CDH.WriteInt16(10, 8);  // compression method
    CDH.WriteInt16(12, 0);  // time
    CDH.WriteInt16(14, 0);  // date
    CDH.WriteInt32(16, CRC32);  // crc-32
    CDH.WriteInt32(20, CompresedSize);  // compressed size
    CDH.WriteInt32(24, UncopressedSize);  // uncompressed size
    CDH.WriteInt16(28, 4);  // file name length
    CDH.WriteInt16(30, 0);  // extra field length
    CDH.WriteInt16(32, 0);  // file comment length
    CDH.WriteInt16(34, 0);  // disk number start
    CDH.WriteInt16(36, 0);  // internal file attributes
    CDH.WriteInt32(38, 2176057344);  // external file attributes
    CDH.WriteInt32(42, 0);  // relative offset of local header
    CDH.Write(46, DataASCII);
    
    EOCD = New BinaryDataBuffer(EOCDSize);
    EOCD.WriteInt32(0, 101010256);  // signature 0x06054b50
    EOCD.WriteInt16(4, 0);   // number of this disk
    EOCD.WriteInt16(6, 0);   // number of the disk with the start of the central directory
    EOCD.WriteInt16(8, 1);   // total number of entries in the central directory on this disk
    EOCD.WriteInt16(10, 1);  // total number of entries in the central directory
    EOCD.WriteInt32(12, CDHSize); // size of the central directory
    // offset of start of central directory with respect to the starting disk number
    EOCD.WriteInt32(16, LHFSize + CompresedSize + DDSize); 
    EOCD.WriteInt16(20, 0);  // the starting disk number
    
    DataWriter = New DataWriter(ZipStream);
    DataWriter.WriteBinaryDataBuffer(DD);
    DataWriter.WriteBinaryDataBuffer(CDH);
    DataWriter.WriteBinaryDataBuffer(EOCD);
    DataWriter.Close();
    
    TempDir = GetTempFileName();
    ZipFileReader = New ZipFileReader(ZipStream);
    
    ZipItem = ZipFileReader.Items.Get(0);
    
    ZipFileReader.Extract(ZipItem, TempDir, ZIPRestoreFilePathsMode.DontRestore);
    ZipFileReader.Close();
    
    Result = New BinaryData(OS.PathJoin(TempDir, ZipItem.Name));
    
    DeleteFiles(TempDir);
    
    Return Result;
    
EndFunction

#EndIf

#EndRegion

#EndRegion

#Region Initialize

STATUS_CODE_OK = 200;
STATUS_CODE_CLIENT_ERROR = 400;

#EndRegion