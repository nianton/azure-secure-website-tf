terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.62.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

locals {
  resource_base_name = "${var.appName}-${var.environment}"
  defaultTags = {
    appName     = var.appName
    environmnet = var.environment
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
    "DB_CONNECTION_STRING" = module.sql.connection_string
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

output "names" {
  value = module.naming.resource_group
}
