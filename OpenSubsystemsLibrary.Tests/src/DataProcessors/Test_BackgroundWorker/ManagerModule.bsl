#Region Public

Procedure ProcedurePing(Payload) Export
    
    // This Mock method is used in Test_BackgroundWorker unit test
    
    Payload = "Pong";
    
EndProcedure

Procedure ProcedurePingMessage() Export
    
    // This Mock method is used in Test_BackgroundWorker unit test
    
    UserMessage = New UserMessage;
    UserMessage.Text = "Pong";
    UserMessage.Message();
    
EndProcedure

#EndRegion