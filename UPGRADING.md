# Upgrading Notes

This document captures required refactoring on your part when upgrading to a module version that contains breaking changes.

## Upgrading to v5.0.0

This release drops support for every authentication method except OIDC. The module now always provisions an IAM role that Terraform Cloud assumes via OIDC workload identity.

### Variables (v5.0.0)

The following variables have been **removed**:

- `auth_method` — OIDC is now the only supported method, so there is nothing to choose.
- `username` — only used by the removed `iam_user` method.
- `agent_role_arns` — only used by the removed static-credential `iam_role` method.

If you previously set `auth_method = "iam_user"` or `auth_method = "iam_role"`, switch to OIDC by configuring `oidc_settings`. Note that `oidc_settings` is now required whenever `enable_authentication = true`.

### Outputs (v5.0.0)

The following outputs have been **removed**:

- `arn` — the IAM user ARN.
- `iam_user_arn` — the IAM user ARN.

The following output has been **renamed**:

- `iam_role_oidc_arn` -> `iam_role_arn`

The previous `iam_role_arn` output (the static-credential `iam_role` ARN) no longer exists. `iam_role_arn` now returns the ARN of the OIDC role, so consumers that referenced `iam_role_oidc_arn` must switch to `iam_role_arn`.

## Upgrading to v4.0.0

### Variables (v4.0.0)

- The variable `project_name` has been replaced by `project_id`.
- A new variable `oidc_settings.project_name` has been added to control the OIDC project filter.

## Upgrading to v3.0.0

### Variables (v3.0.0)

- The variable `project_id` has been replaced by `project_name`.
- The deprecated variable `trigger_prefixes` has been removed.
- The deprecated variable `workspace_tags` has been removed. `workspace_map_tags` has been renamed to `workspace_tags`.

## Upgrading to v2.4.0

### Variables (v2.4.0)

- Default value removed `var.trigger_prefixes`: `["modules"]` -> `null`
- Default value added `var.trigger_patterns`: `null` -> `["modules/**/*"]`.

### Behaviour (v2.4.0)

Terraform Cloud now defaults to **trigger patterns** instead of **trigger prefixes**. Trigger prefixes will be deprecated in the future, so migration is recommended. Trigger patterns providing greater flexibility, efficiency, and control over how your workspaces respond to changes in your repositories.

#### What You Need to Do

If you are using the modules defaults for these variables, you do not need to do anything, the workspaces will automatically be modified to trigger patterns.

If you have modified the defaults you need to take action:

Option 1: Migrate to `trigger_patterns` (Recommended)

1. **Remove** values from `trigger_prefixes`.
2. **Set** equivalent values in `trigger_patterns`.

**Example:**

```hcl
# Before
var.trigger_prefixes = ["envs/prod/"]

# After
var.trigger_patterns = ["envs/prod/**/*"]

See (documentation on trigger runs when files in specified paths change)[https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings/vcs#only-trigger-runs-when-files-in-specified-paths-change].
```

Option 2: Opt Out

1. Set `var.trigger_patterns` to `null`.
2. Set `var.trigger_prefixes` to `["modules"]`, or keep the value you are using.

This is a temporary workaround; trigger_prefixes will be deprecated.

#### Avoid Conflict Errors

If both variables are set, Terraform will fail with:

`"trigger_patterns": conflicts with trigger_prefixes`.
Fix it by following Option 1 or Option 2.
