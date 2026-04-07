# Terra Talk

A Terraform + Terragrunt project that generates a [reveal.js](https://revealjs.com/) presentation about Terraform. The slides are provisioned, not written.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) >= 0.50
- A web browser

## Project Structure

```
├── root.hcl                    # Root config: generates provider + backend
├── modules/
│   └── presentation/           # Reusable Terraform module
│       ├── versions.tf
│       ├── variables.tf
│       ├── locals.tf
│       ├── main.tf
│       └── outputs.tf
└── live/
    └── presentation/           # Terragrunt wrapper: inputs + config
        └── terragrunt.hcl
```

## Usage

```bash
cd live/presentation
terragrunt init
terragrunt apply -auto-approve
open index.html
```

To customize the title slide, edit the `inputs` block in `live/presentation/terragrunt.hcl`, or override at the command line:

```bash
terragrunt apply -var='presenter_name=Your Name'
```

Press `S` during the presentation to open speaker notes.

## Cleanup

```bash
cd live/presentation
terragrunt destroy -auto-approve
```
