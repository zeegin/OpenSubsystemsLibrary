[![Quality Gate Status](https://sonar.openbsl.ru/api/project_badges/measure?project=osl&metric=alert_status)](https://sonar.openbsl.ru/dashboard?id=osl)

# Open Subsystems Library

Open Subsystems Library is a simple.

[Quickstart Guide](docs/en/QuickstartGuide.md)

## Philosophy

Open Subsystems Library provide what you don't want to do — no more, no less.

## Goals and limitations

1. Concept of no-thick and no-COM configuration.
1. Small configuration size.
1. No SaaS mode.
1. No External data processors or reports in any internal storage support.
1. No RLS support.
1. No collaboration system support.
1. No predefined value.
1. Develop simple understandable standards (based on PEP8 for python).

## Dependencies

This project built with:
1. [1C:Enterprise](https://1c-dn.com) 8.3.18.1289+ (8.3.18 compatibility mode)
2. [1C:Enterprise Development Tools](https://edt.1c.ru) 2020.6.1
3. [1Unit](https://github.com/DoublesunRUS/ru.capralow.dt.unit.launcher)
4. [vanessa-automation](https://github.com/Pr-Mex/vanessa-automation)
5. [bslls-connector-for-edt](https://github.com/otymko/bslls-connector-for-edt)
6. [BSL Language Server](https://github.com/1c-syntax/bsl-language-server)

## Features map
<details>
<summary>
Expand table of feature status.
</summary>

| Subsystems                             | Status      |
| -------------------------------------- | ----------- |
| System                                 | In process  |
| + Asserts                              | Support     |
| + Collections                          | In process  |
| + Cryptography                         | In process  |
| + Useful database queries              | In process  |
| + Global exceptions                    | Support     |
| + Json serializer                      | Support     |
| + Useful OS methods                    | In process  |
| + Strings utils                        | In process  |
| + Reflection                           | Support     |
| + Background worker                    | In process  |
| + No-thick client static analize       | Support     |
| Aggregates and totals                  | Not started |
| + Scheduled jobs                       | Not started |
| + Settings form                        | Not started |
| Background jobs                        | Not started |
| + Monitor form                         | Not started |
| + Auto lock jobs if infobase was moved | Not started |
| Data exchange                          | Not started |
| + Distributed info base                | Not started |
| + OData                                | Not started |
| Data history                           | In process  |
| + Scheduled job for history update     | Support     |
| + Static analize role rights           | Not started |
| + Settings form                        | Not started |
| Delete marked objects                  | Not started |
| + Delete objects wizard                | Not started |
| + Concurent deleting objects algorithm | Not started |
| Digital signature                      | Not started |
| Event log                              | Not started |
| Full text search                       | Support     |
| + Scheduled jobs for index update      | Support     |
| HTTP requests                          | In process  |
| + URL Parser                           | Support     |
| + HTTP methods call                    | Support     |
| + Response as text                     | Support     |
| + Response as binary data              | Support     |
| + Response as json                     | Support     |
| + Basic auth                           | Support     |
| + Custom headers                       | Support     |
| + Autodetect sending content type      | Support     |
| + POST x-www-form-urlencoded           | Support     |
| + POST multipart/form-data             | Support     |
| + Timeouts                             | Support     |
| + Redirects                            | Support     |
| + GZip response content encoding       | Support     |
| + Sessions                             | In process  |
| + Cookies                              | In process  |
| + Digest auth                          | Not started |
| + OAuth                                | Not started |
| + Proxy                                | Not started |
| + getproxylist.com integration (idea?) | Not started |
| + Pool manager                         | Not started |
| + Unit tests                           | Support     |
| Lock data by date                      | Not started |
| + Lock data algorithm                  | Not started |
| + Lock data settings form              | Not started |
| Reports                                | Not started |
| Scheduled jobs                         | Not started |
| + Monitor form                         | Not started |
| Secure storage                         | Not started |
| Sessions lock                          | Not started |
| + Set sessions lock wizard             | Not started |
| + Auto disconnect sessions             | Not started |
| Stored files                           | Not started |
| + Amazon S3                            | Not started |
| + Dropbox                              | Not started |
| + Google disk                          | Not started |
| + Internal storage                     | Not started |
| + Network disk                         | Not started |
| + One drive                            | Not started |
| + Yandex disk                          | Not started |
| Notification                           | In process  |
| + Telegram                             | In process  |
| + Slack                                | Not started |
| Update                                 | Not started |
| Users                                  | In process  |
| + Session parameter of current user    | Support     |
| + \<Not specified\> default user       | Support     |
| + User item form                       | In process  |
| + Manage users in Enterprise mode      | Not started |

</details>
