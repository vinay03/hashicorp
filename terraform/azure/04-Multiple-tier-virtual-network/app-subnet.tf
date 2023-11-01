# App Tier Subnet
resource "azurerm_subnet" "app_subnet" {
	name = "${local.resource_name_prefix}-${var.app_subnet_name}"
	resource_group_name = azurerm_resource_group.rg.name
	virtual_network_name = azurerm_virtual_network.vnet.name
	address_prefixes = var.app_subnet_address
}

# Network Security Group (NSG) for App Tier Subnet
resource "azurerm_network_security_group" "app_subnet_nsg" {
	name = "${azurerm_subnet.app_subnet.name}-nsg"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location
}

# Connect NSG to App Subnet
resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_connection" {
	subnet_id = azurerm_subnet.app_subnet.id
	network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id
	depends_on = [ 

	 ]
}

# NSG Rules Data
locals {
	app_inbound_ports_map = {
		"100": "80",
		"110": "443",
		"120": "8080",
		"130": "22",
	}
}

## NSG Inbound Rule for App Tier Subnet
resource "azurerm_network_security_rule" "app_nsg_rule_inbound" {
  for_each = local.app_inbound_ports_map
	name = "Rule-Port-${each.value}"
	priority = each.key
	direction = "Inbound"
	access = "Allow"
	protocol = "Tcp"
	source_port_range = "*"
	destination_port_range = each.value
	source_address_prefix = "*"
	destination_address_prefix = "*"
	resource_group_name = azurerm_resource_group.rg.name
	network_security_group_name = azurerm_network_security_group.app_subnet_nsg.name
}