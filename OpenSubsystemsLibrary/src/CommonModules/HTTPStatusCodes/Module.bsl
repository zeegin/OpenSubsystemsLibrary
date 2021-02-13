#Region Public

// Returns a string representation of the HTTP status code class by its three-digit numeric code.
//
// Parameters:
//  Code - Number - three-digit numeric HTTP status code;
// 
// Returns:
//  - String - possible values: "Undefined", "Informational", "Success", "Redirection", "ClientError", "ServerError";
//
Function StatusCodesClass(Val Code) Export
    
    COUNT_CODES_IN_CLASS = 100;
    UNDEFINED_CLASS = 0;
    FIRST_CLASS = 1;
    LAST_CLASS = 5;
    
    GroupNumber = Int(Code / COUNT_CODES_IN_CLASS);
    
    If (GroupNumber < FIRST_CLASS И GroupNumber > LAST_CLASS) Then
        GroupNumber = UNDEFINED_CLASS;
    EndIf;
    
    Return HTTPStatusCodesImplCached.StatusCodesClasses()[GroupNumber];
    
EndFunction

#EndRegion