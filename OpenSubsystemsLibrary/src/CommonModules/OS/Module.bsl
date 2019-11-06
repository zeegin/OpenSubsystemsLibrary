#Region Public

Function PathJoin(Base, Path1, Path2 = Undefined, Path3 = Undefined) Export 
    
    Return Base + GetPathSeparator() + Path1;
    
EndFunction

#EndRegion
