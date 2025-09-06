resource "azurerm_application_insights" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

output "ikey" {
  value     = azurerm_application_insights.this.instrumentation_key
  sensitive = true
}
