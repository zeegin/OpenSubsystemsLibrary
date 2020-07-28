#Region Public

Procedure AreEqual(Expected, Actual, Message = "") Export
    
    If Expected <> Actual Then
        Raise AssertError(Expected, Actual, Message);
    EndIf;
    
EndProcedure

Procedure AreNotEqual(NotExpected, Actual, Message = "") Export
    
    If NotExpected = Actual Then
        Raise AssertError(NotExpected, Actual, Message);
    EndIf;
    
EndProcedure

Procedure IsTrue(Condition, Message = "") Export
    
    If Not Condition Then
        Raise AssertError(True, Condition, Message);
    EndIf;
    
EndProcedure

Procedure IsFalse(Condition, Message = "") Export
    
    If Condition Then
        Raise AssertError(False, Not Condition, Message);
    EndIf;
    
EndProcedure

Procedure IsInstanceOfType(ExpectedType, Value, Message = "") Export
    
    If TypeOf(Value) <> Type(ExpectedType) Then
        Raise AssertError(Type(ExpectedType), TypeOf(Value), Message);
    EndIf;
    
EndProcedure

Procedure IsUndefined(Value, Message = "") Export
    
    If Value <> Undefined Then
        Raise AssertError(Undefined, Value, Message);
    EndIf;
    
EndProcedure

Procedure IsNotUndefined(Value, Message = "") Export
    
    If Value = Undefined Then
        Raise AssertError(Undefined, Value, Message);
    EndIf;
    
EndProcedure

Procedure IsNull(Value, Message = "") Export
    
    If Value <> Null Then
        Raise AssertError(Null, Value, Message);
    EndIf;
    
EndProcedure

Procedure IsNotNull(Value, Message = "") Export
    
    If Value = Null Then
        Raise AssertError(Null, Value, Message);
    EndIf;
    
EndProcedure

Procedure IsLegalException(LegalErrorFragment, ErrorInfo, Message = "") Export 
    
    ErrorDescription = DetailErrorDescription(ErrorInfo);
    
    If Not StrFind(ErrorDescription, LegalErrorFragment) Then
        Raise AssertError(LegalErrorFragment, ErrorDescription, Message);
    EndIf;
    
EndProcedure

Procedure AreCollectionEmpty(Value, Message = "") Export
    
    If Value.Count() <> 0 Then 
        Raise AssertError(
            NStr("ru = 'Не пустая коллекция.'; en = 'Collection isn't empty.'"),
            Value,
            Message);
    EndIf;
    
EndProcedure

Procedure AreCollectionNotEmpty(Value, Message = "") Export
    
    If Value.Count() = 0 Then 
        Raise AssertError(
            NStr("ru = 'Пустая коллекция.'; en = 'Collection is empty.'"),
            Value,
            Message);
    EndIf;
    
EndProcedure

&AtServer
Procedure AreUserMessagesContains(LegalMessageFragment, Message = "") Export
    
    UserMessages = GetUserMessages();
    
    UserMessagesParts = New Array;
    
    For Each UserMessage In UserMessages Do
        If StrFind(UserMessage.Text, LegalMessageFragment) Then
            Return;
        EndIf;
        UserMessagesParts.Add(UserMessage.Text);
    EndDo;
    
    Raise AssertError(LegalMessageFragment, StrConcat(UserMessagesParts, Chars.LF), Message);
    
EndProcedure

#EndRegion
