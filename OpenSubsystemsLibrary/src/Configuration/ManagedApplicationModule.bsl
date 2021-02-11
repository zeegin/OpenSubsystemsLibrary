// BSLLS:ExportVariables-off

#Region Variables

// Used for store application settings.
// For example: server context at client or cashed client settings.
//
Var AppSettings Export;

#EndRegion

#Region EventHandlers

Procedure BeforeStart(Cancel)
    
    SystemImplClient.BeforeStart(Cancel);
    
EndProcedure

#EndRegion