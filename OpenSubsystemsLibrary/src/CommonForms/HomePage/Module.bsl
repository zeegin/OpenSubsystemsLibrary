
&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
    
    CurrentUser = Users.CurrentUser();
    
EndProcedure

&AtClient
Procedure NotifyCommand(Command)
    
    NotifyServer();
    
EndProcedure

&AtServer
Procedure NotifyServer()
    
    Notification = New DeliverableNotification;
    Notification.Text = "Test";
    
    Telegram = DataProcessors.TelegramNotification.Create();
    Telegram.Send(Notification);
    
EndProcedure
