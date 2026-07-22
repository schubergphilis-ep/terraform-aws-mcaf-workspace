output "iam_user_arn" {
  description = "ARN of the IAM user (if auth_method is iam_user)"
  value       = var.auth_method == "iam_user" ? module.workspace_iam_user[0].arn : null
}

output "iam_role_arn" {
  description = "ARN of the IAM role (if auth_method is iam_role)"
  value       = var.auth_method == "iam_role" ? module.workspace_iam_role[0].arn : null
}

output "iam_role_oidc_arn" {
  description = "ARN of the single IAM role for OIDC (if auth_method is iam_role_oidc and oidc_settings.roles is not set)"
  value       = local.enable_oidc_single ? module.workspace_iam_role_oidc[0].arn : null
}

output "iam_role_oidc_plan_arn" {
  description = "ARN of the plan IAM role for OIDC (if auth_method is iam_role_oidc and oidc_settings.roles is set)"
  value       = local.enable_oidc_split ? module.workspace_iam_role_oidc_plan[0].arn : null
}

output "iam_role_oidc_apply_arn" {
  description = "ARN of the apply IAM role for OIDC (if auth_method is iam_role_oidc and oidc_settings.roles is set)"
  value       = local.enable_oidc_split ? module.workspace_iam_role_oidc_apply[0].arn : null
}
