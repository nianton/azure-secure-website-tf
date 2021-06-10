
resource "azurerm_servicebus_namespace" "sbns" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  capacity            = 1
  tags                = var.tags
}

module "privatednszone" {
  source              = "../dnszone"
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.resource_group_name
  vnet_id             = var.vnet_id
  tags                = var.tags
}

resource "azurerm_private_endpoint" "privateendpoint" {
  name                = "pe-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [module.privatednszone.id]
  }

  private_service_connection {
    name                           = "privateendpointconnection"
    private_connection_resource_id = azurerm_servicebus_namespace.sbns.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }
}
