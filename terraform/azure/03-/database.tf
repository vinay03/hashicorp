resource "azurerm_mysql_server" "primary" {
	name = var.db_server_name
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location
	
	administrator_login = var.db_username
	administrator_login_password = var.db_password

	sku_name = "B_Gen4_1" # 'tier_family_cores'
	storage_mb = 5120
	version = var.db_version

	auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  # ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "db" {
	name = "db"
	resource_group_name = azurerm_resource_group.rg.name
	server_name = azurerm_mysql_server.primary.name
	charset = "utf8"
	collation = "utf8_unicode_ci"
}