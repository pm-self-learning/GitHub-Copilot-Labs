output "storage_account_id" {
  description = "Resource ID of the Storage Account."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Name of the Storage Account."
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob endpoint URL; access still requires authorization and network connectivity."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
