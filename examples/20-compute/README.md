# 20-compute

End-to-end compute lesson:

- Upload a CirrOS **image**
- Create a **bootable Cinder volume** from it
- Create an SSH **key pair**
- Build a **private network** with a **router** to the provider **external** network (same pattern as Part A of `examples/10-network`)
- Add a **security group**
- Launch a **volume-backed VM** on the private subnet (required when flavors have **zero root disk** or policy allows only volume-backed servers)
- Allocate a **floating IP** (`openstack_networking_floatingip_v2` in `network.tf`) and **associate** it to the VM port with [`openstack_networking_floatingip_associate_v2`](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_floatingip_associate_v2) in `instance.tf`

You do **not** need to apply `10-network` first; that lesson is a reference for how the network and router are defined.

## Prerequisites

- Same **Application Credential** variables as `examples/00-provider-auth`.
- Know your cloud’s **external/public network name** (`external_network_name`) and a valid **flavor** (`flavor_name`).

## Part 1 — Download the CirrOS image (local disk)

```bash
mkdir -p images
curl -fLo images/cirros-0.6.3-x86_64-disk.img \
  https://download.cirros-cloud.net/0.6.3/cirros-0.6.3-x86_64-disk.img
```

Default path: `images/cirros-0.6.3-x86_64-disk.img`. Override with `local_image_path` if needed.

## Part 2 — SSH public key

Use `public_key_path` (default `~/.ssh/id_rsa.pub`) or set `public_key` in `terraform.tfvars`.

## Part 3 — Network (aligned with `10-network` Part A)

`network.tf` matches `examples/10-network` Part A: find the external network, create a private network and subnet, attach a router to the external network, connect the subnet to the router, allocate a floating IP from the pool (not attached to a VM yet).

## Part 4 — Boot volume, VM, floating IP

- `volume.tf` — boot volume from the Glance image.
- `instance.tf` — VM from that volume; port via `data.openstack_networking_port_v2`; FIP attached with `openstack_networking_floatingip_associate_v2` ([doc](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_floatingip_associate_v2)).
- `security_group.tf` — SSH and ICMP.

Volume size and optional Cinder type are listed under **Inputs** below.

## Inputs

| Name | Required | Notes |
|------|----------|--------|
| `auth_url`, `region`, `application_credential_id`, `application_credential_secret` | yes | Same as `00-provider-auth` |
| `external_network_name` | yes | Public/external network name in Neutron |
| `flavor_name` | yes | Nova flavor |
| `boot_volume_size_gb` | no | Default `10` |
| `volume_type` | no | Cinder type name if required |
| `name_prefix` | no | Default `tf-lesson-compute` |
| `private_cidr` | no | Default `192.168.42.0/24` |
| `dns_nameservers` | no | Default `[]` |
| `image_name`, `local_image_path` | no | Image upload |
| `keypair_name`, `public_key_path`, `public_key` | no | Key pair |

## Steps

1. Download the image (Part 1).
2. Copy `terraform.tfvars.example` to `terraform.tfvars` and set auth, `external_network_name`, `flavor_name`, and other values as needed.
3. From **`examples/20-compute`**: `terraform init` / `plan` / `apply`.

## Outputs

Network: `network_id`, `subnet_id`, `router_id`, `external_network_id`, `floating_ip_id`

Compute: `image_id`, `image_name`, `boot_volume_id`, `keypair_name`, `keypair_fingerprint`, `instance_id`, `private_ipv4`, `floating_ip_address`

SSH (CirrOS): `ssh cirros@<floating_ip_address>` (confirm user name for your image).


## Security note

The security group allows **SSH and ICMP from anywhere** for learning. Restrict `remote_ip_prefix` in production. **Egress** is not defined in Terraform here: Neutron adds default allow-all egress rules when the group is created (an explicit duplicate egress rule can return HTTP 409).

