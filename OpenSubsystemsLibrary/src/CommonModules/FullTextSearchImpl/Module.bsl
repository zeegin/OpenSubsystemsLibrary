#Region Private

Procedure _UpdatePartialFullTextSearchIndex() Export
    
    If FullTextSearch.GetFullTextSearchMode() = FullTextSearchMode.Enable
        And Not FullTextSearch.IndexTrue() Then 
        
        FullTextSearch.UpdateIndex(False, True);
    EndIf;
    
EndProcedure

Procedure _MergePartialFullTextSearchIndex() Export
    
    If FullTextSearch.GetFullTextSearchMode() = FullTextSearchMode.Enable
        And Not FullTextSearch.IndexUpdateComplete() Then 
        
        FullTextSearch.UpdateIndex(True);
    EndIf;
    
EndProcedure

#EndRegion