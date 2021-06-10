resource "azurerm_storage_account" "stg" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

module "privatednszone" {
  source              = "../dnszone"
  name                = "privatelink.blob.core.windows.net"
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
    private_connection_resource_id = azurerm_storage_account.stg.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
