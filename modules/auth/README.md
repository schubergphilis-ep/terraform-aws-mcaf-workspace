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
| [tfe_variable.tfc_aws_run_role_arn](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_workload_identity_audience](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_organization.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oidc_settings"></a> [oidc\_settings](#input\_oidc\_settings) | OIDC settings to use for authentication between TFE workspace and AWS IAM role | <pre>object({<br/>    audience              = optional(string, "aws.workload.identity")<br/>    oidc_project_filter   = optional(string, "*")<br/>    oidc_workspace_filter = string<br/>    provider_arn          = string<br/>    site_address          = optional(string, "app.terraform.io")<br/>  })</pre> | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The IAM role name for a new pipeline role | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the IAM role | `string` | `"/"` | no |
| <a name="input_permissions_boundary_arn"></a> [permissions\_boundary\_arn](#input\_permissions\_boundary\_arn) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | The policy to attach to the pipeline role | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | A set of policy ARNs to attach to the pipeline role | `set(string)` | `[]` | no |
| <a name="input_postfix"></a> [postfix](#input\_postfix) | Whether to postfix the IAM resources with `Role` | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to resource | `map(string)` | `null` | no |
| <a name="input_terraform_organization"></a> [terraform\_organization](#input\_terraform\_organization) | The Terraform Enterprise organization to create the workspace in. If omitted, organization must be defined in the provider config. | `string` | `null` | no |
| <a name="input_variable_set_id"></a> [variable\_set\_id](#input\_variable\_set\_id) | The TFE variable set ID to attach variables to | `string` | `null` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | The TFE workspace ID to attach variables to | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of the IAM role |
<!-- END_TF_DOCS -->