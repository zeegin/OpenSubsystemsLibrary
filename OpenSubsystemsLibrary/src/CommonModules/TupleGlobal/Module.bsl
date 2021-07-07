#Region Public

// Create tuple of given items
// 
// Parameters:
//  Item1 - Any
//  Item2 - Any
//  Item3 - Any
//  Item4 - Any
//  Item5 - Any
//  Item6 - Any
//  Item7 - Any
//  Item8 - Any
//  Item9 - Any
//  Item10 - Any
// 
// Returns:
//  FixedArray - Tuple
// 
// Example:
//  Tuple = Tuple(0, "Val");
//  // Tuple[0]  0
//  // Tuple[1]  "Val"
//
Function Tuple(Item1, Item2, Item3 = Null, Item4 = Null, Item5 = Null,
    Item6 = Null, Item7 = Null, Item8 = Null, Item9 = Null, Item10 = Null) Export
    
    Result = New Array();
    
    For index = 1 To 10 Do
        
        Collections.AddNonNullValue(Result, Eval(StrTemplate("item%1", index)));
        
    EndDo;
    
    Return New FixedArray(Result);
    
EndFunction

// Detuple given tuple
// 
// Parameters:
//  Tuple - see TupleGlobal.Tuple - Tuple
//  Item1 - String - Name of 1 value of tuple
//  Item2 - String - Name of 2 value of tuple
//  Itme3 - String - Name of 3 value of tuple
//  Item4 - String - Name of 4 value of tuple
//  Item5 - String - Name of 5 value of tuple
//  Item6 - String - Name of 6 value of tuple
//  Item7 - String - Name of 7 value of tuple
//  Item8 - String - Name of 8 value of tuple
//  Item9 - String - Name of 9 value of tuple
//  Item10 - String - Name of 10 value of tuple
// 
// Returns:
//  FixedStructure - Detupled tuple
//
// Example:
//  Tuple = Tuple(0, "val");
//  Result = Detuple(Tuple);
//  // Result.Item1  0
//  // Result.Item2  "val"
//  
//  Result = Detuple(Tuple, "Key", "Value")
//  // Result.Key    0
//  // Result.Value  "val"
//
Function Detuple(Tuple, Item1 = "", Item2 = "", Itme3 = "", Item4 = "",
    Item5 = "", Item6 = "", Item7 = "", Item8 = "", Item9 = "", Item10 = "") Export
    
    Result = New Structure();
    
    For index = 0 To Tuple.UBound() Do

        ItemName = StrTemplate("Item%1", index + 1);
        AssignedItemName = Eval(ItemName);

        Result.Insert(
            ?(IsBlankString(AssignedItemName), ItemName, AssignedItemName),
            Tuple[index]
        );
        
    EndDo;
    
    Return New FixedStructure(Result);
    
EndFunction

#EndRegion
