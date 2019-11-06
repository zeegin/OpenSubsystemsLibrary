#Region Public

// Description
// 
// Parameters:
//     String - String - Description
//     Separator - String - Description
// Returns:
//     Array contains String - Description
//
Function SplitTrimAll(String, Separator) Export
    
    Result = StrSplit(String, Separator);
    For Cursor = 0 To Result.UBound() Do
        Result[Cursor] = TrimAll(Result[Cursor]);
    EndDo;
    
    Return Result;
    
EndFunction

#EndRegion
