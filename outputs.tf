output "id" {
  description = "A unique ID that can be used to identify and reference a Kubernetes cluster."
  value       = digitalocean_kubernetes_cluster.cluster.id
}

output "cluster_subnet" {
  description = "The range of IP addresses in the overlay network of the Kubernetes cluster."
  value       = digitalocean_kubernetes_cluster.cluster.cluster_subnet
}

output "service_subnet" {
  description = "The range of assignable IP addresses for services running in the Kubernetes cluster."
  value       = digitalocean_kubernetes_cluster.cluster.service_subnet
}

output "ipv4_address" {
  description = "The public IPv4 address of the Kubernetes master node. This will not be set if high availability is configured on the cluster (v1.21+)"
  value       = digitalocean_kubernetes_cluster.cluster.ipv4_address
}

output "endpoint" {
  description = "The base URL of the API server on the Kubernetes master node."
  value       = digitalocean_kubernetes_cluster.cluster.endpoint
}

output "status" {
  description = "A string indicating the current status of the cluster. Potential values include running, provisioning, and errored."
  value       = digitalocean_kubernetes_cluster.cluster.status
}

output "created_at" {
  description = "The date and time when the Kubernetes cluster was created."
  value       = digitalocean_kubernetes_cluster.cluster.created_at
}

output "updated_at" {
  description = "The date and time when the Kubernetes cluster was last updated."
  value       = digitalocean_kubernetes_cluster.cluster.updated_at
}

output "auto_upgrade" {
  description = "A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window."
  value       = digitalocean_kubernetes_cluster.cluster.auto_upgrade
}

output "kube_config" {
  description = "A representation of the Kubernetes cluster's kubeconfig."
  value       = digitalocean_kubernetes_cluster.cluster.kube_config.0
  sensitive   = true
}

output "node_pool" {
  value = digitalocean_kubernetes_cluster.cluster.node_pool
}

output "urn" {
  description = "The uniform resource name (URN) for the Kubernetes cluster."
  value       = digitalocean_kubernetes_cluster.cluster.urn
}

output "maintenance_policy" {
  description = "A block representing the cluster's maintenance window. Updates will be applied within this window. If not specified, a default maintenance window will be chosen."
  value       = digitalocean_kubernetes_cluster.cluster.maintenance_policy
}
