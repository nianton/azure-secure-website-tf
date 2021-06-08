resource "azurerm_private_dns_zone" "dnsprivatezone" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnszonelink" {
  name                  = "dnszonelink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dnsprivatezone.name
  virtual_network_id    = var.vnet_id
  tags = var.tags
}