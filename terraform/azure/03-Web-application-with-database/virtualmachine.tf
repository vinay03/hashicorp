resource "azurerm_availability_set" "web-availability-set" {
	name = "web_availability_set"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location
	platform_fault_domain_count = 2
}

resource "azurerm_network_interface" "web-net-interface" {
	name = "web_network"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location
	ip_configuration {
		name = "web-webserver"
		subnet_id = azurerm_subnet.web-subnet.id
		private_ip_address_allocation = "Dynamic"
	}
}

resource "azurerm_virtual_machine" "web-vm" {
	name = "web-vm"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location
	network_interface_ids = [
		azurerm_network_interface.web-net-interface.id
	]
	availability_set_id = azurerm_availability_set.web-availability-set.id
	vm_size = var.web_vm_size
	delete_os_disk_on_termination = true

	storage_image_reference {
		publisher = "Canonical"
		offer = "UbuntuServer"
		sku = "18.04-LTS"
		version = "latest"
	}
	storage_os_disk {
		name = "web-disk"
		caching = "ReadWrite"
		create_option = "FromImage"
		managed_disk_type = "Standard_LRS"
	}
	os_profile {
    computer_name  = var.web_hostname
    admin_username = var.web_username
    admin_password = var.web_password
  }
	os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_availability_set" "app-availability-set" {
	name = "app-availability-set"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location
	platform_fault_domain_count = 2
}

resource "azurerm_network_interface" "app-network-interface" {
	name = "app-network-interface"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location
	ip_configuration {
		name = "app-webserver"
		subnet_id = azurerm_subnet.app-subnet.id
		private_ip_address_allocation = "Dynamic"
	}
}

resource "azurerm_virtual_machine" "app-vm" {
	name = "app-vm"
	resource_group_name = azurerm_resource_group.rg.name
	location = azurerm_resource_group.rg.location
	network_interface_ids = [
		azurerm_network_interface.app-network-interface.id
	]
	availability_set_id = azurerm_availability_set.app-availability-set.id
	vm_size = var.app_vm_size

	storage_image_reference {
		publisher = "Canonical"
		offer     = "UbuntuServer"
		sku       = "18.04-LTS"
		version   = "latest"
	}
	storage_os_disk {
		name = "app-disk"
		caching = "ReadWrite"
		create_option = "FromImage"
		managed_disk_type = "Standard_LRS"		
	}

	os_profile {
		computer_name = var.app_hostname
		admin_username = var.app_username
		admin_password = var.app_password
	}
	os_profile_linux_config {
		disable_password_authentication = false
	}
}

