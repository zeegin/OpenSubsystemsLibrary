#Region Private

Function DefaultUserRef() Export
    
    Return Catalogs.Users.GetRef(New UUID("aa00559e-ad84-4494-88fd-f0826edc46f0"));
    
EndFunction

Function FindByUUID(UUID) Export
    
    Query = New Query;
    Query.Parameters.Insert("UUID", UUID);
    
    Query.Text = 
        "SELECT TOP 1
        |    Users.Ref AS Ref
        |FROM
        |    Catalog.Users AS Users
        |WHERE
        |    Users._UUID = &UUID";
    
    Selection = Query.Execute().Select();
    If Selection.Next() Then
        Return Selection.Ref;
    EndIf;
    
    Return Catalogs.Users.EmptyRef();
    
EndFunction

Function CreateBy(UserObject) Export
    
    Self = Catalogs.Users.CreateItem();
    Self.SetNewObjectRef(UserObject.Ref);
    Self.Description = UserObject.FullName;
    Self._UUID = UserObject.UUID;
    Self._Service = UserObject.Service;
    Self.Write();
    
    Return Self.Ref;
    
EndFunction

#EndRegion
