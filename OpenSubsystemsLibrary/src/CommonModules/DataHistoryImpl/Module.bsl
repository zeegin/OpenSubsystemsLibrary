#Region Private

Procedure _UpdateDataHistory() Export
    
#If Not MobileAppServer Then
    DataHistory.UpdateHistory();
#EndIf
    
EndProcedure

#EndRegion
