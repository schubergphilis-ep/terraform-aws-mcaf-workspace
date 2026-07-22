output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = try(module.auth[0].iam_role_arn, null)
}

output "workspace_name" {
  value       = module.tfe-workspace.name
  description = "The Terraform Cloud workspace name"
}

output "workspace_id" {
  value       = module.tfe-workspace.id
  description = "The Terraform Cloud workspace ID"
}
