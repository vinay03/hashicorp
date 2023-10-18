## Vault - Hashicorp


### Installation

```
unzip vault.zip
mv ./vault /usr/local/bin
sudo useradd -M vault
export VAULT_ADDR=http://127.0.0.1:8200
```


```
cp vault.service /lib/systemd/system/vault.service
cp vault.hcl /etc/vault.d/vault.hcl
sudo systemctl start vault
```