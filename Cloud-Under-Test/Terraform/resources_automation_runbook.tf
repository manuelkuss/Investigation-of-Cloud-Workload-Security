# --------------------------------------------------------------------
#  Automation Account for Runbooks
# --------------------------------------------------------------------

# -- Automation Account

resource "azurerm_automation_account" "account" {
  name                = var.runbook_automation_account_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "Basic"
}
