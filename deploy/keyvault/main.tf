data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "premium"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
      "list"
    ]

    secret_permissions = [
      "set",
      "get",
      "list",
      "delete",
      "purge",
      "recover"
    ]

    storage_permissions = [
      "get",
      "list"
    ]
  }

  access_policy {
    tenant_id = var.managed_identity_tenant_id
    object_id = var.managed_identity_object_id

    key_permissions = [
      "get",
    ]

    secret_permissions = [
      "get",
    ]
  }
}

resource "azurerm_key_vault_secret" "sample_secret" {
  name         = "MySecretCombination"
  value        = "ITS_A_MYSTERY_TO_YOU"
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "servicebusconnection" {
  name         = "ServiceBusConnection"
  value        = var.service_bus_connection
  key_vault_id = azurerm_key_vault.kv.id
}


resource "azurerm_key_vault_secret" "sqlconnection" {
  name         = "SqlDbConnection"
  value        = var.sql_connection
  key_vault_id = azurerm_key_vault.kv.id
}