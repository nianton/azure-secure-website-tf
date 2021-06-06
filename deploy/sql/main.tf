locals {
  storage_account_name = "st${lower(replace(var.name, "-", ""))}"
}

resource "azurerm_storage_account" "stg" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "mssql" {
  name                         =  var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"
  minimum_tls_version          = "1.2"

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.stg.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.stg.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = var.tags
}
