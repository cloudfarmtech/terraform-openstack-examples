# AGENTS.md

## Purpose

This repository stores small, self-contained Terraform examples for working with OpenStack.

## Core Conventions

- Use the `openstack` provider version `3.4.0` in examples unless a task explicitly requires a different version.
- Default authentication method is OpenStack Application Credentials.
- Use English only in repository documentation, comments, example text, and future additions.
- Do not commit real secrets, `terraform.tfstate`, `.terraform/`, or filled `*.tfvars` files.
- Treat content in `examples/` as step-by-step lessons.
- Some lessons may depend on resources, outputs, or setup created in earlier lessons, so document dependencies explicitly.
- Prefer simple, readable examples over reusable abstractions unless the example is specifically about modules.

## Example Layout

- Put runnable examples in `examples/<nn>-<name>/`.
- Keep lessons ordered so users can progress through them step by step.
- Each example should usually contain `README.md`, `versions.tf`, `providers.tf`, `variables.tf`, and the minimum resources needed for the scenario.
- If an example needs input values, add `terraform.tfvars.example` with placeholders only.

## Provider Defaults

Use this pattern by default:

```hcl
terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "3.4.0"
    }
  }
}

provider "openstack" {
  auth_url                      = var.auth_url
  region                        = var.region
  application_credential_id     = var.application_credential_id
  application_credential_secret = var.application_credential_secret
}
```

## Documentation Expectations

- Each example README should explain what it creates, required inputs, and how to run `terraform init`, `plan`, and `apply`.
- If a lesson depends on a previous lesson, state that clearly at the top of the README and describe what must already exist.
- Mention provider-specific assumptions when relevant, such as required network, image, flavor, key pair, or floating IP setup.
