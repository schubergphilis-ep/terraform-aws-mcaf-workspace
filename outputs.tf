output "iam_role_arn" {
  description = "ARN of the run-phase IAM role, or null when no run role is created"
  value       = try(module.auth[0].iam_role_arns["run"], null)
}

output "iam_role_arns" {
  description = "Map of run phase (run/plan/apply) to the ARN of the created IAM role"
  value       = try(module.auth[0].iam_role_arns, {})
}

output "workspace_name" {
  value       = module.tfe-workspace.name
  description = "The Terraform Cloud workspace name"
}

output "workspace_id" {
  value       = module.tfe-workspace.id
  description = "The Terraform Cloud workspace ID"
}
