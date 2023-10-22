output "static_website_url" {
	value = azurerm_storage_account.storage_account.primary_web_endpoint
}