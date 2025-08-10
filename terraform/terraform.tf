terraform {

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Project-terraform0503"
    workspaces {
      name = "Infra-state"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  
  features {}
}