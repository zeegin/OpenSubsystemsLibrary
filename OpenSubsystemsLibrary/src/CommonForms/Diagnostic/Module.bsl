#Region FormEventHandlers

&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
    
    CurrentUser = Users.CurrentUser();
    
    IsWindowsClientAtServer = Platform.IsWindowsClient();
    IsLinuxClientAtServer = Platform.IsLinuxClient();
    IsMacOSClientAtServer = Platform.IsMacOSClient();
    IsFileModeAtServer = Platform.IsFileMode();
    IsWindowsServer = Platform.IsWindowsServer();
    IsLinuxServer = Platform.IsLinuxServer();
    IsMacOSServer = Platform.IsMacOSServer();
    
EndProcedure

&AtClient
Procedure OnOpen(Cancel)
    
    IsWindowsClientAtClient = Platform.IsWindowsClient();
    IsLinuxClientAtClient = Platform.IsLinuxClient();
    IsMacOSClientAtClient = Platform.IsMacOSClient();
    IsFileModeAtClient = Platform.IsFileMode();
    
EndProcedure

#EndRegion
