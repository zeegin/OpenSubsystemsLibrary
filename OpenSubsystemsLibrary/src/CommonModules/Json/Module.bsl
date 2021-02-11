#Region Public

// Specifies settings for reading values from JSON format
// 
// Returns:
//  Structure - contains:
// * ReadToMap - Boolean - default is True
// * PropertiesWithDateValuesNames - Array contains String - for every fields with date values
//                                 - String - if JSON has only one date field
// * ExpectedDateFormat - JSONDateFormat - default is ISO "YYYY-MM-DDTHH:MM:SSZ" example "2009-02-15T00:00:00Z"
// * Encoding - TextEncoding - default is UTF-8
//            - String - JSONReader.OpenStream encodings
// 
Function DeserializerSettings() Export
    
    Self = New Structure;
    Self.Insert("ReadToMap", True);
    Self.Insert("PropertiesWithDateValuesNames", New Array);
    Self.Insert("ExpectedDateFormat", JSONDateFormat.ISO);
    Self.Insert("Encoding", TextEncoding.UTF8);
    
    Return Self;
    
EndFunction

// Loads JSON string or binary data to 1C value.
// 
// Parameters:
//  Object - String - loaded JSON
//         - BinaryData - loaded JSON
//  DeserializeSettings - see DeserializerSettings
//
// Returns:
//  Arbitrary - converted object
//
Function Loads(Object, DeserializerSettings = Undefined) Export
    
    If DeserializerSettings = Undefined Then
        DeserializerSettings = DeserializerSettings();
    EndIf;
    
    If TypeOf(Object) = Type("BinaryData") Then
        
        If Not ValueIsFilled(Object) Then
            Return ?(DeserializerSettings.ReadToMap, New Map, New Structure);
        EndIf;
        
        JSONReader = New JSONReader;
        JSONReader.OpenStream(Object.OpenStreamForRead(), DeserializerSettings.Encoding);
        
    ElsIf TypeOf(Object) = Type("String") Then
        
        If IsBlankString(Object) Then
            Return ?(DeserializerSettings.ReadToMap, New Map, New Structure);
        EndIf;
        
        JSONReader = New JSONReader;
        JSONReader.SetString(Object);
        
    Else 
        Raise NotImplementedError();
    EndIf;
    
    Value = ReadJSON(
        JSONReader,
        DeserializerSettings.ReadToMap,
        DeserializerSettings.PropertiesWithDateValuesNames,
        DeserializerSettings.ExpectedDateFormat
    );
    
    JSONReader.Close();
    
    Return Value;
    
EndFunction

// Dumps the 1C value to JSON string.
// 
// Parameters:
//  Value - String - converted object
//        - Number - converted object
//        - Boolean - converted object
//        - Date - converted object
//        - Array - converted object
//        - FixedArray - converted object
//        - Structure - converted object
//        - FixedStructure - converted object
//        - Map - converted object
//        - FixedMap - converted object
//  SerializerSettings - JSONSerializerSettings - for recording values in JSON format
//
// Returns:
//  String - completes JSON 
//
Function Dumps(Value, SerializerSettings = Undefined) Export
    
    If SerializerSettings = Undefined Then
        SerializerSettings = New JSONSerializerSettings;
    EndIf;
    
    JSONWriter = New JSONWriter;
    JSONWriter.SetString();
    
    WriteJSON(JSONWriter, Value, SerializerSettings);
    
    Return JSONWriter.Close();
    
EndFunction

#EndRegion
