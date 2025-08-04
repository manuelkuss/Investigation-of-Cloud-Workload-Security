    terraform {
      required_providers {
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "4.11.0"
        }
      }
    }
    
# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none"
  tenant_id                  = "your_tenant_id"
  subscription_id            = "your_subscription_id"
  features {

    # -- key vault
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    # --
  }
}