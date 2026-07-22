data "tfe_organization" "default" {}

module "workspace_iam_role_oidc" {
  source  = "schubergphilis-ep/mcaf-role/aws"
  version = "~> 0.5.3"

  name                 = var.role_name
  path                 = var.path
  permissions_boundary = var.permissions_boundary_arn
  policy_arns          = var.policy_arns
  postfix              = var.postfix
  role_policy          = var.policy
  tags                 = var.tags

  assume_policy = templatefile("${path.module}/templates/assume_role_policy_oidc.tftpl", {
    audience         = var.oidc_settings.audience,
    org_name         = var.terraform_organization != null ? var.terraform_organization : data.tfe_organization.default.name,
    project_filter   = var.oidc_settings.oidc_project_filter,
    provider_arn     = var.oidc_settings.provider_arn,
    site_address     = var.oidc_settings.site_address,
    workspace_filter = var.oidc_settings.oidc_workspace_filter,
  })
}

resource "tfe_variable" "tfc_aws_provider_auth" {
  key             = "TFC_AWS_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  variable_set_id = var.variable_set_id
  workspace_id    = var.workspace_id
}

resource "tfe_variable" "tfc_aws_run_role_arn" {
  key             = "TFC_AWS_RUN_ROLE_ARN"
  value           = module.workspace_iam_role_oidc.arn
  category        = "env"
  variable_set_id = var.variable_set_id
  workspace_id    = var.workspace_id
}

resource "tfe_variable" "tfc_aws_workload_identity_audience" {
  key             = "TFC_AWS_WORKLOAD_IDENTITY_AUDIENCE"
  value           = var.oidc_settings.audience
  category        = "env"
  variable_set_id = var.variable_set_id
  workspace_id    = var.workspace_id
}
