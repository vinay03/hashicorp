#!/bin/bash

# Enable
vault secrets enable pki

# Tune it to 7600 Hours
vault secrets tune -max-lease-ttl=07600h pki

# Create certificate
vault write -field=certificate pki/root/generate/internal \
	common_name="vaultadvanced.com" \
	ttl=07600h > ca_cert.crt

vault write pki/config/urls \
	issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
	crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"

# use a new pki instance to create CSR
vault secrets enable -path=pki_int -description="Intermediate" pki

# TUne it for 43800 Hours
vault secrets tune -max-lease-ttl=43800h pki_int

# Create CSR
vault write -format=json pki_int/intermediate/generate/internal \
	common_name="vaultadvanced.com Intermediate Authority" \
	| jq -r '.data.csr' > pki_intermediate.csr

# Sign the CSR
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
	format=pem_bundle ttl="43800h" | jq -r '.data.certificate' > intermediate.cert.pem

# set the signed certificate
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem

# create role
vault write pki_int/role/vaultadvanced \
	allowed_domains="vaultadvanced.com" allow_subdomain=true \
	max_ttl="720h"

# check new role
vault list pki_int/roles

# Get role details
vault read pki_int/roles/vaultadvanced

# Generate certificate #1
vault write pki_int/issue/vaultadvanced common_name="learn.vaultadvanced.com" ttl="24h"

vault write pki_int/issue/vaultadvanced common_name="atm.vaultadvanced.com" ttl="24h"