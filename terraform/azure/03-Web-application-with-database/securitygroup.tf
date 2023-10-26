# For Web subnet
resource "azurerm_network_security_group" "web-nsg" {
	name = "web-nsg"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location

	security_rule {
		name = "ssh-rule-1"
		priority = 101
		direction = "Inbound"
		access = "Allow"
		protocol = "Tcp"
		source_address_prefix = "*"
		source_port_range = "*"
		destination_address_prefix = "*"
		destination_port_range = "22"
	}
	
	security_rule {
		name = "ssh-rule-2"
		priority = 100
		direction = "Inbound"
		access = "Deny"
		protocol = "Tcp"
		source_address_prefix = var.dbsubnet_cidr
		source_port_range = "*"
		destination_address_prefix = "*"
		destination_port_range = "22"
	}
}

resource "azurerm_subnet_network_security_group_association" "web-nsg-subnet" {
	subnet_id = azurerm_subnet.web-subnet.id
	network_security_group_id = azurerm_network_security_group.web-nsg.id
}

# For App subnet
resource "azurerm_network_security_group" "app-nsg" {
	name = "app-nsg"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location

	security_rule {
		name = "ssh-rule-1"
		priority = 100
		direction = "Inbound"
		access = "Allow"
		protocol = "Tcp"
		source_address_prefix = var.websubnet_cidr
		source_port_range = "*"
		destination_address_prefix = "*"
		destination_port_range = "22"
	}

	security_rule {
		name = "ssh-rule-2"
		priority = 101
		direction = "Outbound"
		access = "Allow"
		protocol = "Tcp"
		source_address_prefix = var.websubnet_cidr
		source_port_range = "*"
		destination_address_prefix = "*"
		destination_port_range = "22"
	}
}

resource "azurerm_subnet_network_security_group_association" "app-nsg-subnet" {
	subnet_id = azurerm_subnet.app-subnet.id
	network_security_group_id = azurerm_network_security_group.app-nsg.id
}

# For DB subnet
resource "azurerm_network_security_group" "db-nsg" {
	name = "db-nsg"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location

	security_rule {
		name = "ssh-rule-1"
		priority = 101
		direction = "Inbound"
		access = "Allow"
		protocol = "Tcp"
		source_address_prefix = var.appsubnet_cidr
		source_port_range = "*"
		destination_address_prefix = "*"
		destination_port_range = "3306"
	}

	security_rule {
		name = "ssh-rule-2"
		priority = 102
		direction = "Outbound"
		access = "Allow"
		protocol = "Tcp"
		source_address_prefix = var.appsubnet_cidr
		source_port_range = "*"
		destination_address_prefix = "*"
		destination_port_range = "3306"
	}

	security_rule {
		name = "ssh-rule-3"
		priority = 100
		direction = "Outbound"
		access = "Deny"
		protocol = "Tcp"
		source_address_prefix = var.websubnet_cidr
		source_port_range = "*"
		destination_address_prefix = "*"
		destination_port_range = "3306"
	}
}

resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet" {
	subnet_id = azurerm_subnet.db-subnet.id
	network_security_group_id = azurerm_network_security_group.db-nsg.id
}