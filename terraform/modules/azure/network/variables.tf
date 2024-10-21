
variable "env" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "building_block" {
  description = "The building block name for resource identification"
  type        = string
}

variable "networks" {
  description = "Map of networks where each network defines a resource group, CIDR block, and additional tags"
  type = map(object({
    location                      = string
    resource_group_name           = string      
    vnet_name                     = string
    vnet_cidr                     = string
    subnet_name                   = string
    aks_subnet_cidr               = string
    aks_subnet_service_endpoints  = list(string)
    additional_tags               = map(string)
  }))
}