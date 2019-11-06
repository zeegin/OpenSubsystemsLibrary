#Region Public

Procedure AreEqual(Expected, Actual, Message = "") Export
    
    If IsBlankString(Message) Then 
        Message = StrTemplate(
            NStr("en = 'Expected: <%1> Actual: <%2>.';
                 |ru = 'Ожидается: <%1> Текущее: <%2>.'"),
            Expected,
            Actual
        );
    EndIf;
    
    IsTrue(Expected = Actual, Message);
    
EndProcedure

Procedure AreNotEqual(NotExpected, Actual, Message = "") Export
    
    If IsBlankString(Message) Then 
        Message = StrTemplate(
            NStr("en = 'Not expected: <%1> Actual: <%2>';
                 |ru = 'Не ожидается: <%1> Текущее: <%2>'"),
            NotExpected,
            Actual
        );
    EndIf;
    
    IsFalse(NotExpected = Actual, Message);
    
EndProcedure

Procedure IsTrue(Condition, Message = "") Export
    
    If TypeOf(Condition) <> Type("Boolean") Then
        Raise TypeError(
            NStr("en = 'Wrong condition in assert.'; 
                 |ru = 'Неправильное выражение в утверждении.'")
        );
    EndIf;
    
    If Not Condition Then
        If IsBlankString(Message) Then 
            Message = 
                NStr("en = 'Condition is false.'; 
                     |ru = 'Выражение ложно.'");
        EndIf;
        
        Raise AssertError(Message);
    EndIf;
    
EndProcedure

Procedure IsFalse(Condition, Message = "") Export
    
    If IsBlankString(Message) Then 
        Message = 
            NStr("en = 'Condition is true.'; 
                 |ru = 'Выражение истинно.'");
    EndIf;
    
    IsTrue(Not Condition, Message);
    
EndProcedure

Procedure IsInstanceOfType(ExpectedType, Value, Message = "") Export
    
    AreEqual(TypeOf(Value), Type(ExpectedType), Message);
    
EndProcedure

Procedure IsNotInstanceOfType(WrongType, Value, Message = "") Export
    
    AreNotEqual(TypeOf(Value), Type(WrongType), Message);
    
EndProcedure

Procedure IsUndefined(Value, Message = "") Export
    
    If IsBlankString(Message) Then 
        Message = 
            NStr("en = 'Value is not undefined.'; 
                 |ru = 'Значение определено.'");
    EndIf;
    
    AreEqual(Value, Undefined, Message);
    
EndProcedure

Procedure IsNotUndefined(Value, Message = "") Export
    
    If IsBlankString(Message) Then 
        Message = 
            NStr("en = 'Value is undefined.'; 
                 |ru = 'Значение неопределено.'");
    EndIf;
    
    AreNotEqual(Value, Undefined, Message);
    
EndProcedure

Procedure IsNull(Value, Message = "") Export
    
    AreEqual(Value, Null, Message);
    
EndProcedure

Procedure IsNotNull(Value, Message = "") Export
    
    AreNotEqual(Value, Null, Message);
    
EndProcedure

Procedure IsLegalException(LegalErrorFragment, ErrorInfo, Message = "") Export 
    
    ErrorDescription = DetailErrorDescription(ErrorInfo);
    
    If Not StrFind(ErrorDescription, LegalErrorFragment) Then
        If IsBlankString(Message) Then 
            Message = StrTemplate(
                NStr("en = 'Exception is not legal:
                           |%1';
                           |Legal:';
                           |%2';
                     |ru = 'Недопустимое исключение:
                           |%1'
                           |Допустимо:'
                           |%2'"),
                ErrorDescription,
                LegalErrorFragment
            );
        EndIf;
        
        Raise AssertError(Message);
    EndIf;
    
EndProcedure

Procedure AreCollectionEmpty(Value, Message = "") Export
    
    If TypeOf(Value) = Type("Array")
        Or TypeOf(Value) = Type("FixedArray")
        Or TypeOf(Value) = Type("ValueTable") Then
        
        IsTrue(Value.Count() = 0, Message);
        Return;
    EndIf;
    
    Raise TypeError("Not a collection.");
    
EndProcedure

#EndRegion
