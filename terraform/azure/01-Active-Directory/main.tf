# Retrieve domain information
data "azuread_client_config" "current" {}

resource "azuread_application" "web_api" {
  display_name = "terraform-admin"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "web_api" {
  application_id               = azuread_application.web_api.application_id
  app_role_assignment_required = false
  owners                       = [
		data.azuread_client_config.current.object_id,
		data.azuread_user.owner.object_id
	]
}

data "azuread_user" "owner" {
	user_principal_name = "vjeurkar03_hotmail.com#EXT#@vjeurkar03hotmail.onmicrosoft.com"
}

# # Create a user
# resource "azuread_user" "example" {
#   user_principal_name = "ExampleUser@${data.azuread_domains.example.domains.0.domain_name}"
#   display_name        = "Example User"
#   password            = "..."
# }