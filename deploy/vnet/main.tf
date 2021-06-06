resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "snet-app-${var.name}"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "snet-integration-${var.name}"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "snet-admin-${var.name}"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.nsg.id
  }

  subnet {
    name           = "AzureBastionSubnet"
    address_prefix = "10.0.4.0/24"
  }

  tags = var.tags
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = "pip-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = element(azurerm_virtual_network.vnet.subnet[*].id, 3)
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}
