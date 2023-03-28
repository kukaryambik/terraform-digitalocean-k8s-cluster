# terraform-digitalocean-k8s-cluster


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.27.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_kubernetes_node_pool.node_pool](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_node_pool) | resource |
| [digitalocean_project_resources.project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_kubernetes_versions.cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_versions) | data source |
| [digitalocean_project.cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_upgrade"></a> [auto\_upgrade](#input\_auto\_upgrade) | (Optional) A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window. | `bool` | `null` | no |
| <a name="input_ha"></a> [ha](#input\_ha) | (Optional) Enable/disable the high availability control plane for a cluster. High availability can only be set when creating a cluster. Any update will create a new cluster. Default: false | `bool` | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | (Optional) The slug identifier for the version of Kubernetes used for the cluster. Use doctl to find the available versions doctl kubernetes options versions. (Note: A cluster may only be upgraded to newer versions in-place. If the version is decreased, a new resource will be created.) | `string` | `null` | no |
| <a name="input_kubernetes_version_prefix"></a> [kubernetes\_version\_prefix](#input\_kubernetes\_version\_prefix) | (Optional) If provided, Terraform will only return versions that match the string prefix. For example, 1.15. will match all 1.15.x series releases. | `string` | `null` | no |
| <a name="input_maintenance_policy"></a> [maintenance\_policy](#input\_maintenance\_policy) | (Optional) A block representing the cluster's maintenance window. Updates will be applied within this window. If not specified, a default maintenance window will be chosen. auto\_upgrade must be set to true for this to have an effect. | <pre>object({<br>    # Required<br>    day        = string<br>    start_time = string<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) A name for the Kubernetes cluster. | `string` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | (Required) A block representing the cluster's default node pool. Additional node pools may be added to the cluster using the digitalocean\_kubernetes\_node\_pool resource. | <pre>list(object({<br>    # Required<br>    name = string<br>    size = string<br><br>    # Optional<br>    default    = optional(bool, false)<br>    node_count = optional(number, null)<br>    auto_scale = optional(bool, null)<br>    min_nodes  = optional(number, null)<br>    max_nodes  = optional(number, null)<br>    tags       = optional(list(string), null)<br>    labels     = optional(map(string), null)<br>    taint = optional(object({<br>      key    = string<br>      value  = string<br>      effect = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Optional) the ID of the DO project. | `string` | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | (Optional) name of the DO project. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) The slug identifier for the region where the Kubernetes cluster will be created. | `string` | n/a | yes |
| <a name="input_surge_upgrade"></a> [surge\_upgrade](#input\_surge\_upgrade) | (Optional) Enable/disable surge upgrades for a cluster. Default: false | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A list of tag names to be applied to the Kubernetes cluster. | `list(string)` | `null` | no |
| <a name="input_vpc_uuid"></a> [vpc\_uuid](#input\_vpc\_uuid) | (Optional) The ID of the VPC where the Kubernetes cluster will be located. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auto_upgrade"></a> [auto\_upgrade](#output\_auto\_upgrade) | A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window. |
| <a name="output_cluster_subnet"></a> [cluster\_subnet](#output\_cluster\_subnet) | The range of IP addresses in the overlay network of the Kubernetes cluster. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The date and time when the Kubernetes cluster was created. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The base URL of the API server on the Kubernetes master node. |
| <a name="output_id"></a> [id](#output\_id) | A unique ID that can be used to identify and reference a Kubernetes cluster. |
| <a name="output_ipv4_address"></a> [ipv4\_address](#output\_ipv4\_address) | The public IPv4 address of the Kubernetes master node. This will not be set if high availability is configured on the cluster (v1.21+) |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | A representation of the Kubernetes cluster's kubeconfig. |
| <a name="output_maintenance_policy"></a> [maintenance\_policy](#output\_maintenance\_policy) | A block representing the cluster's maintenance window. Updates will be applied within this window. If not specified, a default maintenance window will be chosen. |
| <a name="output_node_pool"></a> [node\_pool](#output\_node\_pool) | n/a |
| <a name="output_service_subnet"></a> [service\_subnet](#output\_service\_subnet) | The range of assignable IP addresses for services running in the Kubernetes cluster. |
| <a name="output_status"></a> [status](#output\_status) | A string indicating the current status of the cluster. Potential values include running, provisioning, and errored. |
| <a name="output_updated_at"></a> [updated\_at](#output\_updated\_at) | The date and time when the Kubernetes cluster was last updated. |
| <a name="output_urn"></a> [urn](#output\_urn) | The uniform resource name (URN) for the Kubernetes cluster. |
<!-- END_TF_DOCS -->