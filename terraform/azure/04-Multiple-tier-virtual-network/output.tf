output "virtual_network_name" {
	description = "Virtual Network Name"
	value = azurerm_virtual_network.vnet.name
}

output "virtual_network_id" {
	description = "Virtual Network ID"
	value = azurerm_virtual_network.vnet.id
}

output "web_subnet_name" {
	description = "Web Tier Subnet Name"
	value = azurerm_subnet.websubnet.name
}
output "web_subnet_id" {
	description = "Web Tier Subnet Name"
	value = azurerm_subnet.websubnet.id
}
output "web_subnet_nsg_name" {
	description = "WebTier Subnet NSG Name"
	value = azurerm_network_security_group.web_subnet_nsg.name
}

output "web_subnet_nsg_id" {
  description = "WebTier Subnet NSG ID"
  value = azurerm_network_security_group.web_subnet_nsg.id
}