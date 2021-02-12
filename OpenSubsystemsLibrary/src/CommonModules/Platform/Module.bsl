#Region Public

// True, if current client platform is Windows.
// 
// Returns:
//     Boolean - result
//
Function IsWindowsClient() Export 
    
#If Server Then
    Return SessionParameters.ClientContext.Get("IsWindowsClient");
#Else
    SysInfo = New SystemInfo();
    Return SysInfo.PlatformType = PlatformType.Windows_x86
        Or SysInfo.PlatformType = PlatformType.Windows_x86_64;
#EndIf
    
EndFunction

// True, if current server platform is Windows.
// 
// Returns:
//     Boolean - result
//
&AtServer
Function IsWindowsServer() Export
    
    SysInfo = New SystemInfo();
    Return SysInfo.PlatformType = PlatformType.Windows_x86
        Or SysInfo.PlatformType = PlatformType.Windows_x86_64;
    
EndFunction

// True, if current client platform is Linux.
// 
// Returns:
//     Boolean - result
//
Function IsLinuxClient() Export 
    
#If Server Then
    Return SessionParameters.ClientContext.Get("IsLinuxClient");
#Else
    SysInfo = New SystemInfo();
    Return SysInfo.PlatformType = PlatformType.Linux_x86
        Or SysInfo.PlatformType = PlatformType.Linux_x86_64;
#EndIf
    
EndFunction

// True, if current server platform is Linux.
// 
// Returns:
//     Boolean - result
//
&AtServer
Function IsLinuxServer() Export
    
    SysInfo = New SystemInfo();
    Return SysInfo.PlatformType = PlatformType.Linux_x86
        Or SysInfo.PlatformType = PlatformType.Linux_x86_64;
    
EndFunction

// True, if current client platform is macOS.
// 
// Returns:
//     Boolean - result
//
Function IsMacOSClient() Export 
    
#If Server Then
    Return SessionParameters.ClientContext.Get("IsMacOSClient");
#Else
    SysInfo = New SystemInfo();
    Return SysInfo.PlatformType = PlatformType.MacOS_x86
        Or SysInfo.PlatformType = PlatformType.MacOS_x86_64;
#EndIf
    
EndFunction

// True, if current server platform is macOS.
// 
// Returns:
//     Boolean - result
//
&AtServer
Function IsMacOSServer() Export
    
    SysInfo = New SystemInfo();
    Return SysInfo.PlatformType = PlatformType.MacOS_x86
        Or SysInfo.PlatformType = PlatformType.MacOS_x86_64;
    
EndFunction

// True, if current runtime is file mode.
// 
// Returns:
//     Boolean - result
//
Function IsFileMode() Export
    
#If Server Then
    Return StrFind(Upper(InfoBaseConnectionString()), "FILE=") = 1;
#Else
    Return AppSettings["ServerContext"]["IsFileMode"];
#EndIf
    
EndFunction

#EndRegion
