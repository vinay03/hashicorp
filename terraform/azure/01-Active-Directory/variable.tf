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