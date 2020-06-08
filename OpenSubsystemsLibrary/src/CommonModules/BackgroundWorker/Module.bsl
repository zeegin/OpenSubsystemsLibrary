// BSLLS:NumberOfParams-off

#Region Public

&AtServer
Function RunParams(UUID) Export
    
    Self = New Structure;
    Self.Insert("UUID", UUID);
    
    Return Self;
    
EndFunction

&AtServer
Function RunFunctionAsync(
        RunParams,
        MethodName,
        Param1 = Undefined,
        Param2 = Undefined,
        Param3 = Undefined,
        Param4 = Undefined,
        Param5 = Undefined,
        Param6 = Undefined,
        Param7 = Undefined
    ) Export
    
    Worker = New UUID();
    Return Worker;
    
EndFunction

&AtServer
Function RunProcedureAsync(
        RunParams,
        MethodName,
        Param1 = Undefined,
        Param2 = Undefined,
        Param3 = Undefined,
        Param4 = Undefined,
        Param5 = Undefined,
        Param6 = Undefined,
        Param7 = Undefined
    ) Export
    
    Worker = New UUID();
    Return Worker;
    
EndFunction

Procedure CancelAsync(Worker) Export
    
    
    
EndProcedure

Procedure IsCompleted(Worker) Export
    
EndProcedure

&AtServer
Procedure ReportProgress(ReportID, ProgressPercentage, UserState = Undefined) Export
    
EndProcedure

&AtClient
Procedure OnProgressChanged(Worker, EventHandler) Export
    
EndProcedure

&AtClient
Procedure OnRunWorkerCompleted(Worker, EventHandler) Export
    
    // ExecuteNotifyProcessing()
    
EndProcedure

&AtClient
Procedure ShowProgressBar(Worker) Export
    
EndProcedure

#EndRegion

#Region Private

&AtServer
Function BuildParamsArray(
        Param1 = Undefined,
        Param2 = Undefined,
        Param3 = Undefined,
        Param4 = Undefined,
        Param5 = Undefined,
        Param6 = Undefined,
        Param7 = Undefined
    )
    
    PassedParams = New Array;
    PassedParams.Add(Param7);
    PassedParams.Add(Param6);
    PassedParams.Add(Param5);
    PassedParams.Add(Param4);
    PassedParams.Add(Param3);
    PassedParams.Add(Param2);
    PassedParams.Add(Param1);
    
    Self = New Array;
    For Each Param In PassedParams Do
        If Self.Count() = 0 And Param = Undefined Then
            Continue;
        EndIf;
        Self.Insert(0, Param);
    EndDo;
    
    Return Self;
    
EndFunction

&AtServer
Function RunAsync(RunParams, MethodName, Params = Undefined)
    
    Worker = New UUID();
    Return Worker;
    
EndFunction

#EndRegion