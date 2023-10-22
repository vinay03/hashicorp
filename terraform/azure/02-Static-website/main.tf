resource "azurerm_resource_group" "resource_group" {
	name = "static-website-demo"
	location = "southindia"
}

# Create a storage account
resource "azurerm_storage_account" "storage_account" {
	name                     = "minviterstorage1"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
	account_kind  = "StorageV2"

	static_website {
		index_document = "index.html"
	}

  tags = {
    environment = "dev"
  }
}

# resource "azurerm_storage_container" "static-web-container" {
#   name                  = "content"
#   storage_account_name  = azurerm_storage_account.storage_account.name
#   container_access_type = "private"
# }

resource "azurerm_storage_blob" "wbsite_blob_storage" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  # storage_container_name = azurerm_storage_container.static-web-container.name
	storage_container_name = "$web"
  type                   = "Block"
	content_type = "text/html"
  source_content         = file("index.html")
}