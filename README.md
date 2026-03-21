# Terraform OpenStack Examples

A collection of small Terraform examples for working with OpenStack.

## What Is Included

- basic `openstack` provider setup
- network examples
- compute resource examples
- reusable helper templates

## Conventions

- provider: `terraform-provider-openstack/openstack` `3.4.0`
- authentication method: `Application Credentials`
- each example lives in its own directory under `examples/`

## Structure

- `examples/00-provider-auth` - starter provider and variables template
- `examples/10-network` - private network, subnet, router (lesson after `00-provider-auth`)
- `examples/20-compute` - placeholder for compute examples
- `modules/` - shared modules if they become necessary

## Quick Start

1. Go to the example you want to use.
2. Copy `terraform.tfvars.example` to a local `terraform.tfvars`.
3. Fill in the values for your OpenStack environment.
4. Run `terraform init`.
5. Run `terraform plan`.
