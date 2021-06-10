output "id" {
  value = azurerm_key_vault.kv.id
}

output "sql_connection_kv_reference" {
  value = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.kv.name};SecretName=${azurerm_key_vault_secret.sqlconnection.name})"
}

output "servicebus_connection_kv_reference" {
  value = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.kv.name};SecretName=${azurerm_key_vault_secret.servicebusconnection.name})"
}