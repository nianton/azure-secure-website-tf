output "connection_string" {
  value = "Server=tcp:${azurerm_mssql_server.mssql_srv.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.mssql_db.name};Persist Security Info=False;User ID=${azurerm_mssql_server.mssql_srv.administrator_login};Password=${var.db_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}