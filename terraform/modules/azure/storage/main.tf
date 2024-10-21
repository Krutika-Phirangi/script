

resource "azurerm_storage_account" "storage_account" {
  for_each            = var.storages
  name                = each.value.storage_account_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  account_tier        = each.value.azure_storage_tier
  account_replication_type = each.value.azure_storage_replication

  tags = merge(
    each.value.additional_tags
  )
}

resource "azurerm_storage_container" "storage_container" {
  for_each = var.storages
  name     = each.value.storage_container_name
  storage_account_name = azurerm_storage_account.storage_account[each.key].name
  container_access_type = "private"
}
