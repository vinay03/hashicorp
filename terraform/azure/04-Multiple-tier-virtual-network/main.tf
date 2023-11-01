locals {
	resource_name_prefix = "${var.division}-${var.environment}"
	common_tags = {
		owners = var.division
		environment = var.environment
	}
}

resource "azurerm_resource_group" "rg" {
	name = "${local.resource_name_prefix}-${var.rg_name}-${random_string.random-string.id}"
	location = var.rg_location
	tags = local.common_tags
}