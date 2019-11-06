#Region Variables

Var STATUS_CODE_OK;
Var STATUS_CODE_CLIENT_ERROR;

Var Headers Export;
Var StatusCode Export;
Var Encoding Export;
Var URL Export;

Var _HTTPResponse;

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
        Return _GZipStreamToBinaryData(_HTTPResponse.GetBodyAsStream());
    EndIf;
#EndIf
    
    Return _HTTPResponse.GetBodyAsBinaryData();
    
EndFunction

Function Text() Export
    
    Stream = BinaryData().OpenStreamForRead();
    
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

// Textual reason of responded HTTP Status, e.g. “Not Found” or “OK”.
//
Function Reason() Export 
    
    //100: continue
    //101: switching_protocols
    //102: processing
    //103: checkpoint
    //122: uri_too_long, request_uri_too_long
    //200: ok, okay, all_ok, all_okay, all_good, \o/, ✓
    //201: created
    //202: accepted
    //203: non_authoritative_info, non_authoritative_information
    //204: no_content
    //205: reset_content, reset
    //206: partial_content, partial
    //207: multi_status, multiple_status, multi_stati, multiple_stati
    //208: already_reported
    //226: im_used
    //300: multiple_choices
    //301: moved_permanently, moved, \o-
    //302: found
    //303: see_other, other
    //304: not_modified
    //305: use_proxy
    //306: switch_proxy
    //307: temporary_redirect, temporary_moved, temporary
    //308: permanent_redirect, resume_incomplete, resume
    //400: bad_request, bad
    //401: unauthorized
    //402: payment_required, payment
    //403: forbidden
    //404: not_found, -o-
    //405: method_not_allowed, not_allowed
    //406: not_acceptable
    //407: proxy_authentication_required, proxy_auth, proxy_authentication
    //408: request_timeout, timeout
    //409: conflict
    //410: gone
    //411: length_required
    //412: precondition_failed, precondition
    //413: request_entity_too_large
    //414: request_uri_too_large
    //415: unsupported_media_type, unsupported_media, media_type
    //416: requested_range_not_satisfiable, requested_range, range_not_satisfiable
    //417: expectation_failed
    //418: im_a_teapot, teapot, i_am_a_teapot
    //421: misdirected_request
    //422: unprocessable_entity, unprocessable
    //423: locked
    //424: failed_dependency, dependency
    //425: unordered_collection, unordered
    //426: upgrade_required, upgrade
    //428: precondition_required, precondition
    //429: too_many_requests, too_many
    //431: header_fields_too_large, fields_too_large
    //444: no_response, none
    //449: retry_with, retry
    //450: blocked_by_windows_parental_controls, parental_controls
    //451: unavailable_for_legal_reasons, legal_reasons
    //499: client_closed_request
    //500: internal_server_error, server_error, /o\, ✗
    //501: not_implemented
    //502: bad_gateway
    //503: service_unavailable, unavailable
    //504: gateway_timeout
    //505: http_version_not_supported, http_version
    //506: variant_also_negotiates
    //507: insufficient_storage
    //509: bandwidth_limit_exceeded, bandwidth
    //510: not_extended
    //511: network_authentication_required, network_auth, network_authentication
    
EndFunction

#EndRegion

#Region Private

Procedure _Ctor(HTTPResponse, URL_) Export 
    
    _HTTPResponse = HTTPResponse;
    Headers = New FixedMap(HTTPResponse.Headers);
    StatusCode = HTTPResponse.StatusCode;
    Encoding = _ResponseEncoding(HTTPResponse);
    URL = URL_;
    
EndProcedure

Function _ResponseEncoding(HTTPResponse)
    
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

Function _GZipStreamToBinaryData(Stream)
    
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