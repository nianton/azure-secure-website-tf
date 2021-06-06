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

resource "azurerm_app_service" "webApp" {
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
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.appins.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.appins.connection_string
  }, var.app_settings)

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
