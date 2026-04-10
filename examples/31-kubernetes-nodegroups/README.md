# 31-kubernetes-nodegroups

Creates an **OpenStack Magnum** Kubernetes cluster and an **additional node group** (`openstack_containerinfra_nodegroup_v1`) with its own image and flavor—similar to `openstack coe cluster create` plus `openstack coe nodegroup create`.

This lesson also includes a Terraform-driven example of applying a Kubernetes **node taint** to a node group. The default cluster template name is `Kubernetes v1.34.4`; change `cluster_template_name` if your cloud uses a different label.

This example does **not** define a cluster template, it looks up the existing template by name, creates the cluster, then attaches the extra node group.


## Prerequisites

- Same **Application Credential** variables as `examples/00-provider-auth`.
- **Magnum** (Container Infra API) enabled for your project, **node group** support, and a **cluster template** you are allowed to use.
- An existing **Nova key pair** (`keypair_name`) for SSH access to nodes (see `examples/20-compute` for creating one).

Confirm template names in your cloud, for example:

```bash
openstack coe cluster template list
```

## Inputs

| Name | Required | Notes |
|------|----------|--------|
| `auth_url`, `region`, `application_credential_id`, `application_credential_secret` | yes | Same as `00-provider-auth` |
| `keypair_name` | yes | Nova key pair name |
| `cluster_name` | no | Default `tf-lesson-k8s-nodegroups` |
| `cluster_template_name` | no | Default `Kubernetes v1.34.4` |
| `master_count`, `node_count` | no | Default `1` each |
| `master_flavor_name` | no | Default `m.2vcpu.16gb` |
| `floating_ip_enabled` | no | Default `true` |
| `create_timeout` | no | Minutes; default `60` |
| `nodegroup_name` | no | Default `default` |
| `nodegroup_image` | no | Glance image name or UUID; default `CAPI v1.34.4 x86_64` |
| `nodegroup_flavor` | no | Default `g.8vcpu.32gb` |
| `nodegroup_node_count` | no | Default `1` |
| Taint example (`taints.tf`) | no | Applies `workload=batch:NoSchedule` to `capi.stackhpc.com/node-group=batch-worker`; update selector/taint values in `taints.tf` to match your node group |

## Steps

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and set auth, `keypair_name`, and image/flavor names that exist in your cloud.
2. If your extra node group name is not `batch-worker`, edit `selector` in `taints.tf` before apply.
3. From **`examples/31-kubernetes-nodegroups`**: `terraform init` / `plan` / `apply`.

## Outputs

`taints.tf` writes kubeconfig to a local `.kubeconfig` file and applies `workload=batch:NoSchedule` to nodes selected by `capi.stackhpc.com/node-group=batch-worker`.

- `cluster_id`, `cluster_name`, `api_address`, `coe_version`, `master_addresses`, `node_addresses`
- `nodegroup_id`
- `kubeconfig_raw` (sensitive): full kubeconfig text

Write kubeconfig to a file (after apply):

```bash
terraform output -raw kubeconfig_raw > kubeconfig.yaml
export KUBECONFIG="$PWD/kubeconfig.yaml"
kubectl get nodes
```

Workers from different Magnum node groups are distinguished on the node by the label `capi.stackhpc.com/node-group` (the group name). The default cluster worker pool is usually `capi.stackhpc.com/node-group=default-worker`; additional groups use their Magnum name (for example `batch-worker` when `nodegroup_name` is `batch-worker`).

```bash
kubectl get nodes -L capi.stackhpc.com/node-group
```

Verify taints:

```bash
kubectl get nodes -l capi.stackhpc.com/node-group=batch-worker -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.taints}{"\n"}{end}'
```

## Security note

The Magnum **kubeconfig** is stored in **Terraform state** as plain text (see [sensitive data in state](https://developer.hashicorp.com/terraform/language/state/sensitive-data)). Use a secure backend and restrict access. Do not commit `terraform.tfstate` or `terraform.tfvars`.

## Dependencies

- Conceptually extends `examples/30-kubernetes` (single cluster without extra node groups). You can apply this lesson on its own once a suitable Magnum template and credentials exist.
