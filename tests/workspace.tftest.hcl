mock_provider "aws" {}
mock_provider "random" {}

mock_provider "tfe" {
  # The tfe provider validates workspace IDs against the ws-<id> format, so pin
  # the mocked workspace ID instead of letting the mock generate a random one.
  mock_resource "tfe_workspace" {
    defaults = {
      id = "ws-XXXXXXXXXXXXXXXX"
    }
  }
}

variables {
  name                   = "example"
  terraform_organization = "example-org"
}

# Authentication enabled with only a run role: a single IAM role is created and
# exposed as the run-phase role ARN.
run "auth_run_role_only" {
  command = apply

  variables {
    authentication = {
      oidc_settings = {
        provider_arn = "arn:aws:iam::123456789012:oidc-provider/app.terraform.io"
      }
      role_settings = {
        run = {}
      }
    }
  }

  assert {
    condition     = output.iam_role_arn != null
    error_message = "Expected the run-phase role ARN output to be set."
  }

  assert {
    condition     = length(output.iam_role_arns) == 1 && contains(keys(output.iam_role_arns), "run")
    error_message = "Expected only the run role to be created."
  }
}

# Phase-specific plan/apply roles alongside the run role: three roles created.
run "auth_phase_specific_roles" {
  command = apply

  variables {
    authentication = {
      oidc_settings = {
        provider_arn = "arn:aws:iam::123456789012:oidc-provider/app.terraform.io"
      }
      role_settings = {
        run   = {}
        plan  = { policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"] }
        apply = {}
      }
    }
  }

  assert {
    condition     = length(output.iam_role_arns) == 3
    error_message = "Expected run, plan and apply roles to be created."
  }

  assert {
    condition     = alltrue([for phase in ["run", "plan", "apply"] : contains(keys(output.iam_role_arns), phase)])
    error_message = "Expected the role ARN map to contain run, plan and apply keys."
  }
}

# Authentication disabled via enabled = false: no auth module, no role ARNs.
run "auth_disabled_via_enabled" {
  command = apply

  variables {
    authentication = {
      enabled = false
    }
  }

  assert {
    condition     = output.iam_role_arn == null
    error_message = "Expected no run role ARN when authentication is disabled."
  }

  assert {
    condition     = length(output.iam_role_arns) == 0
    error_message = "Expected no role ARNs when authentication is disabled."
  }
}

# Authentication disabled via null.
run "auth_disabled_via_null" {
  command = apply

  variables {
    authentication = null
  }

  assert {
    condition     = length(output.iam_role_arns) == 0
    error_message = "Expected no role ARNs when authentication is null."
  }
}

# Enabling authentication without oidc_settings/role_settings must fail validation.
run "auth_enabled_requires_settings" {
  command = plan

  variables {
    authentication = {
      enabled = true
    }
  }

  expect_failures = [var.authentication]
}
