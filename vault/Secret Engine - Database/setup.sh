#!/bin/bash

vault write database/config/prod-database \
	plugin_name=mysql-aurora-database-plugin \
	connection_url="{{username}}{{password}}@tcp(prod.cluster.us-east-1.rds.amazonaws.com:3306)/" \
	allowed_roles="app-integration, app-lambda" \
	username="vault-admin" \
	password="vneJ2389sdjhfs9834jks"

vault read database/creds/aurora-reporting

# Rotate root credentials for database
vault write -force mysql/rotate-root/mysql-database

# Create new dynamic credentials for database
vault read mysql/creds/advanced

# Revoke a specific lease
vault lease revoke mysql/creds/advanced/aQsdfjhkos89dsjd89

# Revoke multiple leases at once by giving prefix.
vault lease revoke -prefix=mysql/creds/advanced