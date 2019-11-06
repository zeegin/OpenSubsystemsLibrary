#Region Public

// Description
// 
// Returns:
//     CatalogRef.Users - Description
//
Function CurrentUser() Export
    
    SetPrivilegedMode(True);
    Ref = SessionParameters.CurrentUser;
    SetPrivilegedMode(False);
    
    Return Ref;
    
EndFunction

// Description
// 
Procedure SessionInit() Export
    
    UserObject = _CurrentUser();
    
    SetPrivilegedMode(True);
    SessionParameters.CurrentUser = UserObject.Ref;
    SetPrivilegedMode(False);
    
EndProcedure

#EndRegion

#Region Private

Function _CurrentUser()
    
    CurrentInfoBaseUser = InfoBaseUsers.CurrentUser();
    
    If IsBlankString(CurrentInfoBaseUser.Name) Then
        Self = _DefaultUserObject();
    Else    
        Self = _InfoBaseUserObject(CurrentInfoBaseUser);
    EndIf;
         
    Return Self;
    
EndFunction

Function _UserObject()
    
    Self = New Structure;
    Self.Insert("Ref", Undefined);
    Self.Insert("FullName", "");
    Self.Insert("UUID", Undefined);
    Self.Insert("Service", False);
    
    Return Self;
    
EndFunction

Function _DefaultUserObject()
    
    Self = _UserObject();
    Self.Ref = Catalogs.Users._DefaultUserRef();
    Self.FullName = NStr("en = '<Not specified>'; ru = '<Не указан>'");
    Self.Service = True;
    
    If Not Database.Exists(Self.Ref) Then
        Catalogs.Users._CreateBy(Self);
    EndIf;
    
    Return Self;
    
EndFunction

Function _InfoBaseUserObject(InfoBaseUser)
    
    Self = _UserObject();
    Self.Ref = Catalogs.Users._FindByUUID(InfoBaseUser.UUID);
    Self.FullName = InfoBaseUser.FullName;
    Self.UUID = InfoBaseUser.UUID;
    
    If Self.Ref.IsEmpty() Then
        Self.Ref = Catalogs.Users._CreateBy(Self);
    EndIf;
    
    Return Self;
    
EndFunction

#EndRegion