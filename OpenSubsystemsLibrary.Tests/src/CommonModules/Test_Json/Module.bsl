// BSLLS:UsingServiceTag-off
// BSLLS:MissingParameterDescription-off
// BSLLS:CodeOutOfRegion-off

// @unit-test
Procedure Test_LoadsEmptyString(Context) Export
    
    JsonString = "";
    
    Result = Json.Loads(JsonString);
    
    Assert.IsInstanceOfType(Type("Map"), Result);
    Assert.AreCollectionEmpty(Result);
    
EndProcedure

// @unit-test
Procedure Test_LoadsEmptyBinaryData(Context) Export
    
    JsonString = Base64Value("");
    
    Result = Json.Loads(JsonString);
    
    Assert.IsInstanceOfType(Type("Map"), Result);
    Assert.AreCollectionEmpty(Result);
    
EndProcedure

// @unit-test
Procedure Test_LoadsString(Context) Export
    
    JsonString = 
        "{
        |  ""name"": ""Peter"",
        |  ""age"": 30,
        |  ""isAdmin"": false,
        |  ""dateOfBirth"": ""1985-01-06T04:35:11 +08:00"",
        |  ""permissions"": null
        |}";
    
    Result = Json.Loads(JsonString);
    
    Assert.AreEqual("Peter", Result["name"]);
    Assert.AreEqual(30, Result["age"]);
    Assert.AreEqual(False, Result["isAdmin"]);
    Assert.AreEqual("1985-01-06T04:35:11 +08:00", Result["dateOfBirth"]);
    Assert.AreEqual(Undefined, Result["permissions"]);
    
EndProcedure

// @unit-test
Procedure Test_LoadsBinaryData(Context) Export
    
    JsonString = GetBinaryDataFromString(
        "{
        |  ""name"": ""Peter"",
        |  ""age"": 30,
        |  ""isAdmin"": false,
        |  ""dateOfBirth"": ""1985-01-06T04:35:11 +08:00"",
        |  ""permissions"": null
        |}"
    );
    
    Result = Json.Loads(JsonString);
    
    Assert.AreEqual("Peter", Result["name"]);
    Assert.AreEqual(30, Result["age"]);
    Assert.AreEqual(False, Result["isAdmin"]);
    Assert.AreEqual("1985-01-06T04:35:11 +08:00", Result["dateOfBirth"]);
    Assert.AreEqual(Undefined, Result["permissions"]);
    
EndProcedure
