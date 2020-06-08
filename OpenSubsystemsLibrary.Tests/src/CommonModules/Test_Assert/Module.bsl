// @unit-test
Procedure Test_AssertErrorWithoutMessage(Context) Export
    
    Assert.AreEqual(
        "[AssertError]
        |[Expected]
        |1
        |[Actual]
        |2",
        AssertError(1, 2)
    );
    
EndProcedure

// @unit-test
Procedure Test_AssertErrorWithMessage(Context) Export
    
    Assert.AreEqual(
        "[AssertError]
        |[Expected]
        |1
        |[Actual]
        |2
        |[Message]
        |3",
        AssertError(1, 2, 3)
    );
    
EndProcedure