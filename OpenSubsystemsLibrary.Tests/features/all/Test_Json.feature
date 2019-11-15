# language: en

@tree
@classname=ModuleExceptionPath

Feature: Json
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_Json (server): Test_LoadsAsString
	And I execute 1C:Enterprise script at server
	| 'Test_Json.Test_LoadsAsString(Context());' |