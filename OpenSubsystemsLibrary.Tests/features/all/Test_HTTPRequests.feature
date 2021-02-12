# language: en

@tree
@classname=ModuleExceptionPath

Feature: OpenSubsystemsLibrary.Tests.Test_HTTPRequests
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_URLParsed
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLParsed(Context());' |

@OnServer
Scenario: Test_URLConvertHostnameToLower
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLConvertHostnameToLower(Context());' |

@OnServer
Scenario: Test_URLDontConvertPathToLower
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLDontConvertPathToLower(Context());' |

@OnServer
Scenario: Test_URLRemoveDefaultPort
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLRemoveDefaultPort(Context());' |

@OnServer
Scenario: Test_URLUnderstandsSlashAsPath
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLUnderstandsSlashAsPath(Context());' |

@OnServer
Scenario: Test_URLIPv6
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLIPv6(Context());' |

@OnServer
Scenario: Test_URLIPv6Auth
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLIPv6Auth(Context());' |

@OnServer
Scenario: Test_URLIPv4
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLIPv4(Context());' |

@OnServer
Scenario: Test_URLIPv4Auth
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLIPv4Auth(Context());' |

@OnServer
Scenario: Test_URLDontConvertAuthToLower
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLDontConvertAuthToLower(Context());' |

@OnServer
Scenario: Test_URLEmptyAuth
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLEmptyAuth(Context());' |

@OnServer
Scenario: Test_URLAcceptAtInPath
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLAcceptAtInPath(Context());' |

@OnServer
Scenario: Test_URLSemanticAttack
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLSemanticAttack(Context());' |

@OnServer
Scenario: Test_URLJQLQuery
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLJQLQuery(Context());' |

@OnServer
Scenario: Test_URLQueryArrayArgs
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLQueryArrayArgs(Context());' |

@OnServer
Scenario: Test_URLIncludeURLEncoded
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_URLIncludeURLEncoded(Context());' |

@OnServer
Scenario: Test_PassQueryToRequest
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_PassQueryToRequest(Context());' |

@OnServer
Scenario: Test_PassQueryToRequestMult
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_PassQueryToRequestMult(Context());' |

@OnServer
Scenario: Test_ResponseAsJsonGet
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_ResponseAsJsonGet(Context());' |

@OnServer
Scenario: Test_ResponseAsJsonPost
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_ResponseAsJsonPost(Context());' |

@OnServer
Scenario: Test_ResponseAsString
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_ResponseAsString(Context());' |

@OnServer
Scenario: Test_ResponseAsBinaryData
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_ResponseAsBinaryData(Context());' |

@OnServer
Scenario: Test_GetJsonToStructure
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_GetJsonToStructure(Context());' |

@OnServer
Scenario: Test_PostJson
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_PostJson(Context());' |

@OnServer
Scenario: Test_PostJsonWithDate
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_PostJsonWithDate(Context());' |

@OnServer
Scenario: Test_PutJson
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_PutJson(Context());' |

@OnServer
Scenario: Test_BasicAuthByURL
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_BasicAuthByURL(Context());' |

@OnServer
Scenario: Test_BasicAuthByParam
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_BasicAuthByParam(Context());' |

@OnServer
Scenario: Test_BasicAuthByParamOverride
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_BasicAuthByParamOverride(Context());' |

@OnServer
Scenario: Test_Error404
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_Error404(Context());' |

@OnServer
Scenario: Test_Options
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_Options(Context());' |

@OnServer
Scenario: Test_Head
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_Head(Context());' |

@OnServer
Scenario: Test_Delete
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_Delete(Context());' |

@OnServer
Scenario: Test_Patch
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_Patch(Context());' |

@OnServer
Scenario: Test_GetWithCustomHeader
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_GetWithCustomHeader(Context());' |

@OnServer
Scenario: Test_PostFormData
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_PostFormData(Context());' |

@OnServer
Scenario: Test_GetTimeout
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_GetTimeout(Context());' |

@OnServer
Scenario: Test_GetRelativeRedirect
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_GetRelativeRedirect(Context());' |

@OnServer
Scenario: Test_GetAbsoluteRedirect
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_GetAbsoluteRedirect(Context());' |

@OnServer
Scenario: Test_GetDisabledRedirect
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_GetDisabledRedirect(Context());' |

@OnServer
Scenario: Test_GetTooMoreRedirect
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_GetTooMoreRedirect(Context());' |

@OnServer
Scenario: Test_GetGZip
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_GetGZip(Context());' |

@OnServer
Scenario: Test_GetGZipYaRu
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_GetGZipYaRu(Context());' |

@OnServer
Scenario: Test_PostMultipartFormDataAsDataFile
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_PostMultipartFormDataAsDataFile(Context());' |

@OnServer
Scenario: Test_PostMultipartFormDataAsStringFile
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_PostMultipartFormDataAsStringFile(Context());' |

@OnServer
Scenario: Test_PostMultipartFormDataAsDataAndFiles
	And I execute 1C:Enterprise script at server
	| 'Test_HTTPRequests.Test_PostMultipartFormDataAsDataAndFiles(Context());' |