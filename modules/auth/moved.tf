# State migrations for the auth submodule, kept cumulative so upgrades chain
# correctly. Terraform follows chained moves (A -> B -> C), so a state from
# either v4 or v5 lands on the current v6 addresses.

# v4 -> v5: OIDC became the only auth method, so the count-indexed `[0]`
# instances became count-less.
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

# v5 -> v6: the single OIDC role became a `for_each` map keyed by run phase, and
# the run-role variable was merged into the `tfc_aws_role_arn` `for_each`. The
# `provider_auth` and `workload_identity_audience` variables are unchanged.
moved {
  from = module.workspace_iam_role
  to   = module.workspace_iam_role["run"]
}

moved {
  from = tfe_variable.tfc_aws_run_role_arn
  to   = tfe_variable.tfc_aws_role_arn["run"]
}
