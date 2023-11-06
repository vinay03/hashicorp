locals {
	resource_name_prefix = "${app_name}-${var.environment}"
	common_tags = {
		"app" = var.app_name
		"env" = var.environment
	}
}