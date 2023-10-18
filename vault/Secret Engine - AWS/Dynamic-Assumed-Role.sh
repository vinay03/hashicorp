#!/bin/bash

# First complete initial setup steps given in ./setup.sh
source ./setup.sh

# Write configurations for access key and secret key
vault write aws/roles/s3_access \
	role_arns=arn:aws:iam::00367432126:role/vault-role-bucket-access \
	credential_type=assumed_role

# Assume the given role
vault write aws/sts/s3_access -ttl=60m
