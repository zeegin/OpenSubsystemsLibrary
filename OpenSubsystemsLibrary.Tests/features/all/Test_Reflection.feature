# language: en

@tree
@classname=ModuleExceptionPath

Feature: Reflection
	As Developer
	I want the returns value to be equal to expected value
	That I can guarantee the execution of the method

@OnServer
Scenario: Test_Reflection (server): Test_GetCommonModule
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_GetCommonModule(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_GetDataProcessorManagerModule
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_GetDataProcessorManagerModule(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_GetNotFoundCommonModule
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_GetNotFoundCommonModule(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_GetNotSupportedModule
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_GetNotSupportedModule(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_InvokeProcedureCommonModuleWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeProcedureCommonModuleWithoutParams(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_InvokeProcedureCommonModuleWithParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeProcedureCommonModuleWithParams(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_InvokeProcedureDataProcessorManagerModuleWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeProcedureDataProcessorManagerModuleWithoutParams(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_InvokeProcedureDataProcessorManagerModuleWithParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeProcedureDataProcessorManagerModuleWithParams(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_InvokeFunctionCommonModuleWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeFunctionCommonModuleWithoutParams(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_InvokeFunctionCommonModuleWithParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeFunctionCommonModuleWithParams(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_InvokeFunctionDataProcessorManagerModuleWithoutParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeFunctionDataProcessorManagerModuleWithoutParams(Context());' |

@OnServer
Scenario: Test_Reflection (server): Test_InvokeFunctionDataProcessorManagerModuleWithParams
	And I execute 1C:Enterprise script at server
	| 'Test_Reflection.Test_InvokeFunctionDataProcessorManagerModuleWithParams(Context());' |