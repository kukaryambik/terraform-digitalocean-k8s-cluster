
# ----------------------------------------------------------------
# Required

variable "name" {
  description = "(Required) A name for the Kubernetes cluster."
  type        = string
}

variable "region" {
  description = "(Required) The slug identifier for the region where the Kubernetes cluster will be created."
  type        = string
}

variable "node_pools" {
  description = "(Required) A block representing the cluster's default node pool. Additional node pools may be added to the cluster using the digitalocean_kubernetes_node_pool resource."
  type = list(object({
    # Required
    name = string
    size = string

    # Optional
    default    = optional(bool, false)
    node_count = optional(number, null)
    auto_scale = optional(bool, null)
    min_nodes  = optional(number, null)
    max_nodes  = optional(number, null)
    tags       = optional(list(string), null)
    labels     = optional(map(string), null)
    taint = optional(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
}

# ----------------------------------------------------------------
# Optional

variable "project_id" {
  default     = null
  description = "(Optional) The ID of the DO project."
  type        = string
}

variable "project_name" {
  default     = null
  description = "(Optional) The name of the DO project."
  type        = string
}

variable "kubernetes_version" {
  default     = null
  description = "(Optional) The slug identifier for the version of Kubernetes used for the cluster. Use doctl to find the available versions doctl kubernetes options versions. (Note: A cluster may only be upgraded to newer versions in-place. If the version is decreased, a new resource will be created.)"
  type        = string
}

variable "kubernetes_version_prefix" {
  default     = null
  description = "(Optional) If provided, Terraform will only return versions that match the string prefix. For example, 1.15. will match all 1.15.x series releases."
  type        = string
}

variable "vpc_uuid" {
  default     = null
  description = "(Optional) The ID of the VPC where the Kubernetes cluster will be located."
  type        = string
}

variable "auto_upgrade" {
  default     = false
  description = "(Optional) A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window."
  type        = bool
}

variable "surge_upgrade" {
  default     = null
  description = "(Optional) Enable/disable surge upgrades for a cluster. Default: false"
  type        = bool
}

variable "ha" {
  default     = null
  description = "(Optional) Enable/disable the high availability control plane for a cluster. High availability can only be set when creating a cluster. Any update will create a new cluster. Default: false"
  type        = bool
}

variable "tags" {
  default     = null
  description = "(Optional) A list of tag names to be applied to the Kubernetes cluster."
  type        = list(string)
}

variable "maintenance_policy" {
  default     = null
  description = "(Optional) A block representing the cluster's maintenance window. Updates will be applied within this window. If not specified, a default maintenance window will be chosen. auto_upgrade must be set to true for this to have an effect."
  type = object({
    # Required
    day        = string
    start_time = string
  })
}
