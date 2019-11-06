#Region Variables

Var Cookies Export;
Var ValidateSSL Export;
Var AllowRedirect Export; // AllowRedirects
Var MaxRedirectCount Export; // MaxRedirects

#EndRegion

#Region Public

// Description
// 
// Parameters:
//  URL - String - Description
//  Query - Map - Description
//  Param - (See Param)
//  Session - (See Session)
// Returns:
//  DataProcessor.HTTPResponse
//
Function Get(URL, Query = Undefined, Param = Undefined) Export
    
    Return _HTTP("GET", URL, Query, Undefined, New Array, Param);
    
EndFunction

// Description
// 
// Parameters:
//  URL - String - Description
//  Param - (See Param)
//  Session - (See Session)
// Returns:
//  DataProcessor.HTTPResponse
//
Function Options(URL, Param = Undefined) Export
    
    Return _HTTP("OPTIONS", URL, Undefined, Undefined, New Array, Param);
    
EndFunction

Function Head(URL, Param = Undefined) Export
    
    Return _HTTP("HEAD", URL, Undefined, Undefined, New Array, Param);
    
EndFunction

Function Post(URL, Data = Undefined, Files = Undefined, Param = Undefined) Export
    
    If Files = Undefined Then
        Files = New Array;
    EndIf;
    
    Return _HTTP("POST", URL, Undefined, Data, Files, Param);
    
EndFunction

Function Put(URL, Data = Undefined, Param = Undefined) Export
    
    Return _HTTP("PUT", URL, Undefined, Data, New Array, Param);
    
EndFunction

Function Patch(URL, Data = Undefined, Param = Undefined) Export
    
    Return _HTTP("PATCH", URL, Undefined, Data, New Array, Param);
    
EndFunction

Function Delete(URL, Data = Undefined, Param = Undefined) Export
    
    Return _HTTP("DELETE", URL, Undefined, Data, New Array, Param);
    
EndFunction

// Closes all adapters and as such the session
Function Close() Export 
    
EndFunction

// Receives a Response. Returns a redirect URI or None
Function GetRedirectTarget(Resp)


EndFunction

#EndRegion

#Region Private

Procedure _Ctor() Export 
    
    Cookies = New Map;
    
    //Self.Insert("_Headers", _DefaultHeaders());
    //Self.Insert("_Auth", Undefined);
    //Self.Insert("_Proxy", Undefined);
    //Self.Insert("_RequestParams", New Structure);
    //Self.Insert("_ValidateSSL", True);
    //Self.Insert("_MaxRedirectCount", 7);
    //Self.Insert("_Cookies", New Map);
    //Self.Insert("_DigestParam", New Structure);
    
EndProcedure

//
// CONNECT   RFC 2616 (http://tools.ietf.org/html/rfc2616).
// COPY      RFC 2518 (http://tools.ietf.org/html/rfc2518). Part of WebDAV.
// DELETE    RFC 2616 (http://tools.ietf.org/html/rfc2616). Used to delete data.
// GET       RFC 2616 (http://tools.ietf.org/html/rfc2616). Used to obtain data.
// HEAD      RFC 2616 (http://tools.ietf.org/html/rfc2616). Used to obtaindata information.
// LOCK      RFC 2518 (http://tools.ietf.org/html/rfc2518). Part of WebDAV.
// MERGE     Microsoft extension PATCH HTTP-method at (http://msdn.microsoft.com/en-us/library/dd541276.aspx).
//           Used to change data differentially.
// MKCOL     RFC 2518 (http://tools.ietf.org/html/rfc2518). Part of WebDAV.
// MOVE      RFC 2518 (http://tools.ietf.org/html/rfc2518). Part of WebDAV.
// OPTIONS   RFC 2616 (http://tools.ietf.org/html/rfc2616). Used to obtain information about how to process URL data.
// PATCH     RFC 5789 (http://tools.ietf.org/html/rfc5789). Used for differential change of data.
// POST      RFC 2616 (http://tools.ietf.org/html/rfc2616). Used to create a new entity on the server.
// PROPFIND  RFC 2518 (http://tools.ietf.org/html/rfc2518). Part of WebDAV.
// PROPPATCH RFC 2518 (http://tools.ietf.org/html/rfc2518). Part of WebDAV.
// PUT       RFC 2616 (http://tools.ietf.org/html/rfc2616). Used to change data.
// TRACE     RFC 2616 (http://tools.ietf.org/html/rfc2616).
// UNLOCK    RFC 2518 (http://tools.ietf.org/html/rfc2518). Part of WebDAV.
//
Function _HTTP(Val Method, Val Href, Query, Data, Files, Param = Undefined, Redirection = 0)
    
    URL = HTTPRequests.URL(Href, Query);
    
    If Not ValueIsFilled(Param) Then
        Param = HTTPRequests.Param();
    EndIf;
    
    HTTPRequest = New HTTPRequest(URL.Resource, Param.Headers);
    
    If Method = "POST" Or Method = "PUT" Then
        If Files.Count() Then
            
            Boundary = StrReplace(New UUID, "-", "");
            
            ContentType = StrTemplate("multipart/form-data; boundary=%1", Boundary);
            HTTPRequest.Headers.Insert("content-type", ContentType);
            
            DataWriter = New DataWriter(
                HTTPRequest.GetBodyAsStream(),
                TextEncoding.UTF8,
                ByteOrder.LittleEndian,
                "",
                "",
                False
            );
            
            If ValueIsFilled(Data) Then
                For Each Item In Data Do
                    DataWriter.WriteLine("--" + Boundary + Chars.CR + Chars.LF);
                    DataWriter.Write(_ToPostDataParamFiled(Item.Key, Item.Value));
                EndDo;
            EndIf;
            
            For Each File In Files Do
                DataWriter.WriteLine("--" + Boundary + Chars.CR + Chars.LF);
                DataWriter.Write(_ToPostDataParamFile(File));
            EndDo;
            
            DataWriter.WriteLine("--" + Boundary + "--");
            DataWriter.Close();
            
        ElsIf ValueIsFilled(Data) Then
            
            If TypeOf(Data) = Type("Structure")
                Or TypeOf(Data) = Type("FixedStructure")
                Or TypeOf(Data) = Type("Map")
                Or TypeOf(Data) = Type("FixedMap")Then
                
                HTTPRequest.Headers.Insert("content-type", "application/x-www-form-urlencoded");
                HTTPRequest.SetBodyFromString(
                    HTTPRequests.ToFormURLEncode(Data),
                    TextEncoding.UTF8,
                    ByteOrderMarkUsage.DontUse
                );
                
            ElsIf TypeOf(Data) = Type("String") Then
                
                If StrStartsWith(Data, "{") And StrEndsWith(Data, "}") Then
                    HTTPRequest.Headers.Insert("content-type", "application/json");
                Else
                    HTTPRequest.Headers.Insert("content-type", "text/plain");
                EndIf;
                
                HTTPRequest.SetBodyFromString(
                    Data,
                    TextEncoding.UTF8,
                    ByteOrderMarkUsage.DontUse
                );
                
            Else 
                Raise NotImplementedError();
            EndIf;
        Else
            HTTPRequest.Headers.Insert("content-type", "text/plain");
        EndIf;
    EndIf;
    
    SecureConnection = Undefined;
    If URL.Scheme = "https" Then
        If Param.ValidateSSL Then
            AuthorityCertificates = New OSCertificationAuthorityCertificates;
        Else 
            AuthorityCertificates = Undefined;
        EndIf;
        SecureConnection = New OpenSSLSecureConnection(, AuthorityCertificates);
    EndIf;
    
    User = Undefined;
    Pass = Undefined;
    NTLM = False;
    If Param.Auth.Type = "Basic" Then
        User = ?(ValueIsFilled(Param.Auth.User), Param.Auth.User, URL.Auth.User);
        Pass = ?(ValueIsFilled(Param.Auth.Pass), Param.Auth.Pass, URL.Auth.Pass);
    ElsIf Param.Auth.Type = "NTLM" Then
        NTLM = True;
    Else 
        NotImplementedError(StrTemplate(
            NStr("en = 'Not supported authentication type <%1>.';
                 |ru = 'Не поддерживаемый тип аутентификации <%1>.'"),
            Param.Auth.Type
        ));
    EndIf;
    
    Proxy = New InternetProxy(True);
  	// getproxylist.com
	// Proxy = New InternetProxy(False);
	// Proxy.Set("https", "79.115.245.227", 8080);
    
    HTTPConnection = New HTTPConnection(
        URL.Host,
        URL.Port,
        User,
        Pass,
        Proxy,
        Param.Timeout,
        SecureConnection,
        NTLM
    );
    
    HTTPResponse = HTTPConnection.CallHTTPMethod(Method, HTTPRequest);
    
    If Param.AllowRedirect And _IsRedirect(HTTPResponse.StatusCode) Then
        
        If Redirection > Param.MaxRedirectCount Then
            Raise RuntimeError(StrTemplate(
                NStr("en = 'Too more redirection from <%1>.';
                     |ru = 'Слишком много перенаправлений запроса с <%1>.'"),
                URL.Href
            ));
        EndIf;
        
        Href = HTTPRequests.HeaderValue(HTTPResponse.Headers, "location", Undefined);
        If Href = Undefined Then
            Raise RuntimeError(StrTemplate(
                NStr("en = 'Cannot redirect from <%1>.';
                     |ru = 'Невозможно перенаправить запрос с <%1>.'"),
                URL.Href
            ));
        EndIf;
        Href = DecodeString(Href, StringEncodingMethod.URLInURLEncoding);
        
        If _IsRelativeLocation(Href) Then
            Href = URL.Origin + Href;
        EndIf;
        
        Redirection = Redirection + 1;
        
        
        //rebuild_auth(prepared_request, response)
        //When being redirected we may want to strip authentication from the request to avoid leaking credentials. This method intelligently removes and reapplies authentication where possible to avoid credential loss.

        //rebuild_method(prepared_request, response)
        //When being redirected we may want to change the method of the request based on certain specs or browser behavior.

        //rebuild_proxies(prepared_request, proxies)
        //This method re-evaluates the proxy configuration by considering the environment variables. If we are redirected to a URL covered by NO_PROXY, we strip the proxy configuration. Otherwise, we set missing proxy keys for this URL (in case they were stripped by a previous redirect).

        //This method also replaces the Proxy-Authorization header where necessary.
        
        
        
        // Query already parsed in URL and should not be used in redirection.
        Return _HTTP(Method, Href, Undefined, Data, Param, Files, Redirection);
    EndIf;
    
    Return _Response(HTTPResponse, URL);
    
EndFunction

Function _IsRedirect(StatusCode)
    
    Return StatusCode = 301
        Or StatusCode = 302
        Or StatusCode = 303
        Or StatusCode = 307
        Or StatusCode = 308;
    
EndFunction

Function _IsRelativeLocation(Href)
    
    Return Not StrFind(Href, "://");
    
EndFunction

Function _Response(HTTPResponse, URL)
    
    Self = DataProcessors.HTTPResponse.Create();
    Self._Ctor(HTTPResponse, URL);
    Return Self;
    
EndFunction

Function _ToPostDataParamFiled(Field, Value)
    
    Stream = New MemoryStream();
    DataWriter = New DataWriter(Stream);
    DataWriter.WriteLine(StrTemplate(
        "Content-Disposition: form-data; name=""%1""",
        Field
    ));
    DataWriter.WriteLine("");
    DataWriter.WriteLine(Value);
    DataWriter.Close();
    
    Return Stream.CloseAndGetBinaryData();
    
EndFunction

Function _ToPostDataParamFile(TransferedFile)
    
    Stream = New MemoryStream();
    DataWriter = New DataWriter(Stream);
    DataWriter.WriteLine(StrTemplate(
        "Content-Disposition: form-data; name=""%1""; filename=""%2""",
        TransferedFile.Field,
        TransferedFile.FileName
    ));
    DataWriter.WriteLine(StrTemplate(
        "Content-Type: %1",
        TransferedFile.ContentType
    ));
    DataWriter.WriteLine("");
    
    If TypeOf(TransferedFile.Data) = Type("BinaryData") Then
        DataWriter.Write(TransferedFile.Data);
        DataWriter.WriteLine("");
    ElsIf TypeOf(TransferedFile.Data) = Type("String") Then
        DataWriter.WriteLine(TransferedFile.Data);
    Else 
        Raise NotImplementedError(StrTemplate(
            NStr("en = 'Not supported transfered file data type <%1>.';
                 |ru = 'Не поддерживаемый тип данных передаваемого файла <%1>.'"),
            TypeOf(TransferedFile.Data)
        ));
    EndIf;
    
    DataWriter.Close();
    
    Return Stream.CloseAndGetBinaryData();
    
EndFunction

#EndRegion