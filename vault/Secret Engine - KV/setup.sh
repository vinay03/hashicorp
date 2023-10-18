#!/bin/bash

# Creates kv secret engine on kv/ path
vault secrets enable kv

# Creates kv on training/ path
vault secrets enable -path=training kv

# In options column from the output, map[] means version 1
vault secrets list -detailed

# Write a vault to training/app/db
vault kv put training/app/db pass=123

# Get the values from training/app/db
vault kv get training/app/db

# Get value in JSON format
v kv get -format=json training/app/db | jq '.data.data'

# list of configs
vault kv list training/app

# deletes the config at training/app/db
vault kv delete training/app/db


# Policy to access these kv-v2
echo > policy.hcl
path "kvv2/apps/db" {
	capabilities = ["create", "read", "update"]
}