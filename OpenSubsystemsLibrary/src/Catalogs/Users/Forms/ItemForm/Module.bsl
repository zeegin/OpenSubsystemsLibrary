
#Region Events

&AtServer
Procedure OnReadAtServer(CurrentObject)
    
    If CurrentObject._Service Then
        ThisObject.Enabled = False;
    EndIf;
    
    InfoBaseUser = InfoBaseUsers.FindByUUID(CurrentObject._UUID);
    
    If InfoBaseUser <> Undefined Then
        FillPropertyValues(ThisObject, InfoBaseUser);
    EndIf;
    
    Items.RunMode.Visible = (RunMode <> "Auto");
    Items.DefaultInterface.Visible = ValueIsFilled(DefaultInterface);
    
EndProcedure

&AtServer
Procedure OnWriteAtServer(Cancel, CurrentObject, WriteParameters)
    
    InfoBaseUser = InfoBaseUsers.FindByUUID(CurrentObject._UUID);
    
    If InfoBaseUser <> Undefined Then 
        InfoBaseUser.Write();
    EndIf;
    
EndProcedure

&AtClient
Procedure RunModeClearing(Item, StandardProcessing)
    
    RunMode = "Auto";
    StandardProcessing = False;
    
EndProcedure

#EndRegion