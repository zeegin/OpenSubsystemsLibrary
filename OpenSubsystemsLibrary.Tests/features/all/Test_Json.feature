# language: en

@tree
@classname=ModuleExceptionPath

Feature: OpenSubsystemsLibrary.Tests.Test_Json
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_LoadsAsString
	And I execute 1C:Enterprise script at server
	| 'Test_Json.Test_LoadsAsString(Context());' |