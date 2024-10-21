locals {
  common_tags = {
    Environment    = var.env
    BuildingBlock  = var.building_block
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  for_each            = var.clusters
  name                = each.value.cluster_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.cluster_name
  kubernetes_version  = each.value.aks_version

  private_cluster_enabled = true

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  default_node_pool {
    name       = each.value.aks_nodepool_name
    node_count = each.value.aks_node_count
    vm_size    = each.value.aks_node_size
  }

  identity {
    type = each.value.aks_cluster_identity
  }

  tags = merge(
    local.common_tags,
    each.value.additional_tags
  )
}

resource "local_file" "kubeconfig" {
  for_each = var.clusters
  content  = azurerm_kubernetes_cluster.aks[each.key].kube_config_raw
  filename = "${each.value.cluster_name}-${each.key}-kubeconfig.yaml"
}
