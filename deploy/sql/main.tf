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

resource "azurerm_mssql_server" "mssql_srv" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.db_admin
  administrator_login_password = var.db_password
  minimum_tls_version          = "1.2"
  tags                         = var.tags
}

resource "azurerm_mssql_server_extended_auditing_policy" "mssqlaudit" {
  server_id                               = azurerm_mssql_server.mssql_srv.id
  storage_endpoint                        = azurerm_storage_account.stg.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.stg.primary_access_key
  storage_account_access_key_is_secondary = true
  retention_in_days                       = 6
}

resource "azurerm_mssql_database" "mssql_db" {
  name           = var.db_name
  server_id      = azurerm_mssql_server.mssql_srv.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true
  tags           = var.tags
}
