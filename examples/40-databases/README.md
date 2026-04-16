# 40-databases

Creates a Trove database instances, private network, an Ubuntu VM that could connect to these instances:

- MySQL 8.4 (`mysql.tf`) with a test database and user.
- MariaDB 11.4 (`mariadb.tf`) with a test database and user.
- PostgreSQL 18 (`postgresql.tf`) with a test database and user (no MySQL-style host pattern).

The networking pattern is the same as `examples/10-network` and `examples/20-compute`


## Prerequisites

- Same Application Credential variables as `examples/00-provider-auth`.
- Trove enabled in your project with datastores available for all three engines (`mysql`/`8.4`, `mariadb`/`11.4`, `postgresql`/`18` by default). Override per-engine versions if your cloud offers different ones.
- Glance image `Ubuntu Noble Numbat x86_64` (or set `vm_image_name`).
- Flavor names for VM and DB (`vm_flavor_name`, `db_flavor_name`). The same DB flavor is used for all three engines.
- Cinder volume type for Trove (`db_volume_type`). The same volume type and size are used for all three engines.

## Inputs (high level)

| Name | Required | Notes |
|------|----------|--------|
| `auth_url`, `region`, `application_credential_id`, `application_credential_secret` | yes | Same as `00-provider-auth` |
| `external_network_name` | yes | Neutron external/public network |
| `db_volume_type` | yes | Trove data volume type (shared across engines) |
| `db_test_user_password` | yes | Password for the test user on every engine |
| `db_volume_size_gb` | no | Default `20` |
| `db_test_database_name`, `db_test_user_name` | no | Defaults `testdb`, `testuser` |
| `db_test_user_host` | no | MySQL/MariaDB only; default derived from `private_cidr` |
| `vm_image_name`, `vm_flavor_name` | no | VM image/flavor |
| `db_flavor_name` | no | Shared Nova flavor for all three Trove instances |
| `mysql_datastore_version`, `mariadb_datastore_version`, `postgresql_datastore_version` | no | Defaults `8.4`, `11.4`, `18` |
| `mysql_instance_name`, `mariadb_instance_name`, `postgresql_instance_name` | no | Trove instance names |
| `private_cidr`, `dns_nameservers`, key pair variables | no | See `variables.tf` |

## Steps

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and set required values.
2. From `examples/40-databases`: `terraform init`, `terraform plan`, `terraform apply`.

## Outputs

- `vm_floating_ip`, `vm_private_ipv4`
- `mysql_instance_id`, `mysql_addresses`
- `mariadb_instance_id`, `mariadb_addresses`
- `postgresql_instance_id`, `postgresql_addresses`
- `db_test_database_name`, `db_test_user_name`, `db_test_user_host`

## Notes

- The same `db_test_database_name`, `db_test_user_name`, and `db_test_user_password` are created on all three instances.
- `db_test_user_host` applies only to MySQL and MariaDB; PostgreSQL's `openstack_db_user_v1` is created without a host.

## Security note

Sensitive values are stored in Terraform state. Use a secure backend and do not commit `terraform.tfstate` or filled `terraform.tfvars`.
