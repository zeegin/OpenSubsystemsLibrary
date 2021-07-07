// BSLLS:UsingServiceTag-off
// BSLLS:MissingParameterDescription-off
// BSLLS:CodeOutOfRegion-off

// @unit-test
Procedure Test_Tuple(Context) Export
    
    Result = Tuple(0, "Val1");
    
    Assert.AreEqual(Type("FixedArray"), TypeOf(Result));

    Assert.AreCollectionNotEmpty(Result);

    Assert.AreEqual(0, Result[0], 0);
    Assert.AreEqual("Val1", Result[1]);
    
EndProcedure

// @unit-test
Procedure Test_Detuple(Context) Export
    
    Result = Tuple(0, "Val1");
    
    Res = Detuple(Result);
    
    Assert.AreEqual(Type("FixedStructure"), TypeOf(Res));

    Assert.AreCollectionNotEmpty(Result);
    
    Assert.AreEqual(0, Res.Item1);
    Assert.AreEqual("Val1", Res.Item2);

    Res = Detuple(Result, "Value1", "Value2");
    
    Assert.AreEqual(Type("FixedStructure"), TypeOf(Res));

    Assert.AreCollectionNotEmpty(Result); 
    
    Assert.AreEqual(0, Res.Value1);
    Assert.AreEqual("Val1", Res.Value2);
    
EndProcedure
