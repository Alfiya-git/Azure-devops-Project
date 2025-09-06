terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.0.0"
    }
  }
  required_version = ">=1.4.0"
}

# Provider block is OUTSIDE the terraform block
provider "azurerm" {
  features {}
  subscription_id = "56d4d75f-c25c-4231-8013-10a1d4ffd86f"
  tenant_id       = "fa16a8a9-67c5-4803-91be-fde8b3f47250"
  client_id       = "de279121-afb9-43ac-ab0d-578c94304497"
}

resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate-rg"
  location = "West US"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_id.suffix.hex}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}
