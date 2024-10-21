
variable "clusters" {
  type = map(object({
    location             = string
    cluster_name         = string
    aks_version          = string
    aks_nodepool_name    = string
    aks_node_count       = number
    aks_node_size        = string
    aks_cluster_identity = string
    resource_group_name  = string
    additional_tags      = map(string)
  }))
}

variable "env" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "building_block" {
  description = "The building block name for resource identification"
  type        = string
}
