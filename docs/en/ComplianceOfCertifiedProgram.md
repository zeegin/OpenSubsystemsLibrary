# Compliance with the requirements of 1C certified program

[Requirements (RU)](https://1c.ru/rus/products/1c/predpr/compat/soft/requirements.htm)

1.1. It's not end-product, it is library to help you build your end-product.

1.2. We have great docs for developers!

1.3. Not required user manual, because we have intuitive interface.

1.4. We use only the standard documented features of the 1C:Enterprise platform.

1.5. **!!! In the plans...** This is a requirement for CI/CD, not yet implemented.

1.6. We do not use the logo of 1C or 1C:Franchisee. Also, we have no plans to apply for certification 1C:Compatible. Despite the fact that we fulfill the requirements for this certification :)

1.7. Each pool-request to the library will be checked for compliance with certification to helps you get certification to your end-product.

1.8. You can verify license cleanliness by reading the [LICENSE](../../LICENSE) files.

1.9. Each borrowed code is checked for compliance with the license of this library and added to [LICENSE.NOTICE](../../LICENSE.NOTICE).

1.10. The library code does not use the code borrowed in standard 1C configurations.

2.1.1. We always provide upgrade from previous version.

2.1.2. **!!! Not compatible!** We use [Semantic Versioning](https://semver.org/) to control API capability and data updates. Which uses 3 groups of numbers to set the version, instead of 4 used in [#std483 (RU)](https://its.1c.ru/db/v8std#content:483).

2.1.3. We don't use `standard 1C configuration` term.

2.1.4. Library supported works in every SDBL and OS that officially supported by 1C:Enterprise platform.

2.1.5. We have no plans to support thick-client (ordinary and managed application) and external COM-connection. This is a deliberate limitation.

2.1.6. Library correctly works in multiple time zones.

2.1.7. **!!! In the plans...** This is a requirement for the subsystem "System", not yet implemented.

2.1.8. We don't use AddIns in the moment.

2.1.9. We write our copyright in the configuration properties for our demo configuration, but you can free rewrite it in your end-product.

2.2.1. **!!! In the plans...** This is a requirement for the subsystem "Update", not yet implemented.

2.2.2. **!!! In the plans...** This is a requirement for the subsystem "Update", not yet implemented.

2.3.1. Metadata names to contains not over 80 chars is controlled by 1C:Designer and 1C:EDT.

2.3.2. Synonyms concise.

2.3.2.1. We maintain the purity of speech in both English and Russian localization.

2.3.2.2. Synonyms always concise.

2.3.2.3. **!!! Make static analize** to control metadata standard attributes names for `Parent` and `Owner`.

2.3.3. We don't use comments to metadata objects, it's always empty.

2.3.4. Static analize rule [BSLLS:YoLetterUsage](https://1c-syntax.github.io/bsl-language-server/en/diagnostics/YoLetterUsage/).

2.3.5. We always sort first-level metadata by name order.

2.3.6. **!!! Make static analize** to control help pages and mayby genarate it from the markdown docs.

2.3.7. Static analize rule [BSLLS:UnreachableCode](https://1c-syntax.github.io/bsl-language-server/en/diagnostics/UnreachableCode/).

2.3.8. We don't use 1C:SL and use only native platform object `Metadata` instead of creating cached catalog with identifiers of metadata and havent headache with support it.

2.3.9. We have managed transaction mode.

2.4. [...] Interface style guide is fully compatible to [#std (RU)](https://its.1c.ru/db/v8std#browse:13:-1:7).

2.5.1. Static analize rule [BSLLS:OneStatementPerLine](https://1c-syntax.github.io/bsl-language-server/en/diagnostics/OneStatementPerLine/).

2.5.2. **!!! Not compatible!** We use 4 spaces per indentation level!

2.5.3. We use 3 static analizers: 1C:Designer, 1C:EDT and BSLLS. Public results of static control is [Sonar Gate](https://sonar.openbsl.ru/dashboard?id=osl).

2.5.4. All configuration checks are always passed.

2.5.5. The library has only one export variable in application module `AppSettings`.

2.5.6. Modules code regions are full compatible [#std455 (RU)](https://its.1c.ru/db/v8std#content:455).

2.5.7. Methods descriptions of public interface are full compatible [#std453 (RU)](https://its.1c.ru/db/v8std#content:453).

2.5.8. Static analize rules:

  - **!!! Make static analize** for comments
  - [BSLLS:LineLength](https://1c-syntax.github.io/bsl-language-server/en/diagnostics/LineLength/)
  - [BSLLS:SpaceAtStartComment](https://1c-syntax.github.io/bsl-language-server/en/diagnostics/SpaceAtStartComment/)

2.5.9. All comments are polite and clear.

2.5.10. **!!! Make static analize** variables names.

2.5.11. Static analize rules:

  - [BSLLS:UnusedLocalMethod](https://1c-syntax.github.io/bsl-language-server/en/diagnostics/UnusedLocalMethod/)
  - [BSLLS:CommentedCode](https://1c-syntax.github.io/bsl-language-server/en/diagnostics/CommentedCode/)

2.5.12. Library don't use predifined variable.

2.5.13. Static analize rule [BSLLS:UsingGoto](https://1c-syntax.github.io/bsl-language-server/en/diagnostics/UsingGoto/). 

2.5.14. **!!! Make static analyze** to controll public interface in form modules.

2.5.15. All comands are monualy controlled for `ModifiesData` property.

2.5.16. Library has `ModalityUseMode` property is setted to `DontUse`.

2.5.17. **!!! Make static analize** control command modules.

2.5.18. Library has `Reflection` module that controlled sefe execution of external code.

2.5.19. Library don't store of external code or data processors or reports.

2.5.20. `OnExit` event handlers to use async invocations are controlled with 1C:Designer and 1C:EDT.

2.5.21. `BeforeExit` event handlers to use async invocations are controlled with 1C:Designer and 1C:EDT.

2.6.1. **!!! Not compatible!** We don't devide `SystemAdministarator` and `Full rights` because we don't support SaaS mode and it's excessively for us.

2.6.2. `Full rights` are full compatible in case that all our metadata is separated SaaS data.

2.6.3. **!!! Not compatible!** Role `SystemAdministarator` not provided.

2.6.4. **!!! Not compatible!** We don't provide interactive open any external data processors without spacial extension to grant this permissions.

2.6.5. `Default roles` configuration property contains `Full rights` role.

2.6.6. **!!! Make static analize** to control roles rights.

2.7. [...] Query keyworks controlled with 1C:EDT.

2.8.1. All user messages polite and concise.

2.8.2. Library warning about all actions.

2.8.3. Library provide `BackgroundWorker` thich warning about long-time actions.

2.8.4. Modal dialogs not supported.

2.8.5-2.8.9. [...] Manualy controlled all user interactions.

2.8.10. Static analize rule [BSLLS:DeprecatedMessage](https://1c-syntax.github.io/bsl-language-server/en/diagnostics/DeprecatedMessage/).

2.9.1. Docs:

  - [Quickstart guide](QuickstartGuide.md)
  - [README](../../README.md) and [Style guide](StyleGuide.md)
  - **!!! make docs by subsystems**

2.9.2. The library code does not use the code borrowed in standard 1C configurations.

2.9.3. We don't use AddIns in the moment.

2.9.4. We write [CHANGELOG](../../CHANGELOG) that is based on  [Keep a Changelog](http://keepachangelog.com/).

2.10. **!!! In the plans...** This is a requirement for CI/CD, not yet implemented.

3-8. [...] Not required for the library.
