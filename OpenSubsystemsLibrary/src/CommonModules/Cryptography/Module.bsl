#Region Public

// Compute MD5 hash sum of data
// 
// Parameters:
//  BinaryData - BinaryData - data to computing the hash sum
// 
// Returns:
//  String - hash sum hex string
// 
Function MD5(BinaryData) Export
    
    DataHashing = New DataHashing(HashFunction.MD5);
    DataHashing.Append(BinaryData);
    
    Return Lower(GetHexStringFromBinaryData(DataHashing.HashSum));
    
EndFunction

// Compute HMAC (hash-based message authentication code)
// 
// Origin: https://github.com/vbondarevsky/Connector
// Apache License 2.0 Copyright 2017-2020 Vladimir Bondarevskiy
//
// Parameters:
//   Key - BinaryData - secret key
//   Data - BinaryData - hashing data HMAC
//   HashFunction - HashFunction - hash function
//
// Returns:
//   BinaryData - result 
//
Function HMAC(Key, Data, HashFunction) Export
    
    BlockLength = 64;
    
    If Key.Size() > BlockLength Then
        DataHashing = New DataHashing(HashFunction);
        DataHashing.Append(Key);
        
        KeyBuffer = GetBinaryDataBufferFromBinaryData(DataHashing.HashSum);
    Else
        KeyBuffer = GetBinaryDataBufferFromBinaryData(Key);
    EndIf;
    
    PreparedKey = New BinaryDataBuffer(BlockLength);
    PreparedKey.Write(0, KeyBuffer);
    
    InternalKey = PreparedKey.Copy();
    ExternalKey = PreparedKey;
    
    InternalAlignment  = New BinaryDataBuffer(BlockLength);
    ExternalAlignment = New BinaryDataBuffer(BlockLength);
    For Index = 0 To BlockLength - 1 Do
        InternalAlignment.Set(Index, 54);
        ExternalAlignment.Set(Index, 92);
    EndDo;
    
    InternalDataHashing = New DataHashing(HashFunction);
    ExternalDataHashing = New DataHashing(HashFunction);
    
    InternalKey.WriteBitwiseXor(0, InternalAlignment);
    ExternalKey.WriteBitwiseXor(0, ExternalAlignment);
    
    ExternalDataHashing.Append(GetBinaryDataFromBinaryDataBuffer(ExternalKey));
    InternalDataHashing.Append(GetBinaryDataFromBinaryDataBuffer(InternalKey));
    
    If ValueIsFilled(Data) Then
        InternalDataHashing.Append(Data);
    EndIf;
    
    ExternalDataHashing.Append(InternalDataHashing.HashSum);
    
    Return ExternalDataHashing.HashSum;

EndFunction

#EndRegion