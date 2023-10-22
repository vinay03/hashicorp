variable "tenant_id" {
	default = "9556b588-ec0a-4ab0-bb65-ce6d3b244b59"
}

variable "environment" {
	default = "dev"
}

variable "groups" {
	type = list(string)
	default = [ "db_users", "lambda_users" ]
}

variable "db_users" {
	type = list(string)
	default = [ "db_auth_user", "db_log_user" ]
}

variable "lambda_users" {
	type = list(string)
	default = [ "lambda_net_user", "lambda_api_user" ]
}