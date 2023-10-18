#!/bin/bash

# Creates kv-v2 secret engine on kv-v2/ path
vault secrets enable kv-v2

# Creates kv-v2 on training-v2/ path
vault secrets enable -path=training-v2 -version=v2 kv

# Creates kv-v2 on kvv2/ path
vault secrets enable -path=kvv2 kv-v2

# Upgrade kv secret engine instance to kv-v2
vault kv enable -path=training kv
vault kv enable-versioning training/

vault secrets list -detailed
# In options column from the output, map[version:2] means version 2


# Write values
vault kv put kvv2/apps/circleci admin=password

# overwrite values
vault kv put kvv2/apps/circleci admin=password123

# Get values
vault kv get kvv2/apps/circleci

# get older version values
vault kv get -version=1 kvv2/apps/circleci

# delete data
vault kv delete kvv2/apps/circleci

# un-delete data, version stay at 2
vault kv undelete -versions=2 kvv2/apps/circleci

# Destroy data permanently for a specific version
vault kv destroy -versions=1 kvv2/apps/circleci

# Destroy data and metadata permanently
vault kv metadata delete kvv2/apps/circleci

# try to get destroyed version. It will return metadata but not the actual data
vault kv get -versions=1 kvv2/apps/circleci

# get metadata of all versions
vault kv metadata get kvv2/apps/circleci

# Set custom metadata and fetch it
vault kv metadata put -custom-metadata=abc=123 kvv2/apps/cirleci
vault kv get kvv2/apps/circleci
vault kv get -format=json kvv2/apps/circleci | jq -r '.data.metadata.custom_metadata'

# Policy to access these kv-v2
echo > policy.hcl
path "kvv2/data/apps/db" {
	capabilities = ["read"]
}
path "kvv2/metadata/apps/db" {
	capabilities = ["create", "read", "update"]
}
