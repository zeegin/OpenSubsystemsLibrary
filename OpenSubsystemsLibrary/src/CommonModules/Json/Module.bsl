#Region Public

// Description
// 
// Returns:
//  Structure - contains:
// * ReadToMap - Boolean - Description
// * PropertiesWithDateValuesNames - Array contains String - Description
//                                 - String - Description
// * ExpectedDateFormat - JSONDateFormat - Description
// * Encoding - TextEncoding - Description
//            - String - Description
// 
Function DeserializerSettings() Export
    
    Self = New Structure;
    Self.Insert("ReadToMap", True);
    Self.Insert("PropertiesWithDateValuesNames", New Array);
    Self.Insert("ExpectedDateFormat", JSONDateFormat.ISO);
    Self.Insert("Encoding", TextEncoding.UTF8);
    
    Return Self;
    
EndFunction

// Description
// 
// Parameters:
//  Object - String - Description
//         - BinaryData - Description
//  DeserializeSettings - see DeserializerSettings
//
// Returns:
//  Arbitrary
//
Function Loads(Object, DeserializerSettings = Undefined) Export
    
    If DeserializerSettings = Undefined Then
        DeserializerSettings = DeserializerSettings();
    EndIf;
    
    If TypeOf(Object) = Type("BinaryData") Then
        
        JSONReader = New JSONReader;
        JSONReader.OpenStream(Object.OpenStreamForRead(), DeserializerSettings.Encoding);
        
    ElsIf TypeOf(Object) = Type("String") Then
        
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

// Description
// 
// Parameters:
// Value - String - Description
//       - Number - Description
//       - Boolean - Description
//       - Date - Description
//       - Array - Description
//       - FixedArray - Description
//       - Structure - Description
//       - FixedStructure - Description
//       - Map - Description
//       - FixedMap - Description
// SerializerSettings - JSONSerializerSettings - Description
//
// Returns:
//  JSONWriter
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
