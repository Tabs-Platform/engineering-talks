# Terra Talk

A Terraform project that generates a [reveal.js](https://revealjs.com/) presentation about Terraform. The slides are provisioned, not written.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- A web browser

## Usage

```bash
terraform init
terraform apply -auto-approve
open index.html
```

To customize the title slide:

```bash
terraform apply -var='presenter_name=Your Name' -var='talk_title=My Custom Title'
```

Press `S` during the presentation to open speaker notes.

## Cleanup

```bash
terraform destroy -auto-approve
```
