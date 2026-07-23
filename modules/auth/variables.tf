variable "oidc_settings" {
  type = object({
    audience              = optional(string, "aws.workload.identity")
    oidc_project_filter   = optional(string, "*")
    oidc_workspace_filter = string
    provider_arn          = string
    site_address          = optional(string, "app.terraform.io")
  })
  description = "OIDC settings to use for authentication between TFE workspace and AWS IAM role"
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path in which to create the IAM role"
}

variable "permissions_boundary_arn" {
  type        = string
  default     = null
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
}

variable "policy" {
  type        = string
  default     = null
  description = "The policy to attach to the pipeline role"
}

variable "policy_arns" {
  type        = set(string)
  default     = []
  description = "A set of policy ARNs to attach to the pipeline role"
}

variable "postfix" {
  type        = bool
  default     = true
  description = "Whether to postfix the IAM resources with `Role`"
}

variable "role_name" {
  type        = string
  description = "The IAM role name for a new pipeline role"
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

variable "workspace_id" {
  type        = string
  default     = null
  description = "The TFE workspace ID to attach variables to"

  validation {
    condition     = (var.workspace_id != null) != (var.variable_set_id != null)
    error_message = "Exactly one of workspace_id or variable_set_id must be specified."
  }
}

variable "variable_set_id" {
  type        = string
  default     = null
  description = "The TFE variable set ID to attach variables to"
}
