#Region Variables

Var Headers Export;
Var StatusCode Export;
Var Encoding Export;
Var URL Export;

Var HTTPResponse;

#EndRegion

#Region Public

Procedure RaiseForStatus() Export 
    
    If Not Ok() Then 
        Raise RuntimeError(StrTemplate(
            NStr("en = 'Got status <%1> for <%2>.';
                 |ru = 'Получен статус <%1> при запросе <%2>.'"),
            StatusCode,
            URL.Href
        ));
    EndIf;
    
EndProcedure

Function BinaryData() Export
    
    ContentEncoding = HTTPRequests.HeaderValue(Headers, "content-encoding", "none");
    
#If Not MobileAppServer Then
    If Lower(ContentEncoding) = "gzip" Then
        Return GZip.Decompress(HTTPResponse.GetBodyAsStream());
    EndIf;
#EndIf
    
    Return HTTPResponse.GetBodyAsBinaryData();
    
EndFunction

Function Text() Export
    
    BinaryData = BinaryData();
    If Not ValueIsFilled(BinaryData) Then
        Return "";
    EndIf;
    
    Stream = BinaryData.OpenStreamForRead();
    
    TextReader = New TextReader(Stream, Encoding);
    Text = TextReader.Read();
    TextReader.Close();
    
    Return Text; 
    
EndFunction

Function Json(DeserializerSettings = Undefined) Export
    
    If DeserializerSettings = Undefined Then
        DeserializerSettings = Json.DeserializerSettings();
        DeserializerSettings.Encoding = Encoding;
    EndIf;
    
    Return Json.Loads(BinaryData(), DeserializerSettings);
    
EndFunction

// Returns True if status_code is less than 400, False if not.
// This attribute checks if the status code of the response
// is between 400 and 600 to see if there was a client error or a server error.
// If the status code is between 200 and 400, this will return True.
// This is not a check to see if the response code is 200 OK.
//
Function Ok() Export 
    
    StatusCodeClass = HTTPStatusCodes.StatusCodesClass(StatusCode);
    
    OkClasses = New Array;
    OkClasses.Add("Success");
    OkClasses.Add("Redirection");
    
    Return OkClasses.Find(StatusCodeClass) <> Undefined;
    
EndFunction

// Textual reason of responded HTTP Status, e.g. "Not Found" or "OK'.
//
Function Reason() Export 
    
    // TODO:
    Raise NotImplementedError();
    
EndFunction

#EndRegion

#Region Private

Procedure Ctor(HTTPResponse_, URL_) Export 
    
    HTTPResponse = HTTPResponse_;
    Headers = New FixedMap(HTTPResponse.Headers);
    StatusCode = HTTPResponse.StatusCode;
    Encoding = ResponseEncoding(HTTPResponse);
    URL = URL_;
    
EndProcedure

Function ResponseEncoding(HTTPResponse)
    
    ContentType = HTTPRequests.HeaderValue(HTTPResponse.Headers, "content-type", "");
    
    Options = Strings.SplitTrimAll(ContentType, ";");
    
    For Each Option In Options Do
        If StrStartsWith(Option, "charset=") Then
            Return Mid(Option, 9);
        EndIf;
    EndDo;
    
    Return "us-ascii";
    
EndFunction

#EndRegion
