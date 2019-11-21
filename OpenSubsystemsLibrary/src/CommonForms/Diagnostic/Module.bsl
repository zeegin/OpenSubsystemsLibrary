#Region FormEventHandlers

&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
    
    CurrentUser = Users.CurrentUser();
    
    IsWindowsClientAtServer = Platform.IsWindowsClient();
    IsLinuxClientAtServer = Platform.IsLinuxClient();
    IsMacOSClientAtServer = Platform.IsMacOSClient();
    IsFileModeAtServer = Platform.IsFileMode();
    
EndProcedure

&AtClient
Procedure OnOpen(Cancel)
    
    IsWindowsClientAtClient = Platform.IsWindowsClient();
    IsLinuxClientAtClient = Platform.IsLinuxClient();
    IsMacOSClientAtClient = Platform.IsMacOSClient();
    IsFileModeAtClient = Platform.IsFileMode();
    
EndProcedure

#EndRegion
