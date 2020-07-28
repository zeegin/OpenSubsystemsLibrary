# language: en

@tree
@classname=ModuleExceptionPath

Feature: OpenSubsystemsLibrary.Tests.Test_Metadata
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_UnsupportedConfigurationProperties
	And I execute 1C:Enterprise script at server
	| 'Test_Metadata.Test_UnsupportedConfigurationProperties(Context());' |

@OnServer
Scenario: Test_UnsupportedCommonModuleProperties
	And I execute 1C:Enterprise script at server
	| 'Test_Metadata.Test_UnsupportedCommonModuleProperties(Context());' |

@OnServer
Scenario: Test_UnsupportedRoleRights
	And I execute 1C:Enterprise script at server
	| 'Test_Metadata.Test_UnsupportedRoleRights(Context());' |