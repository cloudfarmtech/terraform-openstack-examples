# 20-compute

Compute lesson (step 1): upload a **local** CirrOS disk image to Glance with Terraform.

Depends on the same **Application Credential** variables as `examples/00-provider-auth`. This step does **not** require `10-network`, but later compute steps will use networks and floating IPs from that lesson.

## Download the image (local disk)

From this directory:

```bash
mkdir -p images
curl -fLo images/cirros-0.6.3-x86_64-disk.img \
  https://download.cirros-cloud.net/0.6.3/cirros-0.6.3-x86_64-disk.img
```

The default Terraform path is `images/cirros-0.6.3-x86_64-disk.img` next to this example. Override with `local_image_path` if you store the file elsewhere.

## What this creates

| Piece        | Terraform                         |
|-------------|------------------------------------|
| Glance image | `openstack_images_image_v2.cirros` |

Format: **qcow2** (`container_format = bare`, `disk_format = qcow2`), **private** visibility.

## Inputs

| Name | Required | Notes |
|------|----------|--------|
| `auth_url`, `region`, `application_credential_id`, `application_credential_secret` | yes | Same as lesson `00-provider-auth` |
| `image_name` | no | Default `tf-lesson-cirros-0.6.3-x86_64` |
| `local_image_path` | no | Defaults to `${path.module}/images/cirros-0.6.3-x86_64-disk.img` |

## Steps

1. Download the image (see above).
2. Copy `terraform.tfvars.example` to `terraform.tfvars` and set auth.
3. `terraform init` / `plan` / `apply`.

## Outputs

- `image_id` — use when creating an instance in the next steps
- `image_name`, `local_image_path_resolved`

## Next steps (later in this lesson)

- key pair, security group, instance, floating IP association (will use `10-network` outputs and this `image_id`)
