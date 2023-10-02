terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.60.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  backend "azurerm" {
    resource_group_name = "spiral-rg"
    storage_account_name = "spiral"
    container_name = "terraform-state"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}

# resource "random_pet" "pet" {
#   length    = 1
#   separator = ""
# }

resource "azurerm_resource_group" "resume-group" {
  name     = var.rg-name
  location = var.rg-location
  tags     = local.common-tags
}