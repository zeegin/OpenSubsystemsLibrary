#Region GetModule


// @unit-test
Procedure Test_GetCommonModule(Context) Export
    
    Module = Reflection.GetModule("Test_Reflection_MockModule");
    
    Assert.IsInstanceOfType(Type("CommonModule"), Module);
    
EndProcedure

// @unit-test
Procedure Test_GetDataProcessorManagerModule(Context) Export
    
    Module = Reflection.GetModule("DataProcessors.Test_Reflection_MockDataProcess");
    
    Assert.IsInstanceOfType(Type("DataProcessorManager.Test_Reflection_MockDataProcess"), Module);
    
EndProcedure

// @unit-test
Procedure Test_GetNotFoundCommonModule(Context) Export
    
    Try
        Reflection.GetModule("Test_Reflection_MockModuleClient");
    Except
        Assert.IsLegalException("[RuntimeError]", ErrorInfo());
    EndTry;
    
EndProcedure

// @unit-test
Procedure Test_GetNotSupportedModule(Context) Export
    
    Try
        Reflection.GetModule("DataProcessors.Test_Reflection_MockDataProcess.SomethingElse");
    Except
        Assert.IsLegalException("[NotImplementedError]", ErrorInfo());
    EndTry;
    
EndProcedure

#EndRegion

#Region InvokeProcedure

// @unit-test
Procedure Test_InvokeProcedureCommonModuleWithoutParams(Context) Export
    
    Reflection.InvokeProcedure("Test_Reflection_MockModule.ProcedurePingMessage");
    
    Assert.AreUserMessagesContains("Pong");
    
    GetUserMessages(True);
    
EndProcedure

// @unit-test
Procedure Test_InvokeProcedureCommonModuleWithParams(Context) Export
    
    Params = New Array;
    Params.Add(Undefined);
    
    Reflection.InvokeProcedure("Test_Reflection_MockModule.ProcedurePing", Params);
    
    Assert.AreEqual("Pong", Params[0]);
    
EndProcedure

// @unit-test
Procedure Test_InvokeProcedureDataProcessorManagerModuleWithoutParams(Context) Export
    
    Reflection.InvokeProcedure("DataProcessors.Test_Reflection_MockDataProcess.ProcedurePingMessage");
    
    Assert.AreUserMessagesContains("Pong");
    
    GetUserMessages(True);
    
EndProcedure

// @unit-test
Procedure Test_InvokeProcedureDataProcessorManagerModuleWithParams(Context) Export
    
    Params = New Array;
    Params.Add(Undefined);
    
    Reflection.InvokeProcedure("DataProcessors.Test_Reflection_MockDataProcess.ProcedurePing", Params);
    
    Assert.AreEqual("Pong", Params[0]);
    
EndProcedure

#EndRegion

#Region InvokeFunction

// @unit-test
Procedure Test_InvokeFunctionCommonModuleWithoutParams(Context) Export
    
    Result = Reflection.InvokeFunction("Test_Reflection_MockModule.FunctionPingNoParam");
    
    Assert.AreEqual("Pong", Result);
    
EndProcedure

// @unit-test
Procedure Test_InvokeFunctionCommonModuleWithParams(Context) Export
    
    Params = New Array;
    Params.Add("Pong");
    
    Result = Reflection.InvokeFunction("Test_Reflection_MockModule.FunctionPing", Params);
    
    Assert.AreEqual("Pong", Result);
    
EndProcedure

// @unit-test
Procedure Test_InvokeFunctionDataProcessorManagerModuleWithoutParams(Context) Export
    
    Result = Reflection.InvokeFunction("DataProcessors.Test_Reflection_MockDataProcess.FunctionPingNoParam");
    
    Assert.AreEqual("Pong", Result);
    
EndProcedure

// @unit-test
Procedure Test_InvokeFunctionDataProcessorManagerModuleWithParams(Context) Export
    
    Params = New Array;
    Params.Add("Pong");
    
    Result = Reflection.InvokeFunction("DataProcessors.Test_Reflection_MockDataProcess.FunctionPing", Params);
    
    Assert.AreEqual("Pong", Result);
    
EndProcedure

#EndRegion
