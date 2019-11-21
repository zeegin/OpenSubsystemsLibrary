#Region FormCommandsEventHandlers

&AtClient
Procedure RunProcedure(Command)
    
    Worker = RunProcedureAsync();
    
    EventHandler = New NotifyDescription("OnProgressChanged", ThisObject);
    BackgroundWorker.OnProgressChanged(Worker, EventHandler);
    
    EventHandler = New NotifyDescription("OnRunWorkerCompleted", ThisObject);
    BackgroundWorker.OnRunWorkerCompleted(Worker, EventHandler);
    
EndProcedure

&AtClient
Procedure RunProcedureWithProgress(Command)
    
    Worker = RunProcedureAsync();
    BackgroundWorker.ShowProgressBar(Worker);
    
EndProcedure

#EndRegion

#Region Private

&AtServer
Function RunProcedureAsync()
    
    Worker = BackgroundWorker.RunProcedureAsync(
        BackgroundWorker.RunParams(UUID),
        "DataProcessors.Test_BackgroundWorker.ProcedurePingMessage"
    );
    Return Worker;
    
EndFunction

&AtClient
Procedure OnProgressChanged(Result, Context) Export
    
EndProcedure

&AtClient
Procedure OnRunWorkerCompleted(Result, Context) Export
    
EndProcedure

#EndRegion