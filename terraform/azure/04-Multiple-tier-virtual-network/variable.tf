variable "division" { }
variable "environment" { }
variable "rg_name" { }
variable "rg_location" { }

variable "vnet_name" { }
variable "vnet_address_space" { 
	type = list(string)
}

variable "web_subnet_name" { }
variable "web_subnet_address" { 
	type = list(string)
}

variable "app_subnet_name" { }
variable "app_subnet_address" { 
	type = list(string)
}

variable "db_subnet_name" { }
variable "db_subnet_address" { 
	type = list(string)
}

variable "bastion_subnet_name" { }
variable "bastion_subnet_address" { 
	type = list(string)
}