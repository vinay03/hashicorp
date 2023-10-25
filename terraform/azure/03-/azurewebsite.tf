# resource "azurerm_linux_web_app" "fe-webapp" {
#   name                = "myapp"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   service_plan_id     = azurerm_service_plan.fe-asp
#   https_only          = true

#   site_config {
#     minimum_tls_version = "1.2"
#   }
#   depends_on = [
#     azurerm_service_plan.fe-asp
#   ]
# }
