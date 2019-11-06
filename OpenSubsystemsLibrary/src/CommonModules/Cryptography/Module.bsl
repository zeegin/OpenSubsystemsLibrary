#Region Public

Function MD5(BinaryData) Export
    
    DataHashing = New DataHashing(HashFunction.MD5);
    DataHashing.Append(BinaryData);
    
    Return Lower(GetHexStringFromBinaryData(DataHashing.HashSum));
    
EndFunction

#EndRegion