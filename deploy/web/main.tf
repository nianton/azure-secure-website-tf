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

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
