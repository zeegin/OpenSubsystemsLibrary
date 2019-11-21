#Region Public

Function IsWindowsClient() Export 
    
#If Server Then
    Return SessionParameters.ClientContext.Get("IsWindowsClient");
#Else
    SysInfo = New SystemInfo();
    Return SysInfo.PlatformType = PlatformType.Windows_x86
        Or SysInfo.PlatformType = PlatformType.Windows_x86_64;
#EndIf
    
EndFunction

Function IsLinuxClient() Export 
    
#If Server Then
    Return SessionParameters.ClientContext.Get("IsLinuxClient");
#Else
    SysInfo = New SystemInfo();
    Return SysInfo.PlatformType = PlatformType.Linux_x86
        Or SysInfo.PlatformType = PlatformType.Linux_x86_64;
#EndIf
    
EndFunction

Function IsMacOSClient() Export 
    
#If Server Then
    Return SessionParameters.ClientContext.Get("IsMacOSClient");
#Else
    SysInfo = New SystemInfo();
    Return SysInfo.PlatformType = PlatformType.MacOS_x86
        Or SysInfo.PlatformType = PlatformType.MacOS_x86_64;
#EndIf
    
EndFunction

Function IsFileMode() Export
    
#If Server Then
    Return StrFind(Upper(InfoBaseConnectionString()), "FILE=") = 1;
#Else
    Return AppSettings["ServerContext"]["IsFileMode"];
#EndIf
    
EndFunction

#EndRegion
