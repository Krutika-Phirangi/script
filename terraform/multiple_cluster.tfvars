clusters = {
  "cluster1" = {
    location             = "East US"
    cluster_name         = ""
    aks_version          = "1.26"
    aks_nodepool_name    = "default"
    aks_node_count       = 2
    aks_node_size        = "Standard_DS2_v2"
    aks_cluster_identity = "SystemAssigned"
    resource_group_name  = "rg-cluster1"
    additional_tags      = { Project = "Cluster1" }
  }
  "cluster2" = {
    location             = "West US"
    cluster_name         = ""
    aks_version          = "1.26"
    aks_nodepool_name    = "default"
    aks_node_count       = 3
    aks_node_size        = "Standard_DS3_v2"
    aks_cluster_identity = "SystemAssigned"
    resource_group_name  = "rg-cluster2"
    additional_tags      = { Project = "Cluster2" }
  }
}

networks = {
  "cluster1" = {
    vnet_cidr                    = "10.0.0.0/16"
    aks_subnet_cidr              = "10.0.1.0/24"
    aks_subnet_service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
    resource_group_name          = "rg-cluster1"
    location                     = "West US"
    additional_tags              = { Network = "Cluster1" }
  }
  "cluster2" = {
    vnet_cidr                    = "10.1.0.0/16"
    aks_subnet_cidr              = "10.1.1.0/24"
    aks_subnet_service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
    resource_group_name          = "rg-cluster2"
    location                     = "West US"
    additional_tags              = { Network = "Cluster2" }
  }
}

storages = {
  "cluster1" = {
    azure_storage_tier        = "Standard_LRS"
    azure_storage_replication = "LRS"
    resource_group_name       = "rg-cluster1"
    additional_tags           = { Storage = "Cluster1" }
  }
  "cluster2" = {
    azure_storage_tier        = "Standard_LRS"
    azure_storage_replication = "LRS"
    resource_group_name       = "rg-cluster2"
    additional_tags           = { Storage = "Cluster2" }
  }
}
