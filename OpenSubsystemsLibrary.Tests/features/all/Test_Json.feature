# language: en

@tree
@classname=ModuleExceptionPath

Feature: OpenSubsystemsLibrary.Tests.Test_Json
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_LoadsEmptyString
	And I execute 1C:Enterprise script at server
	| 'Test_Json.Test_LoadsEmptyString(Context());' |

@OnServer
Scenario: Test_LoadsEmptyBinaryData
	And I execute 1C:Enterprise script at server
	| 'Test_Json.Test_LoadsEmptyBinaryData(Context());' |

@OnServer
Scenario: Test_LoadsString
	And I execute 1C:Enterprise script at server
	| 'Test_Json.Test_LoadsString(Context());' |

@OnServer
Scenario: Test_LoadsBinaryData
	And I execute 1C:Enterprise script at server
	| 'Test_Json.Test_LoadsBinaryData(Context());' |