#Region Private

Function StatusCodesClasses() Export
    
    Result = New Array;
    Result.Add("Undefined");
    Result.Add("Informational");
    Result.Add("Success");
    Result.Add("Redirection");
    Result.Add("ClientError");
    Result.Add("ServerError");
    
    Return New FixedArray(Result);

EndFunction

Function StatusCodes() Export
    
    Result = New Map;
    
    AddStatusCode(Result, 100, "CONTINUE_100", "Continue");
    AddStatusCode(Result, 101, "SWITCHING_PROTOCOLS_101", "Switching Protocols");
    AddStatusCode(Result, 102, "PROCESSING_102", "Processing");
    AddStatusCode(Result, 103, "CHECKPOINT_103", "Checkpoint");
    
    AddStatusCode(Result, 200, "OK_200", "OK");
    AddStatusCode(Result, 201, "CREATED_201", "Created");
    AddStatusCode(Result, 202, "ACCEPTED_202", "Accepted");
    AddStatusCode(Result, 203, "NON_AUTHORITATIVE_INFORMATION_203", "Non-Authoritative Information");
    AddStatusCode(Result, 204, "NO_CONTENT_204", "No Content");
    AddStatusCode(Result, 205, "RESET_CONTENT_205", "Reset Content");
    AddStatusCode(Result, 206, "PARTIAL_CONTENT_206", "Partial Content");
    AddStatusCode(Result, 207, "MULTI_STATUS_207", "Multi-Status");
    AddStatusCode(Result, 208, "ALREADY_REPORTED_208", "Already Reported");
    AddStatusCode(Result, 226, "IM_USED_226", "IM Used");
    
    AddStatusCode(Result, 300, "MULTIPLE_CHOICES_300", "Multiple сhoices");
    AddStatusCode(Result, 301, "MOVED_PERMANENTLY_301", "Moved Permanently");
    AddStatusCode(Result, 302, "FOUND_302", "Found");
    AddStatusCode(Result, 303, "SEE_OTHER_303", "See Other");
    AddStatusCode(Result, 304, "NOT_MODIFIED_304", "Not Modified");
    AddStatusCode(Result, 305, "USE_PROXY_305", "Use Proxy");
    AddStatusCode(Result, 307, "TEMPORARY_REDIRECT_307", "Temporary Redirect");
    AddStatusCode(Result, 308, "PERMANENT_REDIRECT_308", "Permanent Redirect");
    
    AddStatusCode(Result, 400, "BAD_REQUEST_400", "Bad Request");
    AddStatusCode(Result, 401, "UNAUTHORIZED_401", "Unauthorized");
    AddStatusCode(Result, 402, "PAYMENT_REQUIRED_402", "Payment Required");
    AddStatusCode(Result, 403, "FORBIDDEN_403", "Forbidden");
    AddStatusCode(Result, 404, "NOT_FOUND_404", "Not Found");
    AddStatusCode(Result, 405, "METHOD_NOT_ALLOWED_405", "Method Not Allowed");
    AddStatusCode(Result, 406, "NOT_ACCEPTABLE_406", "Not Acceptable");
    AddStatusCode(Result, 407, "PROXY_AUTHENTICATION_REQUIRED_407", "Proxy Authentication Required");
    AddStatusCode(Result, 408, "REQUEST_TIMEOUT_408", "Request Timeout");
    AddStatusCode(Result, 409, "CONFLICT_409", "Conflict");
    AddStatusCode(Result, 410, "GONE_410", "Gone");
    AddStatusCode(Result, 411, "LENGTH_REQUIRED_411", "Length Required");
    AddStatusCode(Result, 412, "PRECONDITION_FAILED_412", "Precondition Failed");
    AddStatusCode(Result, 413, "PAYLOAD_TOO_LARGE_413", "Payload Too Large");
    AddStatusCode(Result, 414, "URI_TOO_LONG_414", "URI Too Long");
    AddStatusCode(Result, 415, "UNSUPPORTED_MEDIA_TYPE_415", "Unsupported Media Type");
    AddStatusCode(Result, 416, "REQUESTED_RANGE_NOT_SATISFIABLE_416", "Requested range not satisfiable");
    AddStatusCode(Result, 417, "EXPECTATION_FAILED_417", "Expectation Failed");
    AddStatusCode(Result, 418, "I_AM_A_TEAPOT_418", "I'm a teapot");
    AddStatusCode(Result, 421, "DESTINATION_LOCKED_421", "Destination Locked");
    AddStatusCode(Result, 422, "UNPROCESSABLE_ENTITY_422", "Unprocessable Entity");
    AddStatusCode(Result, 423, "LOCKED_423", "Locked");
    AddStatusCode(Result, 424, "FAILED_DEPENDENCY_424", "Failed Dependency");
    AddStatusCode(Result, 426, "UPGRADE_REQUIRED_426", "Upgrade Required");
    AddStatusCode(Result, 428, "PRECONDITION_REQUIRED_428", "Precondition Required");
    AddStatusCode(Result, 429, "TOO_MANY_REQUESTS_429", "Too Many Requests");
    AddStatusCode(Result, 431, "REQUEST_HEADER_FIELDS_TOO_LARGE_431", "Request Header Fields Too Large");
    AddStatusCode(Result, 451, "UNAVAILABLE_FOR_LEGAL_REASONS_451", "Unavailable For Legal Reasons");

    AddStatusCode(Result, 500, "INTERNAL_SERVER_ERROR_500", "Internal Server Error");
    AddStatusCode(Result, 501, "NOT_IMPLEMENTED_501", "Not Implemented");
    AddStatusCode(Result, 502, "BAD_GATEWAY_502", "Bad Gateway");
    AddStatusCode(Result, 503, "SERVICE_UNAVAILABLE_503", "Service Unavailable");
    AddStatusCode(Result, 504, "GATEWAY_TIMEOUT_504", "Gateway Timeout");
    AddStatusCode(Result, 505, "HTTP_VERSION_NOT_SUPPORTED_505", "HTTP Version not supported");
    AddStatusCode(Result, 506, "VARIANT_ALSO_NEGOTIATES_506", "Variant Also Negotiates");
    AddStatusCode(Result, 507, "INSUFFICIENT_STORAGE_507", "Insufficient Storage");
    AddStatusCode(Result, 508, "LOOP_DETECTED_508", "Loop Detected");
    AddStatusCode(Result, 509, "BANDWIDTH_LIMIT_EXCEEDED_509", "Bandwidth Limit Exceeded");
    AddStatusCode(Result, 510, "NOT_EXTENDED_510", "Not Extended");
    AddStatusCode(Result, 511, "NETWORK_AUTHENTICATION_REQUIRED_511", "Network Authentication Required");

    Return New FixedMap(Result);
    
EndFunction

Procedure AddStatusCode(Result, Val Code, Val Id, Val ReasonPhrase)
    
    Description = New Structure();
    Description.Insert("Code", Code);
    Description.Insert("Id", Id);
    Description.Insert("ReasonPhrase", ReasonPhrase);

    Result.Insert(Id, Description);

EndProcedure

#EndRegion