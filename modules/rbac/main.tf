# Admins → Owner role
resource "azurerm_role_assignment" "admins" {
  for_each = toset(var.admins)

  scope                = var.scope
  role_definition_name = "Owner"
  principal_id         = each.value
}

# Developers → Contributor role
resource "azurerm_role_assignment" "developers" {
  for_each = toset(var.developers)

  scope                = var.scope
  role_definition_name = "Contributor"
  principal_id         = each.value
}
