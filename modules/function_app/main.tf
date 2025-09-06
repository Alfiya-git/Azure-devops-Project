resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "plan" {
  name                = "${var.name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
#  kind                = "Linux"
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_function_app" "function" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  version                    = "~4"

site_config {
    linux_fx_version = "Python|3.11"
  }

  app_settings = merge(var.app_settings, {
    "AzureWebJobsStorage"       = azurerm_storage_account.storage.primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME"  = "python"
  })
}

output "function_url" {
  value = azurerm_function_app.function.default_hostname
}
