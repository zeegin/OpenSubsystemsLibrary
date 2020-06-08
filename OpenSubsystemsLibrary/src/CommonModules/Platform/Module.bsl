#Region Public

// True, if current client platform is Windows.
// 
// Returns:
//     Boolean
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
//     Boolean
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
//     Boolean
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
//     Boolean
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
//     Boolean
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
//     Boolean
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
//     Boolean
//
Function IsFileMode() Export
    
#If Server Then
    Return StrFind(Upper(InfoBaseConnectionString()), "FILE=") = 1;
#Else
    Return AppSettings["ServerContext"]["IsFileMode"];
#EndIf
    
EndFunction

#EndRegion
