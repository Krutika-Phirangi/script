terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create network module for each cluster
module "network" {
  source                = "./azure/network"
  for_each              = { for cluster in var.clusters : cluster.cluster_name => cluster }
  resource_group_name   = each.value.resource_group_name
  location              = each.value.location
  vnet_name             = each.value.vnet_name
  address_space         = each.value.address_space
  subnet_name           = each.value.subnet_name
  subnet_address_prefix = each.value.subnet_address_prefix
}

# Create AKS module for each cluster
module "aks" {
  source              = "./azure/aks"
  for_each            = { for cluster in var.clusters : cluster.cluster_name => cluster }
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  cluster_name        = each.value.cluster_name
  dns_prefix          = each.value.dns_prefix
  kubernetes_version  = each.value.kubernetes_version
  node_count          = each.value.node_count
  vm_size             = each.value.vm_size
  subnet_id           = module.network[each.key].subnet_id
}

# Create storage module for each cluster
module "storage" {
  source               = "./azure/storage"
  for_each             = { for cluster in var.clusters : cluster.cluster_name => cluster }
  resource_group_name  = each.value.resource_group_name
  location             = each.value.location
  storage_account_name = lower(each.value.cluster_name)
}

provider "helm" {
  kubernetes {
    host                   = module.aks[each.key].kubernetes_host
    client_certificate     = module.aks[each.key].client_certificate
    client_key             = module.aks[each.key].client_key
    cluster_ca_certificate = module.aks[each.key].cluster_ca_certificate
  }
}
