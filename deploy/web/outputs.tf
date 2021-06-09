output "id" {
    value = azurerm_app_service.webapp.id
}

output "managed_identity_tenant_id" {
  value = azurerm_app_service.webapp.identity[0].tenant_id
}

output "managed_identity_object_id" {
  value = azurerm_app_service.webapp.identity[0].principal_id
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