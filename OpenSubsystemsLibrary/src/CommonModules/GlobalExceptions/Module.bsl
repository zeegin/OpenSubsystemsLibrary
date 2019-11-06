#Region Public

Function RuntimeError(Message = "") Export
    
    Return "[RuntimeError] " + Message;
    
EndFunction

Function TypeError(Message = "") Export
    
    Return "[TypeError] " + Message;
    
EndFunction

Function AssertError(Message = "") Export
    
    Return "[AssertError] " + Message;
    
EndFunction

Function NotImplementedError(Message = "") Export 
    
    Return "[NotImplementedError] " + Message;
    
EndFunction

#EndRegion
