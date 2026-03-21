# 00-provider-auth

A minimal Terraform configuration example for OpenStack authentication with `Application Credentials`.

## Files

- `versions.tf` - pins the `openstack` provider to `3.4.0`
- `providers.tf` - provider configuration
- `variables.tf` - input variables
- `terraform.tfvars.example` - local values template

## How To Use

1. Create a local `terraform.tfvars` file based on `terraform.tfvars.example`.
2. Fill in `auth_url`, `region`, `application_credential_id`, and `application_credential_secret`.
3. Run `terraform init`.
4. Run `terraform plan`.

This example does not create resources and serves as the base for future examples.

## Next lesson

After `terraform plan` works, continue to `examples/10-network` and reuse the same `terraform.tfvars` values for authentication, adding `external_network_name` and any optional network variables described there.
