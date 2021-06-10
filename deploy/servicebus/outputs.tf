output "connection_string" {
    value = azurerm_servicebus_namespace.sbns.default_primary_connection_string
}