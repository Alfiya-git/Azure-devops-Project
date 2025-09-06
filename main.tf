# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "demo-${var.env}-rg"
  location = var.location_primary
}

# Cosmos DB
module "cosmos" {
  source              = "./modules/cosmos_db"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  account_name        = "democosmos${var.env}"
  geo_locations       = [var.location_secondary]
}

# App Insights
module "ai" {
  source              = "./modules/app_insights"
  name                = "demo-ai-${var.env}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Function App
module "func" {
  source               = "./modules/function_app"
  name                 = "demo-func-${var.env}"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_name = "demofuncsa${var.environment}"
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = module.ai.ikey
    "COSMOS_ENDPOINT"                = module.cosmos.endpoint
  }
}

# RBAC
module "rbac" {
  source     = "./modules/rbac"
  scope      = azurerm_resource_group.rg.id
  admins     = var.admin_ids
  developers = var.developer_ids
}

# Outputs
output "function_url" {
  value = module.func.function_url
}
output "cosmos_endpoint" {
  value = module.cosmos.endpoint
}
