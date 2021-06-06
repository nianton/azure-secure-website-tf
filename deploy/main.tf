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

module "web_app" {
  source = "./web"

  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.defaultTags
  app_settings = {
    "MY_NEW_SETTING" = "lol"
  }

  name        = module.naming.app_service.name
  asp_name    = module.naming.app_service_plan.name
  appins_name = module.naming.application_insights.name
}

module "sql" {
  source              = "./sql"
  name                = module.naming.mssql_server.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.defaultTags
}

module "vnet" {
  source              = "./vnet"
  name                = module.naming.virtual_network.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.defaultTags
}

output "names" {
  value = module.naming.resource_group
}

# output "all_names" {
#   value = module.naming
# }

