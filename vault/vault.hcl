storage "file" {
  path = "/var/lib/vault-data"
}
listener "tcp" {
	address = "0.0.0.0:8200"
	cluster_address = "0.0.0.0:8200"
	tls_disable = "true"
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = " http://127.0.0.1:8201"
cluster_name = "vault-prod-us-east-1"
ui = true
log_level = "TRACE"
disable_mlock=true
