# Create a Resource Group
resource "azurerm_resource_group" "rg" {
	name = "myapp-usecase"
	location = "southindia"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
	name = "myapp-vnet" 
	address_space = [ "10.0.0.0/16" ]
	location = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name
}

# Create Frontend Subnet
resource "azurerm_subnet" "fe-subnet" {
	name = "fe-subnet"
	resource_group_name = azurerm_resource_group.rg.name
	virtual_network_name = azurerm_virtual_network.vnet.name
	address_prefixes = [ "10.0.0.0/26" ]
	
	delegation {
		name = "delegation"

		service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = [
				"Microsoft.Network/virtualNetworks/subnets/action", 
				"Microsoft.Network/virtualNetworks/subnets/join/action", 
				"Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
			]
    }
	}
}

# Create Backend Subnet
resource "azurerm_subnet" "be-subnet" {
	name = "fe-subnet"
	resource_group_name = azurerm_resource_group.rg.name
	virtual_network_name = azurerm_virtual_network.vnet.name
	address_prefixes = [ "10.0.0.64/26" ]
	service_endpoints = ["Microsoft.Sql"]

	delegation {
		name = "delegation"

		service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = [
				"Microsoft.Network/virtualNetworks/subnets/action", 
				"Microsoft.Network/virtualNetworks/subnets/join/action", 
				"Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
			]
    }
	}
}