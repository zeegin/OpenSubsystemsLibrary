// BSLLS:CommonModuleNameWords-off
// BSLLS:PublicMethodsDescription-off
// BSLLS:Typo-off

// This mock module is used in unit tests:
// - Test_GetDataProcessorManagerModule
//

#Region Public

Procedure ProcedurePing(Payload) Export
    
    // This Mock method is used in Test_InvokeProcedureDataProcessorManagerModuleWithParams unit test
    
    Payload = "Pong";
    
EndProcedure

Procedure ProcedurePingMessage() Export
    
    // This Mock method is used in Test_InvokeProcedureDataProcessorManagerModuleWithoutParams unit test
    
    UserMessage = New UserMessage;
    UserMessage.Text = "Pong";
    UserMessage.Message();
    
EndProcedure

Function FunctionPing(Payload) Export
    
    // This Mock method is used in Test_InvokeFunctionDataProcessorManagerModuleWithParams unit test
    
    Return Payload;
    
EndFunction

Function FunctionPingNoParam() Export
    
    // This Mock method is used in Test_InvokeFunctionDataProcessorManagerModuleWithoutParams unit test
    
    Return "Pong";
    
EndFunction

#EndRegion