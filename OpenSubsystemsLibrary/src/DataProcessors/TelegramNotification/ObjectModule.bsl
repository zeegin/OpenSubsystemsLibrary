
Var _Token;
Var SubscriberID;


Procedure Send(Notification) Export 
    
    URL = StrTemplate("https://api.telegram.org/bot%1/sendMessage", _Token);
    
    Query = New Structure;
    Query.Insert("chat_id", SubscriberID);
    Query.Insert("text", Notification.Text);
    Query.Insert("parse_mode", "HTML");
    
    Result = HTTPRequests.Get(URL, Query);
    Result.RaiseForStatus();
    
EndProcedure


_Token = "881785435:AAFmi5bqdWPRuN2yFryqvYBhQTM-MU9MARY";
SubscriberID = "@osl_test";
