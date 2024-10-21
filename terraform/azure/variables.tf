variable "clusters" {
  description = "List of clusters to create"
  type = list(object({
    resource_group_name   = string
    location              = string
    vnet_name             = string
    address_space         = string
    subnet_name           = string
    subnet_address_prefix = string
    cluster_name          = string
    dns_prefix            = string
    kubernetes_version    = string
    node_count            = number
    vm_size               = string
  }))
}
