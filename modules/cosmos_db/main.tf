resource "azurerm_cosmosdb_account" "this" {
  name                = var.account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

#  capabilities {
#	name = "EnableMultipleWriteLocations"
#}

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  dynamic "geo_location" {
    for_each = var.geo_locations
    content {
      location          = geo_location.value
      failover_priority = 1
    }
  }

#  enable_automatic_failover = true
}

#output "endpoint" {
#  value = azurerm_cosmosdb_account.this.endpoint
#}
#output "primary_key" {
#  value     = azurerm_cosmosdb_account.this.primary_master_key
#  sensitive = true
#}
#output "primary_key" {
#  value = azurerm_cosmosdb_account.this.primary_master_key
#}

output "endpoint" {
  value = azurerm_cosmosdb_account.this.endpoint
}
