terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
    }
  }
}

provider "azuread" {
  tenant_id     = var.tenant_id
}


