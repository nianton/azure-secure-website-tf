output "id" {
  value = azurerm_virtual_network.vnet.id
}
output "default_subnet_id" {
  value = azurerm_subnet.default.id
}
output "app_subnet_id" {
  value = azurerm_subnet.appsubnet.id
}
output "integration_subnet_id" {
  value = azurerm_subnet.integrationsubnet.id
}
output "bastion_subnet_id" {
  value = azurerm_subnet.bastionsubnet.id
}
