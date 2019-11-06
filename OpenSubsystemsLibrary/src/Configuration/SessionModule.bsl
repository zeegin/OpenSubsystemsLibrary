
#Region EventHandlers

Procedure SessionParametersSetting(RequiredParameters)
    
    If RequiredParameters = Undefined Then  // On start session.
        Return;
    EndIf;
    
    If Collections.Contains(RequiredParameters, "CurrentUser") Then
        Users.SessionInit();
    EndIf;
    
EndProcedure

#EndRegion