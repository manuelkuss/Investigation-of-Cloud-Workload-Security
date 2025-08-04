# -- Resource group

resource "azurerm_resource_group" "rg" {
  name     = "${var.art_test_prefix}rg"
  location = var.location
}
