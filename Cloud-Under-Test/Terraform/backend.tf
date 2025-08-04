terraform {
    backend "azurerm" {
            resource_group_name  = "rg-tfstate"
            storage_account_name = "statomictest2"
            container_name       = "terraform"
            key                  = "terraform.tfstate"
            use_azuread_auth     = true
            use_oidc             = true
        }
}