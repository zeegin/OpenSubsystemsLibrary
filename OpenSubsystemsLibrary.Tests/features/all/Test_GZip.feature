# language: en

@tree
@classname=ModuleExceptionPath

Feature: OpenSubsystemsLibrary.Tests.Test_GZip
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_GZipPingPong
	And I execute 1C:Enterprise script at server
	| 'Test_GZip.Test_GZipPingPong(Context());' |

@OnServer
Scenario: Test_GZipCompress
	And I execute 1C:Enterprise script at server
	| 'Test_GZip.Test_GZipCompress(Context());' |

@OnServer
Scenario: Test_GZipDecompress
	And I execute 1C:Enterprise script at server
	| 'Test_GZip.Test_GZipDecompress(Context());' |