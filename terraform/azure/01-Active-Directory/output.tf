# Filter newly created group names
locals {
	new_groups = toset([for each in azuread_group.groups: each.display_name])
	new_db_users = toset([for each in azuread_user.db_users: each.display_name])
}
output "new_groups" {
	value = local.new_groups
}
output "db_users" {
	value = local.new_db_users
}
