# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}


variable "admin_username" {
    type = string
    description = "Administrator user name for virtual machine"
}

variable "admin_password" {
    type = string
    description = "Password must meet Azure complexity requirements"
}


