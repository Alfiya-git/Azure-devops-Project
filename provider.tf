terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "azurerm" {
  features {}
#  Subscription ID = 56d4d75f-c25c-4231-8013-10a1d4ffd86f
  subscription_id = "56d4d75f-c25c-4231-8013-10a1d4ffd86f"
}
