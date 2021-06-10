terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.62.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>2.2"
    }
  }
}

provider "azurerm" {
  features {
  }
}

provider "random" {

}

resource "random_password" "vmpwd" {
  length           = 16
  special          = true
  override_special = "_%@!"
}

locals {
  resource_base_name = "${var.app_name}-${var.environment}"
  defaultTags = {
    appName     = var.app_name
    environment = var.environment
  }
}

module "naming" {
  source = "github.com/Azure/terraform-azurerm-naming" # "Azure/naming/azurerm"
  prefix = var.naming_convention_type == "prefix" ? [local.resource_base_name] : []
  suffix = var.naming_convention_type == "suffix" ? [local.resource_base_name] : []
}

resource "azurerm_resource_group" "rg" {
  name     = module.naming.resource_group.name
  location = var.location
  tags     = local.defaultTags
}

module "vnet" {
  source              = "./vnet"
  name                = module.naming.virtual_network.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.defaultTags
}

module "sql" {
  source              = "./sql"
  name                = module.naming.mssql_server.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  db_name             = module.naming.mssql_database.name
  db_admin            = "dbadmin"
  db_password         = "Qwertyuiop[]|"
  tags                = local.defaultTags
  vnet_id             = module.vnet.id
  app_subnet_id       = module.vnet.app_subnet_id
}

module "bastion" {
  source              = "./bastion"
  name                = module.naming.bastion_host.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.defaultTags
  subnet_id           = module.vnet.bastion_subnet_id
}

module "web_app" {
  source = "./web"

  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  tags                  = local.defaultTags
  name                  = module.naming.app_service.name
  asp_name              = module.naming.app_service_plan.name
  appins_name           = module.naming.application_insights.name
  vnet_id               = module.vnet.id
  integration_subnet_id = module.vnet.integration_subnet_id
  app_subnet_id         = module.vnet.app_subnet_id
  app_settings = {
    "TEST_ADDITIONAL_SETTING" = "TEST_VALUE"
    "DB_CONNECTION_STRING"    = module.sql.connection_string
  }
}

module "waf" {
  source = "./appgw"

  name                = module.naming.application_gateway.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.defaultTags
  subnet_id           = module.vnet.default_subnet_id
}

module "servicebus" {
  source = "./servicebus"

  name                = module.naming.servicebus_namespace.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Premium"
  tags                = local.defaultTags
  vnet_id             = module.vnet.id
  subnet_id           = module.vnet.app_subnet_id
}

module "storageaccount" {
   source = "./storage"

  name                = replace(module.naming.storage_account.name, "-", "")
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.defaultTags
  vnet_id             = module.vnet.id
  subnet_id           = module.vnet.app_subnet_id
}

module "jumphost" {
  source = "./jumphost"

  name                = module.naming.virtual_machine.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = local.defaultTags
  admin_password      = random_password.vmpwd.result
  subnet_id           = module.vnet.admin_subnet_id
}

module "keyvault" {
  source = "./keyvault"

  name                       = module.naming.key_vault.name
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = var.location
  tags                       = local.defaultTags
  managed_identity_tenant_id = module.web_app.managed_identity_tenant_id
  managed_identity_object_id = module.web_app.managed_identity_object_id
  service_bus_connection     = module.servicebus.connection_string
  sql_connection             = module.sql.connection_string
}