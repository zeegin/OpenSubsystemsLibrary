// BSLLS:UsingServiceTag-off
// BSLLS:MissingParameterDescription-off
// BSLLS:CodeOutOfRegion-off
// BSLLS:NonStandardRegion-off
// BSLLS:UsingHardcodeNetworkAddress-off
// BSLLS:LineLength-off

#Region URL

// @unit-test
Procedure Test_URLParsed(Context) Export
    
    URL = HTTPRequests.URL("http://username:password@hostname:8080/path?arg=value#anchor");
    
    Assert.AreEqual("http", URL.Scheme);
    Assert.AreEqual("username", URL.Auth.User);
    Assert.AreEqual("password", URL.Auth.Pass);
    Assert.AreEqual("hostname", URL.Host);
    Assert.AreEqual(8080, URL.Port);
    Assert.AreEqual("/path?arg=value#anchor", URL.Resource);
    Assert.AreEqual("/path", URL.Path);
    Assert.AreEqual("value", URL.Query["arg"]);
    Assert.AreEqual("anchor", URL.Fragment);
    Assert.AreEqual("http://hostname:8080", URL.Origin);
    Assert.AreEqual("http://hostname:8080/path?arg=value#anchor", URL.Href);
    
EndProcedure

// @unit-test
Procedure Test_URLConvertHostnameToLower(Context) Export
    
    URL = HTTPRequests.URL("HTTP://fOo.eXaMPle.com");
    
    Assert.AreEqual("http", URL.Scheme);
    Assert.AreEqual("foo.example.com", URL.Host);
    
EndProcedure

// @unit-test
Procedure Test_URLDontConvertPathToLower(Context) Export
    
    URL = HTTPRequests.URL("HTTP://X.COM/Y/Z");
    
    Assert.AreEqual("/Y/Z", URL.Path);
    
EndProcedure

// @unit-test
Procedure Test_URLRemoveDefaultPort(Context) Export
    
    URL = HTTPRequests.URL("http://example.com:80");
    
    Assert.AreEqual("example.com", URL.Host);
    Assert.AreEqual(80, URL.Port);
    Assert.AreEqual("/", URL.Path);
    Assert.AreEqual("/", URL.Resource);
    Assert.AreEqual("http://example.com", URL.Href);
    
EndProcedure

// @unit-test
Procedure Test_URLUnderstandsSlashAsPath(Context) Export
    
    URL = HTTPRequests.URL("http://example.com:80/");
    
    Assert.AreEqual("example.com", URL.Host);
    Assert.AreEqual(80, URL.Port);
    Assert.AreEqual("/", URL.Path);
    Assert.AreEqual("/", URL.Resource);
    Assert.AreEqual("http://example.com", URL.Href);
    
EndProcedure

// @unit-test
Procedure Test_URLIPv6(Context) Export
    
    URL = HTTPRequests.URL("http://[1080:0:0:0:8:800:200C:417A]:61616/foo/bar?q=z");
    
    Assert.AreEqual("[1080:0:0:0:8:800:200c:417a]", URL.Host);
    Assert.AreEqual(61616, URL.Port);
    Assert.AreEqual("/foo/bar", URL.Path);
    Assert.AreEqual("z", URL.Query["q"]);
    Assert.AreEqual("http://[1080:0:0:0:8:800:200c:417a]:61616/foo/bar?q=z", URL.Href);
    
EndProcedure

// @unit-test
Procedure Test_URLIPv6Auth(Context) Export
    
    URL = HTTPRequests.URL("http://user:password@[3ffe:2a00:100:7031::1]:8080");
    
    Assert.AreEqual("user", URL.Auth.User);
    Assert.AreEqual("password", URL.Auth.Pass);
    Assert.AreEqual("[3ffe:2a00:100:7031::1]", URL.Host);
    Assert.AreEqual(8080, URL.Port);
    
EndProcedure

// @unit-test
Procedure Test_URLIPv4(Context) Export
    
    URL = HTTPRequests.URL("http://222.148.142.13:61616/foo/bar?q=z");
    
    Assert.AreEqual("222.148.142.13", URL.Host);
    Assert.AreEqual(61616, URL.Port);
    Assert.AreEqual("/foo/bar", URL.Path);
    Assert.AreEqual("z", URL.Query["q"]);
    Assert.AreEqual("http://222.148.142.13:61616/foo/bar?q=z", URL.Href);
    
EndProcedure

// @unit-test
Procedure Test_URLIPv4Auth(Context) Export
    
    URL = HTTPRequests.URL("http://user:password@222.148.142.13:8080");
    
    Assert.AreEqual("user", URL.Auth.User);
    Assert.AreEqual("password", URL.Auth.Pass);
    Assert.AreEqual("222.148.142.13", URL.Host);
    Assert.AreEqual(8080, URL.Port);
    
EndProcedure

// @unit-test
Procedure Test_URLDontConvertAuthToLower(Context) Export
    
    URL = HTTPRequests.URL("HTTP://USER:PASS@EXAMPLE.COM");
    
    Assert.AreEqual("http", URL.Scheme);
    Assert.AreEqual("USER", URL.Auth.User);
    Assert.AreEqual("PASS", URL.Auth.Pass);
    Assert.AreEqual("example.com", URL.Host);
    
EndProcedure

// @unit-test
Procedure Test_URLEmptyAuth(Context) Export
    
    URL = HTTPRequests.URL("HTTP://EXAMPLE.COM");
    
    Assert.AreEqual("http", URL.Scheme);
    Assert.IsUndefined(URL.Auth.User);
    Assert.IsUndefined(URL.Auth.Pass);
    Assert.AreEqual("example.com", URL.Host);
    
EndProcedure

// @unit-test
Procedure Test_URLAcceptAtInPath(Context) Export
    
    // At is @
    
    URL = HTTPRequests.URL("http://mt0.google.com/vt/lyrs=m@114&hl=en&src=api&x=2&y=2&z=3&s=");
    
    Assert.AreEqual("/vt/lyrs=m@114&hl=en&src=api&x=2&y=2&z=3&s=", URL.Path);
    
EndProcedure

// @unit-test
Procedure Test_URLSemanticAttack(Context) Export
    
    URL = HTTPRequests.URL("http://cnn.example.com&story=breaking_news@10.0.0.1/top_story.htm");
    
    Assert.AreEqual("10.0.0.1", URL.Host);
    
EndProcedure

// @unit-test
Procedure Test_URLJQLQuery(Context) Export
    
    URL = HTTPRequests.URL(
        "https://httpbin.org/anything?jql=worklogDate >= 2017-04-01 AND worklogDate <= 2017-05-01&j&i=2"
    );
    
    Assert.AreEqual("https", URL.Scheme);
    Assert.AreEqual("httpbin.org", URL.Host);
    Assert.AreEqual(443, URL.Port);
    Assert.AreEqual("/anything", URL.Path);
    Assert.AreEqual("worklogDate >= 2017-04-01 AND worklogDate <= 2017-05-01", URL.Query["jql"]);
    Assert.AreEqual(True, URL.Query["j"]);
    Assert.AreEqual("2", URL.Query["i"]);
    Assert.AreEqual("", URL.Fragment);
    
EndProcedure

// @unit-test
Procedure Test_URLQueryArrayArgs(Context) Export
    
    URL = HTTPRequests.URL("http://httpbin.org/anything?i=v1&j=w1&j=w2&i=v2&i=v3");
    
    Assert.IsInstanceOfType(Type("Array"), URL.Query["i"]);
    Assert.IsInstanceOfType(Type("Array"), URL.Query["j"]);
    Assert.AreEqual("v1|v2|v3", StrConcat(URL.Query["i"], "|"));
    Assert.AreEqual("w1|w2", StrConcat(URL.Query["j"], "|"));
    
EndProcedure

// @unit-test
Procedure Test_URLIncludeURLEncoded(Context) Export
    
    URL = HTTPRequests.URL("https://www.example.ru?url=http%3A%2F%2Fwww.kuku.ru%2F%3Fs%3D1%26b%3D2&OTHER=1");
    
    Assert.AreEqual(2, URL.Query.Count());
    Assert.AreEqual("http://www.kuku.ru/?s=1&b=2", URL.Query["url"]);
    Assert.AreEqual("1", URL.Query["OTHER"]);
    
EndProcedure

#EndRegion

#Region ToFormURLEncode

// @unit-test
Procedure Test_ToFormURLEncodeEmptyQuery(Context) Export
   
   Query = New Map;
   
   Result = HTTPRequests.ToFormURLEncode(Query);
   
   Assert.AreEqual("", Result);
   
EndProcedure

// @unit-test
Procedure Test_ToFormURLEncodeURLEncoded(Context) Export
   
   Query = New Array;
   Query.Add(New Structure("Key, Value", "url", "http://www.kuku.ru/?s=1&b=2"));
   Query.Add(New Structure("Key, Value", "OTHER", "1"));
   
   Result = HTTPRequests.ToFormURLEncode(Query);
   
   Assert.AreEqual("url=http%3A%2F%2Fwww.kuku.ru%2F%3Fs%3D1%26b%3D2&OTHER=1", Result);
   
EndProcedure

// @unit-test
Procedure Test_ToFormURLEncodeMultyQueryArg(Context) Export
   
   Arg1 = New Array;
   Arg1.Add("value1");
   Arg1.Add("value2");
   
   Query = New Array;
   Query.Add(New Structure("Key, Value", "arg1", Arg1));
   Query.Add(New Structure("Key, Value", "arg3", "value3"));
   Query.Add(New Structure("Key, Value", "arg4", True));
   
   Result = HTTPRequests.ToFormURLEncode(Query);
   
   Assert.AreEqual("arg1=value1&arg1=value2&arg3=value3&arg4", Result);
   
EndProcedure

#EndRegion

#Region BasicRequests

// @unit-test
Procedure Test_PassQueryToRequest(Context) Export
    
    Query = New Structure;
    Query.Insert("name", StrSplit("Иванов|Петров", "|"));
    Query.Insert("salary", XMLString(100000));
    Query.Insert("time", "01:47");
    
    Response = HTTPRequests.Get("https://httpbin.org/anything/params", Query);
    Result = Response.Json();
    
    Assert.AreEqual(
        "https://httpbin.org/anything/params?name=%D0%98%D0%B2%D0%B0%D0%BD%D0%BE%D0%B2&name=%D0%9F%D0%B5%D1%82%D1%80%D0%BE%D0%B2&salary=100000&time=01%3A47",
        Response.URL.Href
    );
    Assert.AreEqual("100000", Result["args"]["salary"]);
    Assert.AreEqual("Иванов|Петров", StrConcat(Result["args"]["name"], "|"));
    Assert.AreEqual("01:47", Result["args"]["time"]);
    
EndProcedure

// @unit-test
Procedure Test_PassQueryToRequestMult(Context) Export
    
    Query = New Structure;
    Query.Insert("name", StrSplit("Иванов|Петров", "|"));
    Query.Insert("salary", XMLString(100000));
    
    Result = HTTPRequests.Get("https://httpbin.org/anything/params?post=Программист&name=Сидоров", Query).Json();
    
    Assert.AreEqual("100000", Result["args"]["salary"]);
    Assert.AreEqual("Программист", Result["args"]["post"]);
    Assert.AreEqual("Сидоров|Иванов|Петров", StrConcat(Result["args"]["name"], "|"));
    
EndProcedure

// @unit-test
Procedure Test_ResponseAsJsonGet(Context) Export
    
    Result = HTTPRequests.Get("http://httpbin.org/get").Json();
    
    Assert.AreEqual("http://httpbin.org/get", Result["url"]);
    
EndProcedure

// @unit-test
Procedure Test_ResponseAsJsonPost(Context) Export
    
    Result = HTTPRequests.Post("http://httpbin.org/post").Json();
    
    Assert.AreEqual("http://httpbin.org/post", Result["url"]);
    
EndProcedure

// @unit-test
Procedure Test_ResponseAsString(Context) Export
    
    Result = HTTPRequests.Get("http://httpbin.org/encoding/utf8").Text();
    
    Assert.AreEqual(3931, StrFind(Result, "Зарегистрируйтесь сейчас на Десятую Международную"));
    
EndProcedure

// @unit-test
Procedure Test_ResponseAsBinaryData(Context) Export
    
    Result = HTTPRequests.Get("http://httpbin.org/image/png").BinaryData();
    
    Assert.IsInstanceOfType(Type("BinaryData"), Result);
    Assert.AreEqual("5cca6069f68fbf739fce37e0963f21e7", Cryptography.MD5(Result));
    
EndProcedure

// @unit-test
Procedure Test_GetJsonToStructure(Context) Export
    
    DeserializerSettings = Json.DeserializerSettings();
    DeserializerSettings.ReadToMap = False;
    
    Result = HTTPRequests.Get("https://httpbin.org/json").Json(DeserializerSettings);
    
    Assert.AreEqual("Yours Truly", Result.slideshow.author);
    Assert.AreEqual("date of publication", Result.slideshow.date);
    Assert.AreEqual(2, Result.slideshow.slides.Count());
    Assert.AreEqual("Sample Slide Show", Result.slideshow.title);
    
EndProcedure

// @unit-test
Procedure Test_PostJson(Context) Export
    
    Object = New Structure;
    Object.Insert("Сотрудник", "Иванов Иван Петрович");
    Object.Insert("Должность", "Разнорабочий");
    
    Result = HTTPRequests.Post("http://httpbin.org/post", Json.Dumps(Object)).Json();
    
    Assert.AreEqual("Иванов Иван Петрович", Result["json"]["Сотрудник"]);
    Assert.AreEqual("Разнорабочий", Result["json"]["Должность"]);
    
EndProcedure

// @unit-test
Procedure Test_PostJsonWithDate(Context) Export
    
    DeserializerSettings = Json.DeserializerSettings();
    DeserializerSettings.PropertiesWithDateValuesNames = "Дата";
    
    Object = New Structure;
    Object.Insert("Дата", '20190121002400');
    Object.Insert("Число", 5);
    Object.Insert("Булево", True);
    Object.Insert("Строка", "Привет");
    
    Result = HTTPRequests.Post("http://httpbin.org/post", Json.Dumps(Object)).Json(DeserializerSettings);
    
    Assert.AreEqual("http://httpbin.org/post", Result["url"]);
    Assert.AreEqual('20190121002400', Result["json"]["Дата"]);
    Assert.AreEqual(5, Result["json"]["Число"]);
    Assert.IsTrue(Result["json"]["Булево"]);
    Assert.AreEqual("Привет", Result["json"]["Строка"]);
    
EndProcedure

// @unit-test
Procedure Test_PutJson(Context) Export
    
    Object = New Structure;
    Object.Insert("Сотрудник", "Иванов Иван Петрович");
    Object.Insert("Должность", "Разнорабочий");
    
    Result = HTTPRequests.Put("http://httpbin.org/put", Json.Dumps(Object)).Json();
    
    Assert.AreEqual("Иванов Иван Петрович", Result["json"]["Сотрудник"]);
    Assert.AreEqual("Разнорабочий", Result["json"]["Должность"]);
    
EndProcedure

// @unit-test
Procedure Test_BasicAuthByURL(Context) Export
    
    Result = HTTPRequests.Get("https://user:pass@httpbin.org/basic-auth/user/pass").Json();
    
    Assert.IsTrue(Result["authenticated"]);
    Assert.AreEqual("user", Result["user"]);
    
EndProcedure

// @unit-test
Procedure Test_BasicAuthByParam(Context) Export
    
    Param = HTTPRequests.Param();
    Param.Auth.User = "user";
    Param.Auth.Pass = "pass";
    
    Result = HTTPRequests.Get("https://httpbin.org/basic-auth/user/pass", , Param).Json();
    
    Assert.IsTrue(Result["authenticated"]);
    Assert.AreEqual("user", Result["user"]);
    
EndProcedure

// @unit-test
Procedure Test_BasicAuthByParamOverride(Context) Export
    
    Param = HTTPRequests.Param();
    Param.Auth.Type = "Basic";
    Param.Auth.User = "user";
    Param.Auth.Pass = "pass";
    
    Result = HTTPRequests.Get("https://httpbin.org/basic-auth/user/pass", , Param).Json();
    
    Assert.IsTrue(Result["authenticated"]);
    Assert.AreEqual("user", Result["user"]);
    
EndProcedure

// @unit-test
Procedure Test_Error404(Context) Export
    
    Result = HTTPRequests.Get("http://httpbin.org/status/404");
    
    Assert.AreEqual(404, Result.StatusCode);
    
EndProcedure

// @unit-test
Procedure Test_Options(Context) Export
    
    Result = HTTPRequests.Options("http://httpbin.org/anything");
    
    Assert.AreEqual(200, Result.StatusCode);
    
EndProcedure

// @unit-test
Procedure Test_Head(Context) Export
    
    Result = HTTPRequests.Head("http://httpbin.org/anything");
    
    Assert.AreEqual(200, Result.StatusCode);
    
EndProcedure

// @unit-test
Procedure Test_Delete(Context) Export
    
    Result = HTTPRequests.Delete("http://httpbin.org/delete");
    
    Assert.AreEqual(200, Result.StatusCode);
    
EndProcedure

// @unit-test
Procedure Test_Patch(Context) Export
    
    Result = HTTPRequests.Patch("http://httpbin.org/patch");
    
    Assert.AreEqual(200, Result.StatusCode);
    
EndProcedure

// @unit-test
Procedure Test_GetWithCustomHeader(Context) Export
    
    Param = HTTPRequests.Param();
    Param.Headers.Insert("X-My-Header", "Hello!!!");
    
    Result = HTTPRequests.Get("http://httpbin.org/headers", , Param).Json();
    
    Assert.AreEqual("Hello!!!", Result["headers"]["X-My-Header"]);
    
EndProcedure

// @unit-test
Procedure Test_PostFormData(Context) Export
    
    Data = New Structure;
    Data.Insert("comments", "Постучать в дверь");
    Data.Insert("custemail", "vasya@mail.ru");
    Data.Insert("custname", "Вася");
    Data.Insert("custtel", "112");
    Data.Insert("delivery", "20:20");
    Data.Insert("size", "medium");
    Data.Insert("topping", StrSplit("bacon|mushroom", "|"));
    
    Result = HTTPRequests.Post("http://httpbin.org/post", Data).Json();
    
    Assert.AreEqual("Постучать в дверь", Result["form"]["comments"]);
    Assert.AreEqual("vasya@mail.ru", Result["form"]["custemail"]);
    Assert.AreEqual("Вася", Result["form"]["custname"]);
    Assert.AreEqual("112", Result["form"]["custtel"]);
    Assert.AreEqual("20:20", Result["form"]["delivery"]);
    Assert.AreEqual("medium", Result["form"]["size"]);
    Assert.AreEqual("bacon|mushroom", StrConcat(Result["form"]["topping"], "|"));
    
EndProcedure

#EndRegion

#Region Timeout

// @unit-test
Procedure Test_GetTimeout(Context) Export
    
    Try
        Param = HTTPRequests.Param();
        Param.Timeout = 1;
        
        HTTPRequests.Get("https://httpbin.org/delay/10", , Param);
    Except
        Assert.IsLegalException(
            NStr(
                "en = 'Timeout exceeded';
                |ru = 'Превышено время ожидания'",
                Locale.SystemLanguage()
            ),
            ErrorInfo()
        );
    EndTry;
    
EndProcedure

#EndRegion

#Region Redirects

// @unit-test
Procedure Test_GetRelativeRedirect(Context) Export
    
    Response = HTTPRequests.Get("http://httpbin.org/relative-redirect/6");
    Result = Response.Json();
    
    Assert.AreEqual(200, Response.StatusCode);
    Assert.AreEqual("http://httpbin.org/get", Result["url"]);
    
EndProcedure

// @unit-test
Procedure Test_GetAbsoluteRedirect(Context) Export
    
    Response = HTTPRequests.Get("http://httpbin.org/absolute-redirect/6");
    Result = Response.Json();
    
    Assert.AreEqual(200, Response.StatusCode);
    Assert.AreEqual("http://httpbin.org/get", Result["url"]);
    
EndProcedure

// @unit-test
Procedure Test_GetDisabledRedirect(Context) Export
    
    Param = HTTPRequests.Param();
    Param.AllowRedirect = False;
    
    Response = HTTPRequests.Get(
        "http://httpbin.org/redirect-to?url=http%3A%2F%2Fhttpbin.org%2Fget&status_code=307", ,
        Param
    );
    
    Assert.AreEqual(307, Response.StatusCode);
    
EndProcedure

// @unit-test
Procedure Test_GetTooMoreRedirect(Context) Export
    
    Try
        HTTPRequests.Get("http://httpbin.org/redirect/31");
    Except
        Assert.IsLegalException("RuntimeError", ErrorInfo());
    EndTry;
    
EndProcedure

#EndRegion

#Region Gzip

// @unit-test
Procedure Test_GetGZip(Context) Export
    
    Result = HTTPRequests.Get("http://httpbin.org/gzip").Json();
    
    Assert.IsTrue(Result["gzipped"]);
    
EndProcedure

// @unit-test
Procedure Test_GetGZipYaRu(Context) Export
    
    Result = HTTPRequests.Get("http://ya.ru").Text();
    
    Assert.AreEqual(1, StrFind(Result, "<!DOCTYPE html>"));
    
EndProcedure

// @unit-test
Procedure Test_PostGZip(Context) Export
    
    Data = New Structure;
    Data.Insert("field", "value");
    Data.Insert("field2", "value2");
    
    Param = HTTPRequests.Param();
    Param.Headers.Insert("Content-Encoding", "gzip");
    
    Result = HTTPRequests.Post("http://httpbin.org/anything", Json.Dumps(Data), , Param).Json();
    
    Assert.AreEqual("gzip", Result["headers"]["Content-Encoding"]);
    Assert.AreEqual(
        "data:application/octet-stream;base64,H4sIAAAAAAAA/6vm5VJKy0zNSVGyUlAqS8wpTVXSgQkZwcWMlHi5agFVEpHzKwAAAA==",
        Result["data"]
    );
    
EndProcedure

#EndRegion

#Region MultipartData

// @unit-test
Procedure Test_PostMultipartFormDataAsDataFile(Context) Export
    
    File = HTTPRequests.TransferedFile();
    File.Field = "file1";
    File.FileName = "file1.txt";
    File.Data = Base64Value("0J/RgNC40LLQtdGCINCc0LjRgCE=");
    File.ContentType = "text/plain";
    
    Files = New Array;
    Files.Add(File);
    
    Result = HTTPRequests.Post("https://httpbin.org/post", , Files).Json();
    
    Assert.AreEqual("Привет Мир!", Result["files"]["file1"]);
    
EndProcedure

// @unit-test
Procedure Test_PostMultipartFormDataAsStringFile(Context) Export
    
    File = HTTPRequests.TransferedFile();
    File.Field = "file1";
    File.FileName = "file1.txt";
    File.Data = "Привет Мир!";
    File.ContentType = "text/plain";
    
    Files = New Array;
    Files.Add(File);
    
    Result = HTTPRequests.Post("https://httpbin.org/post", , Files).Json();
    
    Assert.AreEqual("Привет Мир!", Result["files"]["file1"]);
    
EndProcedure

// @unit-test
Procedure Test_PostMultipartFormDataAsDataAndFiles(Context) Export
    
    Data = New Structure;
    Data.Insert("field1", "value1");
    Data.Insert("field2", "value2");
    
    File1 = HTTPRequests.TransferedFile();
    File1.Field = "file1";
    File1.FileName = "file1.txt";
    File1.Data = Base64Value("ZmlsZTE=");
    File1.ContentType = "text/plain";
    
    File2 = HTTPRequests.TransferedFile();
    File2.Field = "file2";
    File2.FileName = "file2.txt";
    File2.Data = Base64Value("ZmlsZTI=");
    File2.ContentType = "text/plain";
    
    Files = New Array;
    Files.Add(File1);
    Files.Add(File2);
    
    Result = HTTPRequests.Post("https://httpbin.org/post", Data, Files).Json();
    
    Assert.AreEqual("file1", Result["files"]["file1"]);
    Assert.AreEqual("file2", Result["files"]["file2"]);
    Assert.AreEqual("value1", Result["form"]["field1"]);
    Assert.AreEqual("value2", Result["form"]["field2"]);
    
EndProcedure

#EndRegion
