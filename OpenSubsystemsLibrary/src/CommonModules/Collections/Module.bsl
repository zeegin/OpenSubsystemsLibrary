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

// Check the collection to use in foreach k-v loops.
// 
// Parameters:
//  Self - Structure, FixedStructure, Map, FixedMap - collection
// 
// Returns:
//  Boolean - result checking
// 
Function IsDictionary(Self) Export
    
    Return TypeOf(Self) = Type("Structure")
        Or TypeOf(Self) = Type("FixedStructure")
        Or TypeOf(Self) = Type("Map")
        Or TypeOf(Self) = Type("FixedMap");
    
EndFunction

// Adding non Null value to collection
// 
// Parameters:
//  Self - Array, FixedArray - collection
//  Value - Any - value to add
//
Procedure AddNonNullValue(Self, Value) Export

    If Value <> Null Then
        Self.Add(Value);
    EndIf;

EndProcedure

#EndRegion
