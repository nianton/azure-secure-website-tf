resource "azurerm_app_service_plan" "asp" {
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  sku {
    tier = substr(var.sku_name, 0, 1) == "S" ? "Standard" : "PremiumV3"
    size = var.sku_name
  }
}

resource "azurerm_application_insights" "appins" {
  # count               = var.include_app_insights ? 1 : 0
  name                = var.appins_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  application_type    = "web"
}

resource "azurerm_app_service" "webapp" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  tags                = var.tags
  https_only          = true
  identity {
    type = var.use_managed_identity ? "SystemAssigned" : "None"
  }

  app_settings = merge({
    "WEBSITE_DNS_SERVER"                    = "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL"                = "1"
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.appins.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.appins.connection_string
  }, var.app_settings)

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
  app_service_id = azurerm_app_service.webapp.id
  subnet_id      = var.integration_subnet_id
}

resource "azurerm_private_dns_zone" "dnsprivatezone" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnszonelink" {
  name                  = "dnszonelink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dnsprivatezone.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_endpoint" "privateendpoint" {
  name                = "pe-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.app_subnet_id

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.dnsprivatezone.id]
  }

  private_service_connection {
    name                           = "privateendpointconnection"
    private_connection_resource_id = azurerm_app_service.webapp.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}