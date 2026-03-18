# Root terragrunt.hcl — shared config inherited by all live components.

# Generate a local backend so state lands next to each component.
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "local" {
    path = "${get_terragrunt_dir()}/terraform.tfstate"
  }
}
EOF
}

# Generate the provider configuration.
# The module declares required_providers; this block configures them.
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "local" {}
EOF
}
