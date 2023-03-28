locals {
  k8s = digitalocean_kubernetes_cluster.cluster
}

output "id" {
  description = "A unique ID that can be used to identify and reference a Kubernetes cluster."
  value       = local.k8s.id
}

output "cluster_subnet" {
  description = "The range of IP addresses in the overlay network of the Kubernetes cluster."
  value       = local.k8s.cluster_subnet
}

output "service_subnet" {
  description = "The range of assignable IP addresses for services running in the Kubernetes cluster."
  value       = local.k8s.service_subnet
}

output "ipv4_address" {
  description = "The public IPv4 address of the Kubernetes master node. This will not be set if high availability is configured on the cluster (v1.21+)"
  value       = local.k8s.ipv4_address
}

output "endpoint" {
  description = "The base URL of the API server on the Kubernetes master node."
  value       = local.k8s.endpoint
}

output "status" {
  description = "A string indicating the current status of the cluster. Potential values include running, provisioning, and errored."
  value       = local.k8s.status
}

output "created_at" {
  description = "The date and time when the Kubernetes cluster was created."
  value       = local.k8s.created_at
}

output "updated_at" {
  description = "The date and time when the Kubernetes cluster was last updated."
  value       = local.k8s.updated_at
}

output "auto_upgrade" {
  description = "A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window."
  value       = local.k8s.auto_upgrade
}

output "kube_config" {
  description = "A representation of the Kubernetes cluster's kubeconfig."
  sensitive   = true

  value = {
    raw_config             = local.k8s.kube_config.0.raw_config
    host                   = local.k8s.kube_config.0.host
    cluster_ca_certificate = local.k8s.kube_config.0.cluster_ca_certificate
    token                  = local.k8s.kube_config.0.token
    client_key             = local.k8s.kube_config.0.client_key
    client_certificate     = local.k8s.kube_config.0.client_certificate
    expires_at             = local.k8s.kube_config.0.expires_at
  }
}

output "node_pool" {
  value = {
    id                = local.k8s.node_pool.id
    actual_node_count = local.k8s.node_pool.actual_node_count
    nodes             = local.k8s.node_pool.nodes
    name              = local.k8s.node_pool.name
    status            = local.k8s.node_pool.status
    droplet_id        = local.k8s.node_pool.droplet_id
    created_at        = local.k8s.node_pool.created_at
    updated_at        = local.k8s.node_pool.updated_at
    taint = {
      key    = local.k8s.node_pool.taint.key
      value  = local.k8s.node_pool.taint.value
      effect = local.k8s.node_pool.taint.effect
    }
  }
}

output "urn" {
  description = "The uniform resource name (URN) for the Kubernetes cluster."
  value       = local.k8s.urn
}

output "maintenance_policy" {
  description = "A block representing the cluster's maintenance window. Updates will be applied within this window. If not specified, a default maintenance window will be chosen."
  value = {
    day        = local.k8s.maintenance_policy.day
    duration   = local.k8s.maintenance_policy.duration
    start_time = local.k8s.maintenance_policy.start_time
  }
}
