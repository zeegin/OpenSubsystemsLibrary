// BSLLS:UsingServiceTag-off
// BSLLS:MissingParameterDescription-off
// BSLLS:CodeOutOfRegion-off

// @unit-test
Procedure Test_UnsupportedConfigurationProperties(Context) Export
    
#If Not MobileAppServer Then
    Assert.AreEqual(
        ClientRunMode.ManagedApplication,
        Metadata.DefaultRunMode,
        "DefaultRunMode"
    );
#EndIf
    Assert.IsFalse(
        Metadata.UseManagedFormInOrdinaryApplication,
        "UseManagedFormInOrdinaryApplication"
    );
    Assert.IsFalse(
        Metadata.UseOrdinaryFormInManagedApplication,
        "UseOrdinaryFormInManagedApplication"
    );
    Assert.AreEqual(
        Metadata.ObjectProperties.ScriptVariant.English,
        Metadata.ScriptVariant,
        "ScriptVariant"
    );
    Assert.AreEqual(
        Metadata.ObjectProperties.DefaultDataLockControlMode.Managed,
        Metadata.DataLockControlMode,
        "DataLockControlMode"
    );
    Assert.AreEqual(
        Metadata.ObjectProperties.ModalityUseMode.DontUse,
        Metadata.ModalityUseMode,
        "ModalityUseMode"
    );
    Assert.AreEqual(
        Metadata.ObjectProperties.SynchronousPlatformExtensionAndAddInCallUseMode.DontUse,
        Metadata.SynchronousPlatformExtensionAndAddInCallUseMode,
        "SynchronousPlatformExtensionAndAddInCallUseMode"
    );
    
EndProcedure

// @unit-test
Procedure Test_UnsupportedCommonModuleProperties(Context) Export
    
    For Each CommonModule In Metadata.CommonModules Do
        
        Assert.IsFalse(
            CommonModule.ExternalConnection,
            "ExternalConnection at " + CommonModule.Name
        );
        Assert.IsFalse(
            CommonModule.ClientOrdinaryApplication,
            "ClientOrdinaryApplication at " + CommonModule.Name
        );
        Assert.IsFalse(
            CommonModule.Privileged,
            "Privileged at " + CommonModule.Name
        );
        
    EndDo;
    
EndProcedure

// @unit-test
Procedure Test_UnsupportedRoleRights(Context) Export
    
    For Each Role In Metadata.Roles Do
        
        Assert.IsFalse(
            AccessRight("ThickClient", Metadata, Role),
            "ThickClient at " + Role.Name
        );
        Assert.IsFalse(
            AccessRight("ExternalConnection", Metadata, Role),
            "ExternalConnection at " + Role.Name
        );
        Assert.IsFalse(
            AccessRight("Automation", Metadata, Role),
            "Automation at " + Role.Name
        );
        Assert.IsFalse(
            AccessRight("CollaborationSystemInfoBaseRegistration", Metadata, Role),
            "CollaborationSystemInfoBaseRegistration at " + Role.Name
        );
        If Role <> Metadata.Roles.InteractiveOpenExt Then
            Assert.IsFalse(
                AccessRight("InteractiveOpenExtDataProcessors", Metadata, Role),
                "InteractiveOpenExtDataProcessors at " + Role.Name
            );
            Assert.IsFalse(
                AccessRight("InteractiveOpenExtReports", Metadata, Role),
                "InteractiveOpenExtReports at " + Role.Name
            );
        EndIf;
        
    EndDo;
    
EndProcedure