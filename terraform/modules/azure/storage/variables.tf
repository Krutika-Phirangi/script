variable "storages" {
  description = "Map of storage accounts with required properties"
  type = map(object({ 
    storage_account_name     = string
    resource_group_name      = string
    azure_storage_tier       = string
    azure_storage_replication = string
    storage_container_name    = string
    additional_tags          = map(string)
  }))
}