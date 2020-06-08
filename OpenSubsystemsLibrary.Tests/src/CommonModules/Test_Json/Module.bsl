// @unit-test
Procedure Test_LoadsAsString(Context) Export
    
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