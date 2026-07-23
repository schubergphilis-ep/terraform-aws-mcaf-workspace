mock_provider "aws" {}
mock_provider "tfe" {}
mock_provider "random" {}

variables {
  workspace_id           = "ws-XXXXXXXXXXXXXXXX"
  terraform_organization = "example-org"

  oidc_settings = {
    provider_arn   = "arn:aws:iam::123456789012:oidc-provider/app.terraform.io"
    workspace_name = "example"
  }
}

# Only a run role: one IAM role, the shared TFC variables, and a single
# environment-category role ARN variable. No Terraform-category variables.
run "run_role_only" {
  command = apply

  variables {
    role_settings = {
      name = "TFEPipelineExample"
      run  = {}
    }
  }

  assert {
    condition     = length(output.iam_role_arns) == 1 && contains(keys(output.iam_role_arns), "run")
    error_message = "Expected only the run role to be created."
  }

  assert {
    condition     = length(tfe_variable.tfc_aws_role_arn) == 1
    error_message = "Expected exactly one environment-category role ARN variable."
  }

  assert {
    condition     = length(tfe_variable.tfc_aws_role_arn_terraform) == 0
    error_message = "Expected no Terraform-category role ARN variables by default."
  }

  assert {
    condition     = tfe_variable.tfc_aws_provider_auth.value == "true"
    error_message = "Expected TFC_AWS_PROVIDER_AUTH to be set to \"true\"."
  }
}

# Run, plan and apply roles: three IAM roles and three env-category variables.
run "phase_specific_roles" {
  command = apply

  variables {
    role_settings = {
      name  = "TFEPipelineExample"
      run   = {}
      plan  = { policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"] }
      apply = {}
    }
  }

  assert {
    condition     = length(output.iam_role_arns) == 3
    error_message = "Expected run, plan and apply roles to be created."
  }

  assert {
    condition     = length(tfe_variable.tfc_aws_role_arn) == 3
    error_message = "Expected three environment-category role ARN variables."
  }
}

# set_terraform_role_arn_variables adds Terraform-category copies of each ARN.
run "terraform_role_arn_variables" {
  command = apply

  variables {
    set_terraform_role_arn_variables = true

    role_settings = {
      name  = "TFEPipelineExample"
      run   = {}
      plan  = {}
      apply = {}
    }
  }

  assert {
    condition     = length(tfe_variable.tfc_aws_role_arn_terraform) == 3
    error_message = "Expected three Terraform-category role ARN variables."
  }

  assert {
    condition     = tfe_variable.tfc_aws_role_arn_terraform["run"].category == "terraform"
    error_message = "Expected the additional role ARN variables to use the terraform category."
  }
}

# Project-scoped trust: workspace_name is not required.
run "project_scoped" {
  command = apply

  variables {
    oidc_settings = {
      provider_arn  = "arn:aws:iam::123456789012:oidc-provider/app.terraform.io"
      project_scope = true
      project_name  = "my-project"
    }
    role_settings = {
      name = "TFEPipelineExample"
      run  = {}
    }
  }

  assert {
    condition     = length(output.iam_role_arns) == 1
    error_message = "Expected the run role to be created for a project-scoped trust."
  }
}

# project_scope enabled without project_name must fail validation.
run "project_scope_requires_project_name" {
  command = plan

  variables {
    oidc_settings = {
      provider_arn  = "arn:aws:iam::123456789012:oidc-provider/app.terraform.io"
      project_scope = true
    }
    role_settings = {
      name = "TFEPipelineExample"
      run  = {}
    }
  }

  expect_failures = [var.oidc_settings]
}

# project_scope disabled without workspace_name must fail validation.
run "workspace_scope_requires_workspace_name" {
  command = plan

  variables {
    oidc_settings = {
      provider_arn = "arn:aws:iam::123456789012:oidc-provider/app.terraform.io"
    }
    role_settings = {
      name = "TFEPipelineExample"
      run  = {}
    }
  }

  expect_failures = [var.oidc_settings]
}

# plan without apply (or vice versa) must fail validation.
run "plan_and_apply_must_be_paired" {
  command = plan

  variables {
    role_settings = {
      name = "TFEPipelineExample"
      plan = {}
    }
  }

  expect_failures = [var.role_settings]
}

# No run/plan/apply set must fail validation.
run "at_least_one_role_required" {
  command = plan

  variables {
    role_settings = {
      name = "TFEPipelineExample"
    }
  }

  expect_failures = [var.role_settings]
}
