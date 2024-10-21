remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = get_env("AZURE_TERRAFORM_BACKEND_RG")
    storage_account_name = get_env("AZURE_TERRAFORM_BACKEND_STORAGE_ACCOUNT")
    container_name       = get_env("AZURE_TERRAFORM_BACKEND_CONTAINER")
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}