output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = module.workspace_iam_role_oidc.arn
}
