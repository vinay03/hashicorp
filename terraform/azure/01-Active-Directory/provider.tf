terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
    }
  }
}

provider "azuread" {

  # NOTE: Environment Variables can also be used for Service Principal authentication
  # Terraform also supports authenticating via the Azure CLI too.
  # See official docs for more info: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs

  # client_id     = "..."
  # client_secret = "..."
  tenant_id     = var.tenant_id
}


