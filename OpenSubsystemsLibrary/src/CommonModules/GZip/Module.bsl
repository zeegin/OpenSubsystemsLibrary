#Region Public

#If Not MobileAppServer Then

Function Decompress(BinaryDataOrStream) Export
    
    GZipPrefixSize = 10;
    GZipPostfixSize = 8;
    LHFSize = 34;
    DDSize = 16;
    CDHSize = 50;
    EOCDSize = 22;
    
    DataReader = New DataReader(BinaryDataOrStream);
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

Function Compress(BinaryData) Export
    
    TempFile = GetTempFileName(".bin");
    BinaryData.Write(TempFile);
    ZipStream = New MemoryStream;
    ZipFileReader = New ZipFileWriter(ZipStream);
    ZipFileReader.Add(TempFile);
    ZipFileReader.Write();
    DeleteFiles(TempFile);
    
    ZipBinaryData = ZipStream.CloseAndGetBinaryData();
    
    DataReader = New DataReader(ZipBinaryData);
    
    ZipPrefixSize = 14;
    DataReader.Skip(ZipPrefixSize);
    CRC32 = DataReader.ReadInt32();
    
    CompresedSize = DataReader.ReadInt32();
    UncopressedSize = DataReader.ReadInt32();
    
    FileNameSize = DataReader.ReadInt16();
    AdditionalFieldSize = DataReader.ReadInt16();
    DataReader.Skip(FileNameSize + AdditionalFieldSize);

    GZipHeaderSize = 10;
    GZipHeader = New BinaryDataBuffer(GZipHeaderSize);
    GZipHeader[0] = 31;   // ID1 0x1f
    GZipHeader[1] = 139;  // ID2 0x8b
    GZipHeader[2] = 8;    // compression method (08 for DEFLATE)
    GZipHeader[3] = 0;    // header flags
    GZipHeader.WriteInt32(4, 0); // timestamp
    GZipHeader[8] = 0;    // compression flags
    GZipHeader[9] = 255;  // operating system ID
    
    GZipFooterSize = 8;
    GZipFooter = New BinaryDataBuffer(GZipFooterSize);
    GZipFooter.WriteInt32(0, CRC32);
    GZipFooter.WriteInt32(4, UncopressedSize);
    
    GZipStream = New MemoryStream;
    
    DataWriter = New DataWriter(GZipStream);
    DataWriter.WriteBinaryDataBuffer(GZipHeader);
    DataReader.CopyTo(DataWriter, CompresedSize);
    DataWriter.Close();
    DataWriter = New DataWriter(GZipStream);
    DataWriter.WriteBinaryDataBuffer(GZipFooter);
    
    Return GZipStream.CloseAndGetBinaryData();
    
EndFunction

#EndIf

#EndRegion
