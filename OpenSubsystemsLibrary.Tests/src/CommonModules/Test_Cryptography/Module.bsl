// BSLLS:UsingServiceTag-off
// BSLLS:MissingParameterDescription-off
// BSLLS:CodeOutOfRegion-off
// BSLLS:NonStandardRegion-off

// @unit-test
Procedure Test_HMAC(Context) Export
    
    SecretKey = GetBinaryDataFromString("Секретный ключ");
    BigSecretKey = GetBinaryDataFromString("1234567890123456789012345678901234567890123456789012345678901234567890");
    
    EmptyData = GetBinaryDataFromString("");
    Data = GetBinaryDataFromString("Какие-то данные");
    
    Assert.AreEqual(
        GetBinaryDataFromHexString("1b1ec4166a11c03b3afefaea442e7709"),
        Cryptography.HMAC(SecretKey, EmptyData, HashFunction.MD5)
    );
    Assert.AreEqual(
        GetBinaryDataFromHexString("ed5b2d6b9f573cd46e8f8d1d1e8b70e3"),
        Cryptography.HMAC(BigSecretKey, Data, HashFunction.MD5)
    );
        
    Assert.AreEqual(
        GetBinaryDataFromHexString("355aa0587050d711f4ca9af6930c736363a88d34"),
        Cryptography.HMAC(SecretKey, EmptyData, HashFunction.SHA1)
    );
    Assert.AreEqual(
        GetBinaryDataFromHexString("7e8f9d7ebbe81e508a39f410e157fc6e714b3371"),
        Cryptography.HMAC(BigSecretKey, Data, HashFunction.SHA1)
    );
    Assert.AreEqual(
        GetBinaryDataFromHexString("70907d03476d72b7276897718590a49f6ce56991112fb5a0e9ed41652b2aab6c"),
        Cryptography.HMAC(SecretKey, EmptyData, HashFunction.SHA256)
    );
    Assert.AreEqual(
        GetBinaryDataFromHexString("80be8107de7879f028c8bfe97e10b859785530dd19dfc41a4d6962ce4c2fc130"),
        Cryptography.HMAC(BigSecretKey, Data, HashFunction.SHA256)
    );
    
EndProcedure