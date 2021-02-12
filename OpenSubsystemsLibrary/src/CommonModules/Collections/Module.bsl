#Region Public

// Check the value contains in collection
// 
// Parameters:
//  Self - Array, FixedArray - collection
//  Value - Arbitrary - checking value
// 
// Returns:
//  Boolean - result checking
// 
Function Contains(Self, Value) Export
    
    If TypeOf(Self) = Type("Array")
        Or TypeOf(Self) = Type("FixedArray") Then
        
        Return Self.Find(Value) <> Undefined;
    EndIf;
    
    Raise TypeError("Not a collection.");
    
EndFunction

#EndRegion
