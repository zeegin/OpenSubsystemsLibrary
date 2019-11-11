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
        Raise AssertError(Value, Null, Message);
    EndIf;
    
EndProcedure

Procedure IsNotNull(Value, Message = "") Export
    
    If Value = Null Then
        Raise AssertError(Value, Null, Message);
    EndIf;
    
EndProcedure

Procedure IsLegalException(LegalErrorFragment, ErrorInfo, Message = "") Export 
    
    ErrorDescription = DetailErrorDescription(ErrorInfo);
    
    If Not StrFind(ErrorDescription, LegalErrorFragment) Then
        Raise AssertError(ErrorDescription, LegalErrorFragment, Message);
    EndIf;
    
EndProcedure

Procedure AreCollectionEmpty(Value, Message = "") Export
    
    If Value.Count() = 0 Then 
        Raise AssertError(
            Value, 
            NStr("ru = 'Пустая коллекция.'; en = 'Empty collection.'"),
            Message);
    EndIf;
    
EndProcedure

#EndRegion
