variable "region" {
	type = string
	description = "AWS Region to create resources"
}

variable "app_name" {
	type = string
	description = "Name of the App"
}

variable "environment" {
	type = string
	description = "ID for the environment type"

	validation {
		condition = contains([ "prod", "dev",], var.environment)
		error_message = "Environment value is not valid."
	}
}