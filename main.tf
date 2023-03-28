data "digitalocean_kubernetes_versions" "cluster" {
  version_prefix = var.kubernetes_version_prefix
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  # Required
  name    = var.name
  region  = var.region
  version = var.auto_upgrade ? data.digitalocean_kubernetes_versions.cluster.latest_version : var.kubernetes_version

  # Optional
  vpc_uuid      = var.vpc_uuid
  auto_upgrade  = var.auto_upgrade
  surge_upgrade = var.surge_upgrade
  ha            = var.ha
  tags          = var.tags

  # Required block
  dynamic "node_pool" {
    for_each = {
      for k, v in var.node_pools : k => v
      if v.default
    }
    iterator = np
    content {
      # Required
      name = np.value.name
      size = np.value.size

      # Optional
      node_count = np.value.node_count
      auto_scale = np.value.auto_scale
      min_nodes  = np.value.min_nodes
      max_nodes  = np.value.max_nodes
      tags       = np.value.tags
      labels     = np.value.labels

      # Optional block
      dynamic "taint" {
        for_each = lookup(np.value, "taint", null) != null ? np.value.taint[*] : []
        content {
          key    = taint.value.key
          value  = taint.value.value
          effect = taint.value.effect
        }
      }
    }
  }

  # Optional block
  dynamic "maintenance_policy" {
    for_each = var.maintenance_policy != null ? var.maintenance_policy[*] : []
    iterator = mp
    content {
      day        = mp.value.day
      start_time = mp.value.start_time
    }
  }
}

resource "digitalocean_kubernetes_node_pool" "node_pool" {
  for_each = {
    for k, v in var.node_pools : k => v
    if v.default
  }

  # Required
  cluster_id = digitalocean_kubernetes_cluster.cluster.id
  name       = each.value.name
  size       = each.value.size

  # Optional
  node_count = each.value.node_count
  auto_scale = each.value.auto_scale
  min_nodes  = each.value.min_nodes
  max_nodes  = each.value.max_nodes
  tags       = each.value.tags
  labels     = each.value.labels

  # Optional block
  dynamic "taint" {
    for_each = lookup(each.value, "taint", null) != null ? each.value.taint[*] : []
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }
}

data "digitalocean_project" "cluster" {
  count = var.project_id != "" || var.project_name != "" ? 1 : 0

  id   = var.project_id
  name = var.project_name
}

resource "digitalocean_project_resources" "project" {
  for_each = data.digitalocean_project.cluster

  project = each.value.id
  resources = [
    digitalocean_kubernetes_cluster.cluster.urn
  ]
}
