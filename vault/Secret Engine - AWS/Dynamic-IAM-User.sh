#!/bin/bash

# First complete initial setup steps given in ./setup.sh
source ./setup.sh

# Write configurations for creating dynamic user
vault write aws/roles/vaultadvanced \
	policy_arns=arn:aws:iam::aws:policy/ReadOnlyAccess \
	credential_type=iam_user

# Create Dynamic user
vault read aws/creds/vaultadvanced

# Revoke / Delete the Dynamic User using Lease ID
vault lease revoke aws/creds/vaultadvanced/xqHWjBHXTTXqwYdugOo1sIZK