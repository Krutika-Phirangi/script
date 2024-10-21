data "azurerm_subscription" "current" {}

variable "networks" {
  type = map(object({
    location                = string
    vnet_cidr                = string
    aks_subnet_cidr          = string
    aks_subnet_service_endpoints = list(string)
    resource_group_name      = string
    additional_tags          = map(string)
  }))
}

locals {
    common_tags = {
      Environment = "${var.env}"
      BuildingBlock = "${var.building_block}"
    }
    subid = split("-", "${data.azurerm_subscription.current.subscription_id}")
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.networks
  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = [each.value.vnet_cidr]

  tags = merge(
    local.common_tags,
    each.value.additional_tags
  )
}

resource "azurerm_subnet" "aks_subnet" {
  for_each            = var.networks
  name                = each.value.subnet_name
  resource_group_name = each.value.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = [each.value.aks_subnet_cidr]
  service_endpoints    = each.value.aks_subnet_service_endpoints
}
