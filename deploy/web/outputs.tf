output "id" {
    value = azurerm_app_service.webApp.id
}

output "identity" {
  value = azurerm_app_service.webApp.identity[0].tenant_id
}

output "plan_id" {
    value = azurerm_app_service_plan.asp.id
}

output "appins_id" {
  value = azurerm_application_insights.appins.id
}

output "appins_instrumentation_key" {
  value = azurerm_application_insights.appins.instrumentation_key
}