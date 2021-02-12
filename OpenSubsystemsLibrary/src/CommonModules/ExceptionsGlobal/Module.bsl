#Region Public

// Prefer to use in case of realy troubles, when program would not support the wrong behavior. 
// 
// Parameters:
//  Message - String - message of exception
// 
// Returns:
//  String - result exception text
// 
// Example:
//  Raise RuntimeError();
//  Raise RuntimeError(NStr("en = 'Someone trouble...'")); 
// 
Function RuntimeError(Message = "") Export
    
    Return NewError("[RuntimeError]", Message);
    
EndFunction

// Prefer to use in case of some convertation or not supported type of params error. 
// 
// Parameters:
//  Message - String - message of exception
// 
// Returns:
//  String - result exception text
// 
// Example:
//  Raise TypeError();
//  Raise TypeError(NStr("en = 'Type dont support...'")); 
// 
Function TypeError(Message = "") Export
    
    Return NewError("[TypeError]", Message);
    
EndFunction

// Used in case of assertion, when need to campare expected (by developer) and actual (by program) values.
// 
// Parameters:
//  Expected - String - expected
//  Actual - String - actual value
//  Message - String - message of exception
// 
// Returns:
//  String - result exception text
// 
// Example:
//  Raise AssertError(1, 2);
//  Raise AssertError(1, 2, NStr("en = 'Detailed assertion information...'")); 
// 
Function AssertError(Expected, Actual, Message = "") Export
    
    ErrorText = StrTemplate(
        "[AssertError]
        |[Expected]
        |%1
        |[Actual]
        |%2",
        Expected,
        Actual
    );
    
    If IsBlankString(Message) Then
        Return ErrorText;
    Else
        Return ErrorText + Chars.LF + "[Message]" + Chars.LF + Message;
    EndIf;
    
EndFunction

// Prefer to use in case of some behaviors that is not implemented yet. 
// 
// Parameters:
//  Message - String - message of exception
// 
// Returns:
//  String - result exception text
// 
// Example:
//  Raise NotImplementedError();
//  Raise NotImplementedError(NStr("en = 'You will see this feature soon...'")); 
// 
Function NotImplementedError(Message = "") Export 
    
    Return NewError("[NotImplementedError]", Message);
    
EndFunction

#EndRegion

#Region Private

Function NewError(ErrorTextPrefix, Message = "")
    
    If IsBlankString(Message) Then
        Return ErrorTextPrefix;
    Else
        Return ErrorTextPrefix + Chars.LF + Message;
    EndIf;
    
EndFunction

#EndRegion