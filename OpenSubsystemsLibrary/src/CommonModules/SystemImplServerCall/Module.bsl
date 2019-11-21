#Region Private

Function ExchangeClientServerContext(ClientContext) Export
    
    SessionParameters.ClientContext = New FixedMap(ClientContext);
    Return New FixedMap(ServerContext());
    
EndFunction

Function ServerContext()
    
    Self = New Map;
    Self.Insert("IsFileMode", Platform.IsFileMode());
    
    Return Self;
    
EndFunction

#EndRegion