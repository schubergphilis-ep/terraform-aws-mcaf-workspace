# Upgrading Notes

This document captures required refactoring when upgrading between versions of the `auth` submodule (`modules/auth`), for consumers that reference this submodule directly rather than through the root `terraform-aws-mcaf-workspace` module.

## Upgrading to v6.0.0

This release reworks the submodule interface to support per-run-phase IAM roles (plan/apply) and to group all OIDC trust settings into a single `oidc_settings` object.

### OIDC settings (v6.0.0)

`oidc_settings` has been **reshaped**. It no longer takes pre-computed subject filters; instead it takes the raw trust inputs and derives the project and workspace filters internally.
The separate `name` input has been removed — pass the workspace name as `oidc_settings.workspace_name`, which is required only when `project_scope` is `false` (it is unused for project-scoped trust).

```hcl
# Before (v5.x)
oidc_settings = {
  oidc_workspace_filter = "my-workspace"
  provider_arn          = aws_iam_openid_connect_provider.tfc_provider.arn
}
name = "my-workspace"

# After (v6.x)
oidc_settings = {
  provider_arn   = aws_iam_openid_connect_provider.tfc_provider.arn
  workspace_name = "my-workspace"
  # set project_scope = true + project_name = "..." to scope the trust to a whole project
}
```

### Role inputs (v6.0.0)

All role inputs (`role_name`, `path`, `permissions_boundary_arn`, `postfix`, `policy`, `policy_arns`) have been **removed** and folded into a single `role_settings` object. `role_name` is renamed to `name`.
Roles are defined per run phase via the optional `run`, `plan`, and `apply` sub-objects — each created only when set:

```hcl
# Before (v5.x): a single run role
role_name   = "TFEPipelineMyWorkspace"
policy      = data.aws_iam_policy_document.pipeline.json
policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]

# After (v6.x): the equivalent single run role
role_settings = {
  name = "TFEPipelineMyWorkspace"
  run = {
    policy      = data.aws_iam_policy_document.pipeline.json
    policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
  }
}

# Optional: separate plan/apply roles (must be set together)
role_settings = {
  name  = "TFEPipelineMyWorkspace"
  run   = { policy = data.aws_iam_policy_document.pipeline.json }
  plan  = { policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"] }
  apply = { policy = data.aws_iam_policy_document.write.json }
}
```

`role_settings.run`/`role_settings.plan`/`role_settings.apply` are independently optional; at least one must be set, and `plan`/`apply` must be set together.

To also publish each role ARN as a Terraform-category workspace variable (in addition to the environment variable), set `set_terraform_role_arn_variables = true` (defaults to `false`).

### Outputs (v6.0.0)

- `iam_role_arn` still returns the **run**-phase role ARN (or `null` when no run role is created).
- A new `iam_role_arns` output returns a map of run phase (`run`/`plan`/`apply`) to role ARN.
