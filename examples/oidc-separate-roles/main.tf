provider "aws" {
  region = "eu-west-1"
}

# If you are using this module in combination with `terraform-aws-mcaf-avm` the OIDC provider is already created.
data "tls_certificate" "oidc_certificate" {
  url = "https://app.terraform.io"
}

resource "aws_iam_openid_connect_provider" "tfc_provider" {
  url             = data.tls_certificate.oidc_certificate.url
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = [data.tls_certificate.oidc_certificate.certificates[0].sha1_fingerprint]
}

# A least-privilege, read-only policy for the plan phase.
data "aws_iam_policy_document" "apply" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

# Setting `oidc_settings.roles` creates two IAM roles instead of one: a plan role (published as
# TFC_AWS_PLAN_ROLE_ARN) whose trust policy only allows the plan run phase, and an apply role
# (TFC_AWS_APPLY_ROLE_ARN) scoped to the apply phase. Each phase's policy/policy_arns/role_name
# falls back to the shared top-level value when omitted.
module "workspace-example" {
  source = "../.."

  name                   = "example"
  oauth_token_id         = "ot-xxxxxxxxxxxxxxxx"
  terraform_organization = "example-org"

  # role_name is the base for the separate role names: "example-plan" and "example-apply".
  role_name = "example"

  oidc_settings = {
    provider_arn = aws_iam_openid_connect_provider.tfc_provider.arn

    roles = {
      # Read-only plan role.
      plan = {
        policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
      }
      # Read-write apply role.
      apply = {
        policy = data.aws_iam_policy_document.apply.json
      }
    }
  }
}
