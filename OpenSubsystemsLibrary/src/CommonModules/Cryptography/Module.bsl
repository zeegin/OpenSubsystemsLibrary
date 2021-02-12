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

#EndRegion