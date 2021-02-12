# language: en

@tree
@classname=ModuleExceptionPath

Feature: OpenSubsystemsLibrary.Tests.Test_Cryptography
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_HMAC
	And I execute 1C:Enterprise script at server
	| 'Test_Cryptography.Test_HMAC(Context());' |