#Region Public

// Platform raised exception for HTTPConnection.CallHTTPMethod in lot of cases:
// - connection timeout
// - network problem, DNS failure, refused connection
// - security problem like authority certificate was refused or out of date
// This module raised exception for:
// - RuntimeError Too more redirection
// - RuntimeError Cannot redirect
// - NotImplementedError Not supported default protocol Scheme port
// - NotImplementedError Not supported authentication type
// To raise exception for wrong status code use RaiseForStatus() method

// Description
// 
// Parameters:
//  String - String - Description
//  Query - Map - Description
// Returns:
//  FixedStructure - contains:
//  * Scheme - String - Description
//  * Auth - FixedStructure - contains:
//  ** User - String - Description
//  ** Pass - String - Description
//  * Host - String - Description
//  * Port - Number - Description
//  * Resource - String - Description
//  * Path - String - Description
//  * Query - Map - Description
//  * Fragment - String - Description
//  * Origin - String - Description
//  * Href - String - Description
//
Function URL(Val String, Query = Undefined) Export
    
    // http://username:password@hostname:8080/path?arg=value#anchor
    
    Auth = New Structure;
    Auth.Insert("User", Undefined); // username
    Auth.Insert("Pass", Undefined); // password
    
    Self = New Structure;
    Self.Insert("Scheme", "http");  // http
    Self.Insert("Auth", New FixedStructure(Auth));
    Self.Insert("Host", "");        // hostname
    Self.Insert("Port", 0);         // 8080
    Self.Insert("Resource", "");    // /path?arg=value#anchor
    Self.Insert("Path", "");        // /path
    Self.Insert("Query", New Map);  // arg=value
    Self.Insert("Fragment", "");    // anchor
    Self.Insert("Origin", "");      // http://hostname:8080
    Self.Insert("Href", "");        // full URI winthout Authority
    
    // Trim first-end spaces
    String = TrimAll(String);
    
    // Extract fragment
    Pos = StrFind(String, "#");
    If Pos > 0 Then 
        Self.Fragment = DecodeString(Mid(String, Pos + 1), StringEncodingMethod.URLInURLEncoding);
        String = Left(String, Pos - 1);
    EndIf;
    
    // Extract query
    Pos = StrFind(String, "?");
    If Pos > 0 Then 
        QueryPart = DecodeString(Mid(String, Pos + 1), StringEncodingMethod.URLInURLEncoding);
        For Each Param In StrSplit(QueryPart, "&") Do
            ParamParts = StrSplit(Param, "=");
            If ParamParts.Count() > 1 Then 
                Self.Query.Insert(ParamParts[0], ParamParts[1]);
            ElsIf ParamParts.Count() = 1 Then 
                Self.Query.Insert(ParamParts[0]);
            Else
                Raise RuntimeError(
                    NStr("en = 'Error while parsing query';
                         |ru = 'Ошибка при разборе запроса'")
                );
            EndIf;
        EndDo;
        String = Left(String, Pos - 1);
    EndIf;
    
    // Extract Scheme
    Pos = StrFind(String, ":");
    If Pos > 0 Then 
        Self.Scheme = Lower(Left(String, Pos - 1));
        String = Mid(String, Pos + 3);
    EndIf;
    
    // Extract username:password
    Pos = StrFind(String, "@");
    SlashPos = StrFind(String, "/");
    If Pos > 0 And (SlashPos = 0 Or Pos < SlashPos) Then
        Authority = DecodeString(Left(String, Pos - 1), StringEncodingMethod.URLInURLEncoding);
        AuthParts = StrSplit(Authority, ":");
        If AuthParts.Count() > 0 Then 
            Auth.User = AuthParts[0];
        EndIf;
        If AuthParts.Count() > 1 Then 
            Auth.Pass = AuthParts[1];
        EndIf;
        Self.Auth = New FixedStructure(Auth);
        String = Mid(String, Pos + 1);
    EndIf;
    
    // Extract host:port
    PortPart = "";
    Pos = StrFind(String, "/");
    If Pos = 0 Then 
        Pos = StrLen(String) + 1;
    EndIf;
    If StrStartsWith(String, "[") Then 
        // IPv6 host - http://tools.ietf.org/html/draft-ietf-6man-text-addr-representation-04#section-6
        BracketPos = StrFind(String, "]");
        Self.Host = Lower(Mid(String, 1, BracketPos));
        PortPart = Mid(String, BracketPos + 2, Pos - BracketPos - 2);
    Else
        HostPort = Lower(Left(String, Pos - 1));
        HostPortParts = StrSplit(HostPort, ":");
        If HostPortParts.Count() > 0 Then 
            Self.Host = HostPortParts[0];
        EndIf;
        If HostPortParts.Count() > 1 Then
            PortPart = HostPortParts[1];
        EndIf;
    EndIf;
    Integer = New TypeDescription("Number");
    Self.Port = Integer.AdjustValue(PortPart);
    String = Mid(String, Pos);
    
    // Last part must be the path
    Self.Path = String;
    
    // Set default port
    If Self.Port = 0 Then
        If Self.Scheme = "https" Then
            Self.Port = 443;
        ElsIf Self.Scheme = "http" Then
            Self.Port = 80;
        ElsIf Self.Scheme = "ftp" Then
            Self.Port = 21;
        Else 
            Raise NotImplementedError(StrTemplate(
                NStr("en = 'Not supported default protocol Scheme port <%1>';
                     |ru = 'Не поддерживаемый порт по умолчанию для протокола <%1>'"),
                Self.Scheme
            ));
        EndIf;
    EndIf;
    
    // Add custom query to URL
    If ValueIsFilled(Query) Then 
        For Each Param In Query Do
            If Self.Query.Get(Param.Key) = Undefined Then 
                Self.Query.Insert(Param.Key, Param.Value);
            Else 
                If TypeOf(Self.Query[Param.Key]) <> Type("Array") Then
                    CurrentValue = Self.Query[Param.Key]; 
                    Self.Query[Param.Key] = New Array;
                    Self.Query[Param.Key].Add(CurrentValue);
                 EndIf;
                If TypeOf(Param.Value) = Type("Array") Then
                    For Each Value In Param.Value Do
                        Self.Query[Param.Key].Add(Value);
                    EndDo;
                Else
                    Self.Query[Param.Key].Add(Param.Value);
                EndIf;
            EndIf;
        EndDo;
    EndIf;
    
    // Prepare resource property
    QueryPart = ToFormURLEncode(Self.Query);
    Self.Resource = Self.Path;
    If StrLen(QueryPart) > 0 Then
        Self.Resource = Self.Resource + "?" + QueryPart;
    EndIf;
    If StrLen(Self.Fragment) > 0 Then
        Self.Resource = Self.Resource + "#" + Self.Fragment;
    EndIf;
    
    // Prepare href property
    Self.Origin = Self.Scheme + "://" + Self.Host;
    DefaultPortHTTP = 80;
    DefaultPortHTTPS = 443;
    DefaultPort = (Self.Scheme = "http") And (Self.Port = DefaultPortHTTP)
        Or (Self.Scheme = "https") And (Self.Port = DefaultPortHTTPS);
    If Not DefaultPort Then 
        Self.Origin = Self.Origin + ":" + XMLString(Self.Port);
    EndIf;
    
    Self.Href = Self.Origin;
    If StrLen(Self.Resource) > 1 Then
        Self.Href = Self.Href + Self.Resource;
    EndIf;
    
    Return New FixedStructure(Self);
    
EndFunction

// Description
// 
// Returns:
//  Structure - contains: 
// * Headers - Map - Description
// * Auth - Structure - contains:
// ** Type - String - Basic, NTLM, Digest
// ** User - String - Description
// ** Password - String - Description
// * ValidateSSL - Boolean - Description
// * AllowRedirect - Boolean - Description
// * MaxRedirectCount - Number - Description
// * Timeout - Number - Description
//
Function Param() Export 
    
    Auth = New Structure;
    Auth.Insert("Type", "Basic");
    Auth.Insert("User", Undefined);
    Auth.Insert("Pass", Undefined);
    
    Self = New Structure;
    Self.Insert("Headers", DefaultHeaders());
    Self.Insert("Auth", Auth);
    Self.Insert("ValidateSSL", True);
    Self.Insert("AllowRedirect", True);
    Self.Insert("MaxRedirectCount", 7);
    Self.Insert("Timeout", 7);
    
    Return Self;
    
EndFunction

// Description
// 
// Returns:
//  Structure - contains:
// * Field - String - Description
// * Data - BinaryData - Description
// * FileName - String - Description
// * ContentType - String - Description
// * Headers - Map - Description
//
Function TransferedFile() Export 
    
    Self = New Structure;
    Self.Insert("Field", "");
    Self.Insert("Data", Undefined);
    Self.Insert("FileName", "");
    Self.Insert("ContentType", "application/octet-stream");
    Self.Insert("Headers", New Map);
    
    Return Self;
    
EndFunction

Function Session() Export
    
    Self = DataProcessors.HTTPSession.Create();
    Return Self;
    
EndFunction

// Description
// 
// Parameters:
//  URL - String - Description
//  Query - Map - Description
//  Param - see Param
// Returns:
//  DataProcessor.HTTPResponse
//
Function Get(URL, Query = Undefined, Param = Undefined) Export
    
    Session = Session();
    Return Session.Get(URL, Query, Param);
    
EndFunction

// Description
// 
// Parameters:
//  URL - String - Description
//  Param - see Param
//  Session - see Session
// Returns:
//  DataProcessor.HTTPResponse
//
Function Options(URL, Param = Undefined) Export
    
    Session = Session();
    Return Session.Options(URL, Param);
    
EndFunction

Function Head(URL, Param = Undefined) Export
    
    Session = Session();
    Return Session.Head(URL, Param);
    
EndFunction

// Parameters:
//  URL - String - Description
//  Data - Structure - Description
//  Files - Array contains see TransferedFile - Description
//  Param - see Param
//
Function Post(URL, Data = Undefined, Files = Undefined, Param = Undefined) Export
    
    Session = Session();
    Return Session.Post(URL, Data, Files, Param);
    
EndFunction

Function Put(URL, Data = Undefined, Param = Undefined) Export
    
    Session = Session();
    Return Session.Put(URL, Data, Param);
    
EndFunction

Function Patch(URL, Data = Undefined, Param = Undefined) Export
    
    Session = Session();
    Return Session.Patch(URL, Data, Param);
    
EndFunction

Function Delete(URL, Data = Undefined, Param = Undefined) Export
    
    Session = Session();
    Return Session.Delete(URL, Data, Param);
    
EndFunction

Function HeaderValue(Headers, Key, DefaultValue) Export
    
    For Each Header In Headers Do
        If Lower(Header.Key) = Lower(Key) Then
            Return Header.Value;
        EndIf;
    EndDo;
    
    Return DefaultValue;
    
EndFunction

Function ToFormURLEncode(Object) Export 
    
    ObjectParts = New Array;
    For Each Param In Object Do
        If TypeOf(Param.Value) = Type("Array") Then
            // Object param has multiple values
            For Each Value In Param.Value Do
                ObjectParts.Add(Param.Key + "=" + Value);
            EndDo;
        Else 
            ObjectParts.Add(Param.Key + "=" + Param.Value);
        EndIf;
    EndDo;
    
    Return StrConcat(ObjectParts, "&");
    
EndFunction

#EndRegion

#Region Private

Function DefaultHeaders()
    
    Self = New Map;
#If MobileAppServer Then
    Self.Insert("Accept", "*/*");
#Else // Desktop
	Self.Insert("Accept-Encoding", "gzip");
#EndIf
    
    Return Self;
    
EndFunction

// poolmanager

#EndRegion