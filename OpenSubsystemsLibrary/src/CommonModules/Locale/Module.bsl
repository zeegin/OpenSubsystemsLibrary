#Region Public

// System language Alpha-2 code ISO 639-1.
//
// Returns:
//  String - language code
Function SystemLanguage() Export
    
    Return Left(CurrentSystemLanguage(), 2);
    
EndFunction

#EndRegion