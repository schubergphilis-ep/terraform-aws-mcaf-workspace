# Upgrading Notes

This document captures required refactoring on your part when upgrading to a module version that contains breaking changes.

## Upgrading to v6.0.0

This release consolidates every authentication-related variable into a single `authentication` object and adds support for **phase-specific IAM roles** for the plan and apply run phases.

> [!IMPORTANT]
> Upgrade to v4.x.x or higher before v6. The moved blocks are cumulative and chained, so state on v4 or v5 migrates in place — nothing is destroyed or recreated. 
> Starting below v4 is not covered by the moves.

### Variables (v6.0.0)

The following variables have been **removed** and folded into the new `authentication` object, which nests two sub-objects — `oidc_settings` (trust) and `role_settings` (IAM roles):

- `enable_authentication` → `var.authentication.enabled`
- `oidc_settings` (`audience`, `project_name`, `project_scope`, `provider_arn`, `site_address`) → `authentication.oidc_settings.*`
- `path` → `authentication.role_settings.path`
- `permissions_boundary_arn` → `authentication.role_settings.permissions_boundary_arn`
- `policy` → `authentication.role_settings.run.policy` (and/or `plan`/`apply`)
- `policy_arns` → `authentication.role_settings.run.policy_arns` (and/or `plan`/`apply`)
- `postfix` → `authentication.role_settings.postfix`
- `role_name` → `authentication.role_settings.name`

`authentication` is required (it has no default), so you must configure or explicitly disable it.
To disable authentication entirely (previously `enable_authentication = false`), set `authentication = null` or `authentication = { enabled = false }`.
`oidc_settings` and `role_settings` are required whenever authentication is enabled.

> [!IMPORTANT]
> To keep your existing run role and `TFC_AWS_RUN_ROLE_ARN`, you **must** set `authentication.role_settings.run` explicitly (e.g. `run = {}`, or provide an `policy` or `policy_arns`).
> If `run` is omitted, the run role and its variable are destroyed.

**Before (v5.x):**

```hcl
module "workspace" {
  source = "schubergphilis-ep/mcaf-workspace/aws"

  name = "example"

  oidc_settings = {
    provider_arn = aws_iam_openid_connect_provider.tfc_provider.arn
  }
  policy = data.aws_iam_policy_document.pipeline.json
}
```

**After (v6.x):**

```hcl
module "workspace" {
  source = "schubergphilis-ep/mcaf-workspace/aws"

  name = "example"

  authentication = {
    oidc_settings = {
      provider_arn = aws_iam_openid_connect_provider.tfc_provider.arn
    }
    role_settings = {
      run = { policy = data.aws_iam_policy_document.pipeline.json }
    }
  }
}
```

### Phase-specific roles (v6.0.0)

You can now give the plan and apply run phases their own IAM roles via `authentication.role_settings.plan` and `authentication.role_settings.apply`.
Each, when set, creates a role whose trust policy is scoped to that single phase (`run_phase:plan` / `run_phase:apply`) and sets the matching `TFC_AWS_PLAN_ROLE_ARN` / `TFC_AWS_APPLY_ROLE_ARN` variable.
Their names default to the shared `role_settings.name` with `Plan`/`Apply` appended.

Terraform Cloud picks the role for each phase in this order:

1. The phase-specific ARN — `TFC_AWS_PLAN_ROLE_ARN` for plan, `TFC_AWS_APPLY_ROLE_ARN` for apply — if it is set.
2. Otherwise `TFC_AWS_RUN_ROLE_ARN` — the **fallback** assumed by any phase that has no dedicated role.

So `run` is the catch-all role and `plan`/`apply` are optional overrides.
Keep `run` set alongside `plan`/`apply` so every phase always resolves to a role; if you omit `run`, a phase without its own role has no credentials to assume.

Recommended migration from a pre-v6 `run`-only setup — do it in three steps so the switch stays low-risk and easy to roll back:

1. **Start (pre-v6):** `run` only — a single role assumed for every phase.
2. **Introduce per-phase roles:** set `run` + `plan` + `apply`. Plan and apply now assume their own least-privilege roles, while `run` stays provisioned.
   Because a phase only falls back to the run role when its own ARN is *absent*, `run` acts as a ready safety net:
   if a new plan or apply role turns out to be misconfigured, remove just that block and Terraform Cloud immediately reverts that phase to the still-present run role — nothing needs to be recreated.
3. **Finalize:** once the plan and apply roles are confirmed working, unset `run`. Only `plan` and `apply` remain and `TFC_AWS_RUN_ROLE_ARN` is removed, so each phase assumes exactly its own role.
   (Keep `run` set instead if you want to retain a permanent fallback.)

Constraints: `plan` and `apply` must be set together (both or neither), and at least one of `run`/`plan`/`apply` must be set when authentication is enabled.

Set `authentication.role_settings.set_terraform_role_arn_variables = true` to also expose each role ARN as a Terraform-category workspace variable, in addition to the environment variables.
Defaults to `false`. This is handy when the configuration itself needs to make plan-vs-apply decisions:
with the ARNs available as Terraform variables the code can compare the current identity (e.g. `data.aws_caller_identity.current.arn`) against the known plan/apply role ARN and branch on which phase is running.

### Outputs (v6.0.0)

- `iam_role_arn` is unchanged in meaning: it returns the **run** role ARN (or `null` when no run role is created).
- A new `iam_role_arns` output returns a map of run phase (`run`/`plan`/`apply`) to role ARN.

## Upgrading to v5.0.0

This release drops support for every authentication method except OIDC. The module now always provisions an IAM role that Terraform Cloud assumes via OIDC workload identity.

> [!IMPORTANT]
> Upgrade to any **v4.x.x** release before upgrading to **v5.x.x**. The `moved` blocks in v5 assume your state already matches the v4 layout. Skipping v4 causes the `moved` statements to overlap, which forces Terraform to destroy and recreate the authentication resources instead of migrating them in place.

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
