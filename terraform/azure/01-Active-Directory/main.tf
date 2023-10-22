resource "azuread_group" "groups" {
	for_each = toset(var.groups)
	display_name = "${var.environment}-${each.value}"
	security_enabled = false
}

resource "azuread_user" "db_users" {
	for_each = toset(var.db_users)
	user_principal_name = "${each.value}@${local.domain}"
	display_name = "${var.environment}-${each.value}"
	force_password_change = true
}

resource "azuread_group_member" "db_users_membership" {
	group_object_id = azuread_group.groups["db_users"].object_id
	for_each = azuread_user.db_users
	member_object_id = each.value.object_id
}

# To fetch Domain name
data "azuread_domains" "aad_domains" {
	only_initial = true
}

locals  {
	domain = data.azuread_domains.aad_domains.domains[0].domain_name
}

# Fetch Authenticating User
data "azuread_client_config" "current" {}
output "current" {
	value = data.azuread_client_config.current
}
