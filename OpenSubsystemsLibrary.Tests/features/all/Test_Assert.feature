# language: en

@tree
@classname=ModuleExceptionPath

Feature: Assert
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_Assert (server): Test_AssertErrorWithoutMessage
	And I execute 1C:Enterprise script at server
	| 'Test_Assert.Test_AssertErrorWithoutMessage(Context());' |

@OnServer
Scenario: Test_Assert (server): Test_AssertErrorWithMessage
	And I execute 1C:Enterprise script at server
	| 'Test_Assert.Test_AssertErrorWithMessage(Context());' |