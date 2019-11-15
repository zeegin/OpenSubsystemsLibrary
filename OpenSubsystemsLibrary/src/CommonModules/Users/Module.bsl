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
    
    UserObject = CurrentUserObject();
    
    SetPrivilegedMode(True);
    SessionParameters.CurrentUser = UserObject.Ref;
    SetPrivilegedMode(False);
    
EndProcedure

#EndRegion

#Region Private

Function CurrentUserObject()
    
    CurrentInfoBaseUser = InfoBaseUsers.CurrentUser();
    
    If IsBlankString(CurrentInfoBaseUser.Name) Then
        Self = DefaultUserObject();
    Else    
        Self = InfoBaseUserObject(CurrentInfoBaseUser);
    EndIf;
         
    Return Self;
    
EndFunction

Function UserObject()
    
    Self = New Structure;
    Self.Insert("Ref", Undefined);
    Self.Insert("FullName", "");
    Self.Insert("UUID", Undefined);
    Self.Insert("Service", False);
    
    Return Self;
    
EndFunction

Function DefaultUserObject()
    
    Self = UserObject();
    Self.Ref = Catalogs.Users.DefaultUserRef();
    Self.FullName = NStr("en = '<Not specified>'; ru = '<Не указан>'");
    Self.Service = True;
    
    If Not Database.Exists(Self.Ref) Then
        Catalogs.Users.CreateBy(Self);
    EndIf;
    
    Return Self;
    
EndFunction

Function InfoBaseUserObject(InfoBaseUser)
    
    Self = UserObject();
    Self.Ref = Catalogs.Users.FindByUUID(InfoBaseUser.UUID);
    Self.FullName = InfoBaseUser.FullName;
    Self.UUID = InfoBaseUser.UUID;
    
    If Self.Ref.IsEmpty() Then
        Self.Ref = Catalogs.Users.CreateBy(Self);
    EndIf;
    
    Return Self;
    
EndFunction

#EndRegion