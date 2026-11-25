provider "aws" {
  region = "eu-west-1"
}

# A team created in the same run can't be looked up by name during the plan, so pass its id.
resource "tfe_team" "deployers" {
  name         = "deployers"
  organization = "example-org"
}

module "workspace-example" {
  source = "../.."

  name                   = "example"
  authentication         = { enabled = false }
  oauth_token_id         = "ot-xxxxxxxxxxxxxxxx"
  terraform_organization = "example-org"

  team_access = {
    "deployers" = {
      access  = "write"
      team_id = tfe_team.deployers.id
    }

    # An existing team is looked up by name.
    "readers" = {
      access = "read"
    }
  }
}
