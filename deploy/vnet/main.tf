resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.address_spaces.vnet]
  tags                = var.tags
}

resource "azurerm_subnet" "default" {
  name                 = "snet-default-${var.name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.address_spaces.default_subnet]
}

resource "azurerm_subnet" "appsubnet" {
  name                                           = "snet-app-${var.name}"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = [var.address_spaces.app_subnet]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "integrationsubnet" {
  name                 = "snet-integration-${var.name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.address_spaces.integration_subnet]
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_subnet" "adminsubnet" {
  name                 = "snet-admin-${var.name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.address_spaces.admin_subnet]
}

resource "azurerm_subnet" "bastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.address_spaces.bastion_subnet]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "adminsubnetnsg" {
  subnet_id                 = azurerm_subnet.adminsubnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
