# OIDC authentication is now the only supported method, so the resources below
# no longer use `count`. These moved blocks migrate the existing single (index
# `[0]`) instances to their new count-less addresses.

moved {
  from = module.workspace_iam_role_oidc[0]
  to   = module.workspace_iam_role
}

moved {
  from = tfe_variable.tfc_aws_provider_auth[0]
  to   = tfe_variable.tfc_aws_provider_auth
}

moved {
  from = tfe_variable.tfc_aws_run_role_arn[0]
  to   = tfe_variable.tfc_aws_run_role_arn
}

moved {
  from = tfe_variable.tfc_aws_workload_identity_audience[0]
  to   = tfe_variable.tfc_aws_workload_identity_audience
}
