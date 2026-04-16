locals {
  # Default MySQL host pattern for openstack_db_user_v1 assumes a /24 private subnet
  # (e.g. 192.168.44.0/24 -> "192.168.44.%"). Override via var.db_test_user_host for
  # other layouts.
  _private_net_octets = split(".", cidrhost(var.private_cidr, 0))
  db_test_user_host = coalesce(
    var.db_test_user_host,
    "${local._private_net_octets[0]}.${local._private_net_octets[1]}.${local._private_net_octets[2]}.%",
  )
}
