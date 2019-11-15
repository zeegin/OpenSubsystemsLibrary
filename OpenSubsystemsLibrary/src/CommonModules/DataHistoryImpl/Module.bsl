#Region Private

Procedure UpdateDataHistory() Export
    
#If Not MobileAppServer Then
    DataHistory.UpdateHistory();
#EndIf
    
EndProcedure

#EndRegion
