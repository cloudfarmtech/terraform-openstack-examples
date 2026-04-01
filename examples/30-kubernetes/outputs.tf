output "cluster_id" {
  description = "Magnum cluster UUID"
  value       = openstack_containerinfra_cluster_v1.this.id
}

output "cluster_name" {
  description = "Magnum cluster name"
  value       = openstack_containerinfra_cluster_v1.this.name
}

output "api_address" {
  description = "Kubernetes API endpoint reported by Magnum"
  value       = openstack_containerinfra_cluster_v1.this.api_address
}

output "coe_version" {
  description = "Container orchestration engine version"
  value       = openstack_containerinfra_cluster_v1.this.coe_version
}

output "master_addresses" {
  description = "Control plane node addresses"
  value       = openstack_containerinfra_cluster_v1.this.master_addresses
}

output "node_addresses" {
  description = "Worker node addresses"
  value       = openstack_containerinfra_cluster_v1.this.node_addresses
}

output "kubeconfig_raw" {
  description = "Full kubeconfig file content (sensitive; also stored in Terraform state)"
  value       = openstack_containerinfra_cluster_v1.this.kubeconfig["raw_config"]
  sensitive   = true
}
