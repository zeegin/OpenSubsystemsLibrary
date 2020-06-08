#Region Variables

// Used for stare application settings.
// For example: server context at client or cashed client settings.
//
Var AppSettings Export;

#EndRegion

#Region EventHandlers

Procedure BeforeStart(Cancel)
    
    SystemImplClient.BeforeStart(Cancel);
    
EndProcedure

#EndRegion