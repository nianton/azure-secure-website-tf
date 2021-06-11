output "names" {
  value = module.naming.resource_group
}

output "jumphost_admin_password" {
  value     = random_password.vmpwd.result
  sensitive = true
}

output "sql_admin_password" {
  value     = random_password.sqlpwd.result
  sensitive = true
}

output "website_fqdn" {
  value = module.waf.fqdn
}