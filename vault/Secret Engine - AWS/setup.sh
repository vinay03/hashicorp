#!/bin/bash

vault secrets enable aws

vault write aws/config/root \
	access_key=actual_access_key \
	secret_key=actual_secret_key \
	region=us-east-1

# check if the keys are set. Secret key will not appear due to security.
vault read aws/config/root

# To rotate the defualt access key and secret key for security purpose.
vault write -f aws/config/rotate-root

# You will find a new Access key and secret key
vault read aws/config/root


