terraform {
    cloud {
    organization = "Devops-ulsc-iac"

    workspaces {
      name = "opa-policies"
    }
    }
}
  # backend "azurerm" {
  #   resource_group_name  = "rg-tfstate"
  #   storage_account_name = "tfstatebackendss001"
  #   container_name       = "tfstate"
  #   key                  = "softdelete.tfstate"
  # }
