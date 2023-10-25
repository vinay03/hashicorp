# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
	name = var.virtual_network_name 
	address_space = [ var.virtual_network_cidr ]
	location = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name
}

# Create Web Subnet
resource "azurerm_subnet" "web-subnet" {
	name = var.websubnet_name
	resource_group_name = azurerm_resource_group.rg.name
	virtual_network_name = azurerm_virtual_network.vnet.name
	address_prefixes = [ var.websubnet_cidr ]
}

# Create App Subnet
resource "azurerm_subnet" "app-subnet" {
	name = var.appsubnet_name
	resource_group_name = azurerm_resource_group.rg.name
	virtual_network_name = azurerm_virtual_network.vnet.name
	address_prefixes = [ var.appsubnet_cidr ]
}

# Create DB Subnet
resource "azurerm_subnet" "db-subnet" {
	name = var.dbsubnet_name
	resource_group_name = azurerm_resource_group.rg.name
	virtual_network_name = azurerm_virtual_network.vnet.name
	address_prefixes = [ var.dbsubnet_cidr ]
}