naming_convention_type  = "suffix"
app_name                = "secweb"
location                = "westeurope"
environment             = "test"
sql_admin_username      = "dbadmin"
jumphost_admin_username = "vmadmin"
vnet_address_spaces = {
  vnet               = "10.0.0.0/16"
  default_subnet     = "10.0.0.0/24"
  app_subnet         = "10.0.1.0/24"
  integration_subnet = "10.0.2.0/24"
  admin_subnet       = "10.0.3.0/24"
  bastion_subnet     = "10.0.4.0/24"
}