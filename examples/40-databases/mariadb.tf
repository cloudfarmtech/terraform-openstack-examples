resource "openstack_db_instance_v1" "mariadb" {
  name      = var.mariadb_instance_name
  flavor_id = data.openstack_compute_flavor_v2.db.id
  size      = var.db_volume_size_gb

  volume_type = var.db_volume_type

  datastore {
    type    = "mariadb"
    version = var.mariadb_datastore_version
  }

  network {
    uuid = openstack_networking_network_v2.private.id
  }

  depends_on = [
    openstack_networking_router_interface_v2.private,
  ]
}

resource "openstack_db_database_v1" "mariadb" {
  name        = var.db_test_database_name
  instance_id = openstack_db_instance_v1.mariadb.id
}

resource "openstack_db_user_v1" "mariadb" {
  name        = var.db_test_user_name
  instance_id = openstack_db_instance_v1.mariadb.id
  password    = var.db_test_user_password
  host        = local.db_test_user_host
  databases   = [openstack_db_database_v1.mariadb.name]
}
