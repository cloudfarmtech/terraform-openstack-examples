# 10-network

Neutron lesson: build a small **private network** with a **subnet**, a **router** with a default gateway on the provider **external** network, and a **router interface** so instances on the subnet can reach outside via SNAT.

## What gets created

| Piece | Terraform | Role |
|--------|-----------|------|
| External network | `data.openstack_networking_network_v2.external` | Lookup by `external_network_name` (public/provider network) |
| Private network | `openstack_networking_network_v2.private` | L2 network |
| Subnet | `openstack_networking_subnet_v2.private` | IPv4 CIDR on that network |
| Router | `openstack_networking_router_v2.private` | Default gateway to the external network |
| Router interface | `openstack_networking_router_interface_v2.private` | Connects subnet to the router |

## Prerequisites

Finish `examples/00-provider-auth` so Application Credentials work. Reuse the same values:

- `auth_url`
- `region`
- `application_credential_id`
- `application_credential_secret`

Copy or merge your `terraform.tfvars` from `00-provider-auth`, then add the lesson-specific variables below.

## Inputs

**Required for this lesson**

- `external_network_name` — Neutron name of the provider external/public network (often `public`, `external`, etc.). Resolve with Horizon or `openstack network list --external`.

**Optional**

- `name_prefix` — prefix for resource names (default `tf-lesson-network`)
- `private_cidr` — private IPv4 CIDR (default `192.168.42.0/24`)
- `dns_nameservers` — DNS servers for the subnet if your cloud needs them

## Layout

- `main.tf` — networking resources (see comments in file)
- `providers.tf`, `versions.tf` — OpenStack provider `3.4.0`
- `variables.tf` — inputs
- `outputs.tf` — IDs for later lessons
- `terraform.tfvars.example` — template for `terraform.tfvars`

## Steps

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and set auth plus `external_network_name`.
2. `terraform init`
3. `terraform plan`
4. `terraform apply`

## Outputs

- `network_id` — private network
- `subnet_id` — private subnet
- `router_id` — router with external gateway
- `external_network_id` — resolved external network (same as data source)

Use these in follow-up lessons (for example `examples/20-compute`). Keep state or record the values if a later lesson depends on them.

## Troubleshooting

If `terraform plan` fails with **no suitable endpoint in the service catalog** for networking, the Neutron client cannot be built from Keystone (region, env vars, or cloud-specific provider settings). Clear stray `OS_*` variables, confirm `region`, then see the [OpenStack provider docs](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs).
