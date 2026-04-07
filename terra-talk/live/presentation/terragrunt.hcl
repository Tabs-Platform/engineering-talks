# Include the root configuration (provider + backend generation).
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Source the presentation module.
terraform {
  source = "../../modules/presentation"
}

# Pass inputs to the module's variables.
inputs = {
  presenter_name = "Andrew Dong"
  talk_title     = "Terraform: Infrastructure as Code, Slides as Code"
  output_dir     = get_terragrunt_dir()
}
