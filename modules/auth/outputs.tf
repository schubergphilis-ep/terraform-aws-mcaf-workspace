output "iam_role_arn" {
  description = "ARN of the run-phase IAM role, or null when no run role is created"
  value       = var.role_settings.run != null ? module.workspace_iam_role["run"].arn : null
}

output "iam_role_arns" {
  description = "Map of run phase (run/plan/apply) to the ARN of the created IAM role"
  value       = { for phase, role in module.workspace_iam_role : phase => role.arn }
}
