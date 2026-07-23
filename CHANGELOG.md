# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [5.0.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v4.1.2...v5.0.0) (2026-07-23)


### ⚠ BREAKING CHANGES

* only support OIDC authentication ([#4](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/issues/4))

### 🚀 Features

* only support OIDC authentication ([#4](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/issues/4)) ([b379a2a](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/b379a2ac1227179d3f49f0e639be8d5deda0fef8))

## [4.1.2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v4.1.1...v4.1.2) (2026-07-07)


### 🐛 Fixes

* migrate MCAF module sources ([#2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/issues/2)) ([0b22971](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/0b22971c4087d5d737cb8f85ee7b17c1be203dda))

## [4.1.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v4.1.0...v4.1.1) (2026-06-29)


### 🐛 Fixes

* Organisation is mandatory when used with OIDC ([#85](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/85)) ([e8876bd](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/e8876bd832d12bc4cd0dea9e27536bd67a90d632))

## [4.1.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v4.0.0...v4.1.0) (2026-04-16)


### 🚀 Features

* Add postfix option for Authentication ([#84](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/84)) ([419e1d2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/419e1d26ef90c7eede4d3cce8b796f8ab73e402d))
* Add postfix option for Authentication ([#84](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/84)) ([419e1d2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/419e1d26ef90c7eede4d3cce8b796f8ab73e402d))

### 🐛 Fixes

* Change the path default value ([#83](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/83)) ([bf9708f](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/bf9708f550a99f729b4fb6b848d9d07fb5200a69))

## [4.0.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v3.1.1...v4.0.0) (2026-03-31)


### ⚠ BREAKING CHANGES

* known after apply issues with tfe project ([#79](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/79))

### 🐛 Fixes

* known after apply issues with tfe project ([#79](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/79)) ([d8e282b](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/d8e282b925c68240a5b8a87c600c484275c38513))

## [3.1.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v3.1.0...v3.1.1) (2026-03-31)


### 🐛 Fixes

* oidc_settings type validation fails when set to null ([#82](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/82)) ([2fffaa3](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/2fffaa34b9a5f74cf6ee2f6f157e592a7f224050))

## [3.1.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v3.0.0...v3.1.0) (2026-02-19)


### 🚀 Features

* move authentication to a submodule ([#78](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/78)) ([199c478](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/199c478ed0bfe455be35d4b6bd5725de12a40dbe))

## [3.0.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.7.0...v3.0.0) (2026-02-09)


### ⚠ BREAKING CHANGES

* enable project-scoped OIDC roles ([#76](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/76))
* Remove deprecated vars trigger_prefixes and workspace_tags ([#77](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/77))

### 🚀 Features

* enable project-scoped OIDC roles ([#76](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/76)) ([ac615f0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/ac615f0f6d5734f79d1e08fe34303ab0653e0f17))
* Remove deprecated vars trigger_prefixes and workspace_tags ([#77](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/77)) ([b4b892a](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/b4b892a5d2f0134ce1b868771f245aebf2001df6))

## [2.7.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.6.0...v2.7.0) (2025-11-24)


### 🚀 Features

* Improve trigger pattern flexibility ([#75](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/75)) ([c2a9535](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/c2a95351a61eca55bfc2741e3c2e1d2c7cb08477))

## [2.6.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.5.0...v2.6.0) (2025-11-19)


### 🚀 Features

* update mcaf-workspace to v2.6.0 ([#74](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/74)) ([c650146](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/c6501464d2ba0cb69995f3a2f81797087687db11))

## [2.5.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.4.0...v2.5.0) (2025-03-17)


### 🚀 Features

* enhancement: bump tfe-mcaf-workspace to 2.4.x ([#73](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/73)) ([64641ac](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/64641ace2b968f44c5160da55323436ce845435d))

## [2.4.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.3.0...v2.4.0) (2025-02-24)


### 🚀 Features

* enhancement: move trigger_prefix default values to trigger_patterns ([#72](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/72)) ([2d7fc9d](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/2d7fc9dea50ce1648f344f7111d63f35ecbf5cd9))

## [2.3.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.2.0...v2.3.0) (2025-01-28)


### 🚀 Features

* Add speculative_enabled option ([#71](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/71)) ([d12d663](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/d12d6638e4daae4d928bd94de1347af398ca663d))

## [2.2.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.1.1...v2.2.0) (2025-01-10)


### 🚀 Features

* Support GitHub app for VCS connections, solve deprecation warning ([#70](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/70)) ([131f583](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/131f58318632b647d14fce76dce694f82dd856ac))

## [2.1.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.1.0...v2.1.1) (2024-10-29)


### 🐛 Fixes

* do not set `DEFAULT_REGION` env var if `var.region` is empty ([#69](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/69)) ([bdf8280](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/bdf828003455dcfa79cc02b186e9ab123e141354))

## [2.1.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.0.1...v2.1.0) (2024-09-19)


### 🚀 Features

* Move User module to the TF Registry ([#68](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/68)) ([f415ebf](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/f415ebffa8faa22a4e6a8d28aae541b04aa1fed2))
* enhancement: Move to use terraform-tfe-mcaf-workspace module ([#67](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/67)) ([6b74da0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/6b74da04da55b8f6e485371d180cf210da95950b))

## [2.0.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v2.0.0...v2.0.1) (2024-08-08)


### 🐛 Fixes

* ensure that when `notification_configuration` or `team_access` is set to `null` the default value is used ([#66](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/66)) ([4c84e0c](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/4c84e0cba5d4602c6f23a7f241bcd914c4526325))

## [2.0.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v1.3.0...v2.0.0) (2024-08-05)


### 🚀 Features

* breaking: set default auth mode from 'iam_user' to 'iam_role_oidc' ([#65](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/65)) ([38d843e](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/38d843e2107ca54199fad249a7d444e3e5043967))
* breaking: solve bug where 'notification_configuration' can not contain sensitive values or values known after apply ([#64](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/64)) ([0e7b6f5](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/0e7b6f5f873d4f5b88c8523af7f853657c1a1a74))

### 🐛 Fixes

* breaking: solve bug where 'notification_configuration' can not contain sensitive values or values known after apply ([#64](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/64)) ([0e7b6f5](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/0e7b6f5f873d4f5b88c8523af7f853657c1a1a74))

## [1.3.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v1.2.0...v1.3.0) (2024-07-29)


### 🚀 Features

* ability to pass down variable set id's that will be associated with the workspace (workspace variable set) ([#62](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/62)) ([c7c5731](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/c7c573119cf49c72cbe039f44668e8c6d7119837))

## [1.2.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v1.1.2...v1.2.0) (2024-07-25)


### 🚀 Features

* lifecycle management - add support for many new variables ([#61](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/61)) ([23779ea](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/23779ea57649a317bc09a8926e93aabfa16cc692))

## [1.1.2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v1.1.1...v1.1.2) (2024-03-04)


### 🐛 Fixes

* Add missing `workload_name` output ([#60](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/60)) ([3e5f9ec](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/3e5f9ec7a75ebfaf7907f327ed88353553371b5c))

## [1.1.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v1.1.0...v1.1.1) (2024-03-01)


### 🐛 Fixes

* add condition to agent_pool_id to allow for unchanged MCAF AVM condition ([#59](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/59)) ([3d143e2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/3d143e2f27314d5f36fb64145dd27e54b6529998))

## [1.1.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v1.0.0...v1.1.0) (2023-12-19)


### 🚀 Features

* enhancement: Refactor away deprecation warning & set minimum tfe version to v0.51.0 ([#58](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/58)) ([bb67622](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/bb676220b1ab2923b9286200a07675aeef1bb769))

## [1.0.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.15.2...v1.0.0) (2023-11-10)


### 🚀 Features

* breaking: notification support for `microsoft-teams` ([#57](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/57)) ([1fc6736](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/1fc67365c1452f687106bf3c7eac94136475a424))
* Add queue all runs ([#56](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/56)) ([cddda0c](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/cddda0cd46efb7a915aadddbf3a77d9e75012011))

## [0.15.2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.15.1...v0.15.2) (2023-11-07)

## [0.15.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.15.0...v0.15.1) (2023-09-14)

## [0.15.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.14.1...v0.15.0) (2023-09-14)


### 🚀 Features

* Add OIDC support ([#54](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/pull/54)) ([60f6f8f](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/commit/60f6f8fe6ca96a879ed6097c9236c8ae04e41688))

## [0.14.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.14.0...v0.14.1) (2023-02-15)

## [0.14.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.13.1...v0.14.0) (2023-02-02)

## [0.13.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.13.0...v0.13.1) (2023-01-26)

## [0.13.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.12.0...v0.13.0) (2023-01-18)

## [0.12.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.11.0...v0.12.0) (2023-01-17)

## [0.11.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.10.0...v0.11.0) (2023-01-11)

## [0.10.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.9.1...v0.10.0) (2023-01-03)

## [0.9.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.9.0...v0.9.1) (2022-12-12)

## [0.9.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.8.1...v0.9.0) (2022-11-14)

## [0.8.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.8.0...v0.8.1) (2022-05-31)

## [0.8.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.7.1...v0.8.0) (2022-04-27)

## [0.7.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.7.0...v0.7.1) (2022-01-27)

## [0.7.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.6.0...v0.7.0) (2022-01-14)

## [0.6.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.5.4...v0.6.0) (2021-10-20)

## [0.5.4](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.5.3...v0.5.4) (2021-09-29)

## [0.5.3](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.5.2...v0.5.3) (2021-09-15)

## [0.5.2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.5.1...v0.5.2) (2021-06-22)

## [0.5.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.4.4...v0.5.1) (2021-06-10)

## [0.4.4](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.5.0...v0.4.4) (2021-05-20)

## [0.5.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.2.6...v0.5.0) (2021-05-20)

## [0.2.6](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.4.3...v0.2.6) (2021-05-03)

## [0.4.3](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.2.5...v0.4.3) (2021-05-03)

## [0.2.5](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.4.2...v0.2.5) (2021-04-16)

## [0.4.2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.3.1...v0.4.2) (2021-04-16)

## [0.3.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.4.1...v0.3.1) (2021-03-24)

## [0.4.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.4.0...v0.4.1) (2021-02-01)

## [0.4.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.3.0...v0.4.0) (2020-11-30)

## [0.3.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.2.3...v0.3.0) (2020-11-19)

## [0.2.3](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.2.4...v0.2.3) (2020-10-29)

## [0.2.4](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.2.2...v0.2.4) (2020-10-29)

## [0.2.2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.2.1...v0.2.2) (2020-10-12)

## [0.2.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.2.0...v0.2.1) (2020-09-16)

## [0.2.0](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.11...v0.2.0) (2020-08-13)

## [0.1.11](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.10...v0.1.11) (2020-08-11)

## [0.1.10](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.9...v0.1.10) (2020-06-10)

## [0.1.9](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.8...v0.1.9) (2020-06-08)

## [0.1.8](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.7...v0.1.8) (2020-06-04)

## [0.1.7](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.6...v0.1.7) (2020-04-07)

## [0.1.6](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.5...v0.1.6) (2020-04-03)

## [0.1.5](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.4...v0.1.5) (2020-02-27)

## [0.1.4](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.3...v0.1.4) (2020-02-26)

## [0.1.3](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.2...v0.1.3) (2020-02-10)

## [0.1.2](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.1...v0.1.2) (2019-11-22)

## [0.1.1](https://github.com/schubergphilis-ep/terraform-aws-mcaf-workspace/compare/v0.1.0...v0.1.1) (2019-11-14)

## 0.1.0 (2019-11-05)
