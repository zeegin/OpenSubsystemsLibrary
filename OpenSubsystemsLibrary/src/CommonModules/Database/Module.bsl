#Region Public

// Check the reference exists in infobase at privilaged mode.
// 
// Parameters:
//  Ref - AnyRef - reference to checking
// 
// Returns:
//  Boolean - exists result
// 
Function Exists(Ref) Export 
    
    Query = New Query;
    Query.Parameters.Insert("Ref", Ref);
    
    Query.Text = 
        "SELECT
        |   T.Ref AS Ref
        |FROM
        |   &TableName AS T
        |WHERE
        |   T.Ref = &Ref";
    
    Query.Text = StrReplace(Query.Text, "&TableName", Ref.Metadata().FullName());
    
    SetPrivilegedMode(True);
    Result = Not Query.Execute().IsEmpty();
    SetPrivilegedMode(False);
    
    Return Result;
    
EndFunction

#EndRegion
