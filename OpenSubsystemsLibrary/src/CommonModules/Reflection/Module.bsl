#Region Public

// Returns reference to the common module or manager module by name. 
// 
// Parameters:
//     ModuleName - String - Module name.
// Returns:
//     CommonModule - Description
//
Function GetModule(ModuleName) Export
    
    If IsCommonModule(ModuleName) Then
        Try
            SetSafeMode(True);
            Module = Eval(ModuleName);
        Except
            Raise RuntimeError(StrTemplate(
                NStr("en = 'Common module <%1> not found.';
                     |ru = 'Общий модуль <%1> не найден.'"),
                ModuleName
            ));
        EndTry;
    ElsIf IsMetadataObjectManagerModule(ModuleName) Then
        Try
            SetSafeMode(True);
            Module = Eval(ModuleName);
        Except
            Raise RuntimeError(StrTemplate(
                NStr("en = 'Metadata object <%1> not found.
                           |or it does not support getting manager module.';
                     |ru = 'Объект метаданных ""%1"" не найден,
                           |либо для него не поддерживается получение модуля менеджера.'"),
                ModuleName
            ));
        EndTry;
    Else
        Raise NotImplementedError(StrTemplate(
            NStr("en = 'Not supported module type <%1>.';
                 |ru = 'Не поддерживаемый тип модуля <%1>.'"),
            ModuleName)
        );
    EndIf;
    
    Return Module;
    
EndFunction


// Invokes the procedure, using the specified parameters.
// 
// Parameters:
//     MethodName - String - The method name to be invoked.
//     Params - Array - An argument list for the invoked method. This is an array of objects with the same number,
//         order, and type as the parameters of the method to be invoked. If there are no parameters,
//         parameters should be Undefined.
//
Procedure InvokeProcedure(MethodName, Params = Undefined) Export
    
    Execute MethodName + "(" + SpreadParams(Params) + ")";
    
EndProcedure

// Invokes the Function, using the specified parameters.
// 
// Parameters:
//     MethodName - String - The method name to be invoked.
//     Params - Array - An argument list for the invoked method. This is an array of objects with the same number,
//         order, and type as the parameters of the method to be invoked. If there are no parameters,
//         parameters should be Undefined.
//
Function InvokeFunction(MethodName, Params = Undefined) Export
    
    Return Eval(MethodName + "(" + SpreadParams(Params) + ")");
    
EndFunction

#EndRegion

#Region Private

#Region GetModule

Function IsCommonModule(ModuleName)
    
    Return Metadata.CommonModules.Find(ModuleName) <> Undefined;
    
EndFunction

Function IsMetadataObjectManagerModule(ModuleName)
    
    If StrOccurrenceCount(ModuleName, ".") <> 1 Then
        Return False;
    EndIf;
    
    ModuleNameParts = StrSplit(ModuleName, ".");
    MetadataType = ModuleNameParts[0];
    MetadataObjectName = ModuleNameParts[1];
    
    If MetadataType = "ExchangePlans" Then
        MetadataFound = (Metadata.ExchangePlans.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "SettingsStorages" Then
        MetadataFound = (Metadata.SettingsStorages.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "Constants" Then
        MetadataFound = (Metadata.Constants.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "Catalogs" Then
        MetadataFound = (Metadata.Catalogs.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "Documents" Then
        MetadataFound = (Metadata.Documents.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "DocumentJournals" Then
        MetadataFound = (Metadata.DocumentJournals.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "Enums" Then
        MetadataFound = (Metadata.Enums.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "Reports" Then
        MetadataFound = (Metadata.Reports.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "DataProcessors" Then
        MetadataFound = (Metadata.DataProcessors.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "ChartsOfCharacteristicTypes" Then
        MetadataFound = (Metadata.ChartsOfCharacteristicTypes.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "ChartsOfCalculationTypes" Then
        MetadataFound = (Metadata.ChartsOfCalculationTypes.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "ChartsOfAccounts" Then
        MetadataFound = (Metadata.ChartsOfAccounts.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "InformationRegisters" Then
        MetadataFound = (Metadata.InformationRegisters.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "AccountingRegisters" Then
        MetadataFound = (Metadata.AccountingRegisters.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "AccumulationRegisters" Then
        MetadataFound = (Metadata.AccumulationRegisters.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "CalculationRegisters" Then
        MetadataFound = (Metadata.CalculationRegisters.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "BusinessProcesses" Then
        MetadataFound = (Metadata.BusinessProcesses.Find(MetadataObjectName) <> Undefined);
    ElsIf MetadataType = "Tasks" Then
        MetadataFound = (Metadata.Tasks.Find(MetadataObjectName) <> Undefined);
    Else
        MetadataFound = False;
    EndIf;
    
    Return MetadataFound;
    
EndFunction

#EndRegion

#Region Invoke

Function SpreadParams(Params)
    
    If Params = Undefined Then
        Return "";
    EndIf;
    
    ParamsParts = New Array;
    For Index = 0 To Params.UBound() Do
        ParamsParts.Add("Params[" + Index + "]");
    EndDo;
    
    Return StrConcat(ParamsParts, ",");
    
EndFunction

#EndRegion

#EndRegion