terraform {
  required_version = ">= 1.9, < 2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.50.0"
    }
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}

module "storage" {
  source = "../../modules/azure-storage"

  name                = "stplatformlab001"
  resource_group_name = "rg-platform-existing"
  location            = "eastus"
  container_name      = "application-data"

  tags = {
    Environment = "Development"
    Owner       = "platform-team"
    Project     = "copilot-workshop"
  }
}

output "storage_account_id" {
  description = "Resource ID returned by the module."
  value       = module.storage.storage_account_id
}

output "storage_account_name" {
  description = "Storage Account name returned by the module."
  value       = module.storage.storage_account_name
}

output "primary_blob_endpoint" {
  description = "Blob endpoint returned by the module."
  value       = module.storage.primary_blob_endpoint
}
