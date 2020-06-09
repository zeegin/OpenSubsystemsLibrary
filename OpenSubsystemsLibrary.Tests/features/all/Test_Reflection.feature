# language: en

@tree
@classname=ModuleExceptionPath

Feature: OpenSubsystemsLibrary.Tests.Test_Reflection
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_GetCommonModule
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_GetCommonModule(Context());' |

@OnServer
Scenario: Test_GetDataProcessorManagerModule
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_GetDataProcessorManagerModule(Context());' |

@OnServer
Scenario: Test_GetNotFoundCommonModule
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_GetNotFoundCommonModule(Context());' |

@OnServer
Scenario: Test_GetNotSupportedModule
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_GetNotSupportedModule(Context());' |

@OnServer
Scenario: Test_InvokeProcedureCommonModuleWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeProcedureCommonModuleWithoutParams(Context());' |

@OnServer
Scenario: Test_InvokeProcedureCommonModuleWithParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeProcedureCommonModuleWithParams(Context());' |

@OnServer
Scenario: Test_InvokeProcedureDataProcessorManagerModuleWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeProcedureDataProcessorManagerModuleWithoutParams(Context());' |

@OnServer
Scenario: Test_InvokeProcedureDataProcessorManagerModuleWithParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeProcedureDataProcessorManagerModuleWithParams(Context());' |

@OnServer
Scenario: Test_InvokeFunctionCommonModuleWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeFunctionCommonModuleWithoutParams(Context());' |

@OnServer
Scenario: Test_InvokeFunctionCommonModuleWithParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeFunctionCommonModuleWithParams(Context());' |

@OnServer
Scenario: Test_InvokeFunctionDataProcessorManagerModuleWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeFunctionDataProcessorManagerModuleWithoutParams(Context());' |

@OnServer
Scenario: Test_InvokeFunctionDataProcessorManagerModuleWithParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeFunctionDataProcessorManagerModuleWithParams(Context());' |