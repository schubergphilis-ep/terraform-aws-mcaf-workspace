<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.67.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | >= 0.67.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_workspace_iam_role"></a> [workspace\_iam\_role](#module\_workspace\_iam\_role) | schubergphilis-ep/mcaf-role/aws | ~> 0.5.3 |

## Resources

| Name | Type |
|------|------|
| [tfe_variable.tfc_aws_provider_auth](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_role_arn](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_role_arn_terraform](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_workload_identity_audience](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_organization.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oidc_settings"></a> [oidc\_settings](#input\_oidc\_settings) | OIDC trust settings for the assume-role policy. `project_scope`/`project_name`/`workspace_name` together produce the subject filter: with `project_scope` enabled the trust applies to every workspace in `project_name` (and `workspace_name` is not needed); otherwise it is scoped to `workspace_name`. | <pre>object({<br/>    provider_arn   = string<br/>    audience       = optional(string, "aws.workload.identity")<br/>    site_address   = optional(string, "app.terraform.io")<br/>    project_scope  = optional(bool, false)<br/>    project_name   = optional(string)<br/>    workspace_name = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_role_settings"></a> [role\_settings](#input\_role\_settings) | IAM role definitions. `run`/`plan`/`apply` each create a role (and its matching `TFC_AWS_{RUN,PLAN,APPLY}_ROLE_ARN` variable) only when set; plan/apply are scoped to their run phase and fall back to the run role. `name` is the shared base role name (required); the plan and apply roles append "Plan"/"Apply" to it. | <pre>object({<br/>    name                     = string<br/>    path                     = optional(string, "/")<br/>    permissions_boundary_arn = optional(string)<br/>    postfix                  = optional(bool, true)<br/><br/>    run = optional(object({<br/>      policy      = optional(string)<br/>      policy_arns = optional(set(string), [])<br/>    }))<br/>    plan = optional(object({<br/>      policy      = optional(string)<br/>      policy_arns = optional(set(string), [])<br/>    }))<br/>    apply = optional(object({<br/>      policy      = optional(string)<br/>      policy_arns = optional(set(string), [])<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_set_terraform_role_arn_variables"></a> [set\_terraform\_role\_arn\_variables](#input\_set\_terraform\_role\_arn\_variables) | When true, each created role ARN is also set as a Terraform-category workspace variable, in addition to the environment variable that dynamic credentials require. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to resource | `map(string)` | `null` | no |
| <a name="input_terraform_organization"></a> [terraform\_organization](#input\_terraform\_organization) | The Terraform Enterprise organization to create the workspace in. If omitted, organization must be defined in the provider config. | `string` | `null` | no |
| <a name="input_variable_set_id"></a> [variable\_set\_id](#input\_variable\_set\_id) | The TFE variable set ID to attach variables to | `string` | `null` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | The TFE workspace ID to attach variables to | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of the run-phase IAM role, or null when no run role is created |
| <a name="output_iam_role_arns"></a> [iam\_role\_arns](#output\_iam\_role\_arns) | Map of run phase (run/plan/apply) to the ARN of the created IAM role |
<!-- END_TF_DOCS -->
