# 30-kubernetes

Creates an **OpenStack Magnum** Kubernetes cluster from an **existing** cluster template (by name). The default template name is `Kubernetes v1.34.4`; change `cluster_template_name` if your cloud uses a different label.

This example does **not** define a cluster template in Terraform—it only looks up the template and creates a cluster.

## Prerequisites

- Same **Application Credential** variables as `examples/00-provider-auth`.
- **Magnum** (Container Infra API) enabled for your project and a **cluster template** you are allowed to use ( created by the cloud admin).
- An existing **Nova key pair** (`keypair_name`) for SSH access to nodes (see `examples/20-compute` for creating one).

Confirm template names in your cloud, for example:

```bash
openstack coe cluster template list
```

## Optional inputs

| Topic | Notes |
|-------|--------|
| `flavor_name`, `master_flavor_name` | Override worker/master flavors; omit to use the template defaults. |
| `floating_ip_enabled` | Set explicitly if you need to override Magnum behavior (may be constrained by the template). |
| `create_timeout` | Creation can take many minutes; default is `60`. |

## Steps

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and set auth, `keypair_name`, and any overrides.
2. From **`examples/30-kubernetes`**: `terraform init` / `plan` / `apply`.

## Outputs

- `cluster_id`, `api_address`, `coe_version`, `master_addresses`, `node_addresses`
- `kubeconfig_raw` (sensitive): full kubeconfig text
- `kubeconfig_host`: API URL from the kubeconfig map

Write kubeconfig to a file (after apply):

```bash
terraform output -raw kubeconfig_raw > kubeconfig.yaml
export KUBECONFIG="$PWD/kubeconfig.yaml"
kubectl get nodes
```

## Security note

The Magnum **kubeconfig** is stored in **Terraform state** as plain text (see [sensitive data in state](https://developer.hashicorp.com/terraform/language/state/sensitive-data)). Use a secure backend and restrict access. Do not commit `terraform.tfstate` or `terraform.tfvars`.

## Dependencies

- Independent of other lessons; only requires a suitable Magnum cluster template and credentials.
