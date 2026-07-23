variable "oidc_settings" {
  type = object({
    provider_arn   = string
    audience       = optional(string, "aws.workload.identity")
    site_address   = optional(string, "app.terraform.io")
    project_scope  = optional(bool, false)
    project_name   = optional(string)
    workspace_name = optional(string)
  })
  description = "OIDC trust settings for the assume-role policy. `project_scope`/`project_name`/`workspace_name` together produce the subject filter: with `project_scope` enabled the trust applies to every workspace in `project_name` (and `workspace_name` is not needed); otherwise it is scoped to `workspace_name`."

  validation {
    condition     = !var.oidc_settings.project_scope || var.oidc_settings.project_name != null
    error_message = "\"project_name\" must be set in \"oidc_settings\" when \"project_scope\" is enabled."
  }

  validation {
    condition     = var.oidc_settings.project_scope || var.oidc_settings.workspace_name != null
    error_message = "\"workspace_name\" must be set in \"oidc_settings\" when \"project_scope\" is disabled."
  }
}

variable "role_settings" {
  type = object({
    name                     = string
    path                     = optional(string, "/")
    permissions_boundary_arn = optional(string)
    postfix                  = optional(bool, true)

    run = optional(object({
      policy      = optional(string)
      policy_arns = optional(set(string), [])
    }))
    plan = optional(object({
      policy      = optional(string)
      policy_arns = optional(set(string), [])
    }))
    apply = optional(object({
      policy      = optional(string)
      policy_arns = optional(set(string), [])
    }))
  })
  description = "IAM role definitions. `run`/`plan`/`apply` each create a role (and its matching `TFC_AWS_{RUN,PLAN,APPLY}_ROLE_ARN` variable) only when set; plan/apply are scoped to their run phase and fall back to the run role. `name` is the shared base role name (required); the plan and apply roles append \"Plan\"/\"Apply\" to it."

  validation {
    condition     = (var.role_settings.plan != null) == (var.role_settings.apply != null)
    error_message = "\"plan\" and \"apply\" must both be set or both be omitted in \"role_settings\"."
  }

  validation {
    condition     = var.role_settings.run != null || var.role_settings.plan != null || var.role_settings.apply != null
    error_message = "At least one of \"run\", \"plan\", or \"apply\" must be set in \"role_settings\"."
  }
}

variable "set_terraform_role_arn_variables" {
  type        = bool
  default     = false
  description = "When true, each created role ARN is also set as a Terraform-category workspace variable, in addition to the environment variable that dynamic credentials require."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "A mapping of tags to assign to resource"
}

variable "terraform_organization" {
  type        = string
  default     = null
  description = "The Terraform Enterprise organization to create the workspace in. If omitted, organization must be defined in the provider config."
}

variable "variable_set_id" {
  type        = string
  default     = null
  description = "The TFE variable set ID to attach variables to"
}

variable "workspace_id" {
  type        = string
  default     = null
  description = "The TFE workspace ID to attach variables to"

  validation {
    condition     = (var.workspace_id != null) != (var.variable_set_id != null)
    error_message = "Exactly one of workspace_id or variable_set_id must be specified."
  }
}
