// BSLLS:UsingServiceTag-off
// BSLLS:MissingParameterDescription-off
// BSLLS:CodeOutOfRegion-off
// BSLLS:NonStandardRegion-off

// @unit-test
Procedure Test_GZipPingPong(Context) Export
    
    Data = GetBinaryDataFromString("Someone");
    
    CompressedData = GZip.Compress(Data);
    DecompressedData = GZip.Decompress(CompressedData);
    
    Assert.AreEqual(GetHexStringFromBinaryData(DecompressedData), GetHexStringFromBinaryData(Data));
    
EndProcedure

// @unit-test
Procedure Test_GZipCompress(Context) Export
    
    Data = GetBinaryDataFromString("Привет, Мир!");
    
    Assert.AreEqual(
        GetBinaryDataFromBase64String("H4sIAAAAAAAA/wEVAOr/0J/RgNC40LLQtdGCLCDQnNC40YAhilS6PhUAAAA="),
        GZip.Compress(Data)
    );
    
EndProcedure

// @unit-test
Procedure Test_GZipDecompress(Context) Export
    
    CompressedData = GetBinaryDataFromBase64String(
        "H4sIAAAAAAAA/wEVAOr/0J/RgNC40LLQtdGCLCDQnNC40YAhilS6PhUAAAA="
    );
    
    Assert.AreEqual(GetBinaryDataFromString("Привет, Мир!"), GZip.Decompress(CompressedData));
    
EndProcedure