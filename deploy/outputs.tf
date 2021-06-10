output "names" {
  value = module.naming.resource_group
}

output "jumphost_admin_username" {
  value = "adminuser"
  sensitive = true
}

output "jumphost_admin_password" {
  value = random_password.vmpwd.result
  sensitive = true
}