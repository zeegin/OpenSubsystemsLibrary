// This mock module is used in unit tests:
// - Test_GetCommonModule
//

#Region Public

Procedure ProcedurePing(Payload) Export
    
    // This Mock method is used in Test_InvokeProcedureCommonModuleWithoutParams unit test
    
    Payload = "Pong";
    
EndProcedure

Procedure ProcedurePingMessage() Export
    
    // This Mock method is used in Test_InvokeProcedureCommonModuleWithParams unit test
    
    UserMessage = New UserMessage;
    UserMessage.Text = "Pong";
    UserMessage.Message();
    
EndProcedure

Function FunctionPing(Payload) Export
    
    // This Mock method is used in Test_InvokeProcedureCommonModuleWithParams unit test
    
    Return Payload;
    
EndFunction

Function FunctionPingNoParam() Export
    
    // This Mock method is used in Test_InvokeProcedureCommonModuleWithoutParams unit test
    
    Return "Pong";
    
EndFunction

#EndRegion