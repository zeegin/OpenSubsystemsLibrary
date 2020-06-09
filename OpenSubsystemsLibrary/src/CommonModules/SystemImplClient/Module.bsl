#Region Private

Procedure BeforeStart(Cancel) Export
    
    ServerContext = SystemImplServerCall.ExchangeClientServerContext(ClientContext());
    
    AppSettings = New Map;
    AppSettings.Insert("ServerContext", ServerContext);
    
EndProcedure

Function ClientContext()
    
    Self = New Map;
    Self.Insert("IsWindowsClient", Platform.IsWindowsClient());
    Self.Insert("IsLinuxClient", Platform.IsLinuxClient());
    Self.Insert("IsMacOSClient", Platform.IsMacOSClient());
    
    Return Self;
    
EndFunction

#EndRegion