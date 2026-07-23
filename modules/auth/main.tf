data "tfe_organization" "default" {}

locals {
  org_name              = var.terraform_organization != null ? var.terraform_organization : data.tfe_organization.default.name
  oidc_project_filter   = var.oidc_settings.project_scope ? var.oidc_settings.project_name : "*"
  oidc_workspace_filter = !var.oidc_settings.project_scope ? var.oidc_settings.workspace_name : "*"

  # One entry per run phase whose role definition is set. `run_phase` is the
  # OIDC subject filter ("*" trusts every phase); `name_suffix` is appended to
  # the shared role name for the phase-specific roles.
  roles = {
    for phase, definition in {
      run   = var.role_settings.run
      plan  = var.role_settings.plan
      apply = var.role_settings.apply
      } : phase => {
      definition  = definition
      run_phase   = phase == "run" ? "*" : phase
      name_suffix = phase == "run" ? "" : title(phase)
    } if definition != null
  }

  # Created role ARNs keyed by run phase, e.g. { run = "arn:..." }. Feeds the
  # TFC_AWS_{RUN,PLAN,APPLY}_ROLE_ARN / tfc_aws_{run,plan,apply}_role_arn workspace variables.
  role_arns = { for phase, role in module.workspace_iam_role : phase => role.arn }
}

################################################################################
# IAM roles (one per run phase; each created only when its definition is set)
################################################################################

module "workspace_iam_role" {
  source  = "schubergphilis-ep/mcaf-role/aws"
  version = "~> 0.5.3"

  for_each = local.roles

  name                 = "${var.role_settings.name}${each.value.name_suffix}"
  path                 = var.role_settings.path
  permissions_boundary = var.role_settings.permissions_boundary_arn
  policy_arns          = each.value.definition.policy_arns
  postfix              = var.role_settings.postfix
  role_policy          = each.value.definition.policy
  tags                 = var.tags

  assume_policy = templatefile("${path.module}/templates/assume_role_policy_oidc.tftpl", {
    audience         = var.oidc_settings.audience,
    org_name         = local.org_name,
    project_filter   = local.oidc_project_filter,
    provider_arn     = var.oidc_settings.provider_arn,
    run_phase        = each.value.run_phase,
    site_address     = var.oidc_settings.site_address,
    workspace_filter = local.oidc_workspace_filter,
  })
}

################################################################################
# TFE workspace variables
################################################################################

resource "tfe_variable" "tfc_aws_provider_auth" {
  key             = "TFC_AWS_PROVIDER_AUTH"
  value           = "true"
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

resource "tfe_variable" "tfc_aws_role_arn" {
  for_each = local.role_arns

  key             = "TFC_AWS_${upper(each.key)}_ROLE_ARN"
  value           = each.value
  category        = "env"
  variable_set_id = var.variable_set_id
  workspace_id    = var.workspace_id
}

resource "tfe_variable" "tfc_aws_role_arn_terraform" {
  for_each = var.set_terraform_role_arn_variables ? local.role_arns : {}

  key             = "tfc_aws_${lower(each.key)}_role_arn"
  value           = each.value
  category        = "terraform"
  variable_set_id = var.variable_set_id
  workspace_id    = var.workspace_id
}
