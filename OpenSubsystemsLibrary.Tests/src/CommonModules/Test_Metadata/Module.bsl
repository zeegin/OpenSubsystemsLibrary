// @unit-test
Procedure Test_UnsupportedConfigurationProperties(Context) Export
    
#If Not MobileAppServer Then
    Assert.AreEqual(
        ClientRunMode.ManagedApplication,
        Metadata.DefaultRunMode
    );
#EndIf
    Assert.IsFalse(Metadata.UseManagedFormInOrdinaryApplication);
    Assert.IsFalse(Metadata.UseOrdinaryFormInManagedApplication);
    Assert.AreEqual(
        Metadata.ObjectProperties.ScriptVariant.English,
        Metadata.ScriptVariant
    );
    Assert.AreEqual(
        Metadata.ObjectProperties.DefaultDataLockControlMode.Managed,
        Metadata.DataLockControlMode
    );
    Assert.AreEqual(
        Metadata.ObjectProperties.ModalityUseMode.DontUse,
        Metadata.ModalityUseMode
    );
    Assert.AreEqual(
        Metadata.ObjectProperties.SynchronousPlatformExtensionAndAddInCallUseMode.DontUse,
        Metadata.SynchronousPlatformExtensionAndAddInCallUseMode
    );
    
EndProcedure

// @unit-test
Procedure Test_UnsupportedCommonModuleProperties(Context) Export
    
    For Each CommonModule In Metadata.CommonModules Do
        
        Assert.IsFalse(CommonModule.ExternalConnection);
        Assert.IsFalse(CommonModule.ClientOrdinaryApplication);
        Assert.IsFalse(CommonModule.Privileged);
        
    EndDo;
    
EndProcedure

// @unit-test
Procedure Test_UnsupportedRoleRights(Context) Export
    
    For Each Role In Metadata.Roles Do
        
        Assert.IsFalse(AccessRight("ThickClient", Metadata, Role));
        Assert.IsFalse(AccessRight("ExternalConnection", Metadata, Role));
        Assert.IsFalse(AccessRight("Automation", Metadata, Role));
        Assert.IsFalse(AccessRight("CollaborationSystemInfoBaseRegistration", Metadata, Role));
        // Assert.IsFalse(AccessRight("InteractiveOpenExtDataProcessors", Metadata, Role));
        // Assert.IsFalse(AccessRight("InteractiveOpenExtReports", Metadata, Role));
        
    EndDo;
    
EndProcedure