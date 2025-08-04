# --------------------------------------------------------------------
#  Virtual machine
# --------------------------------------------------------------------

# -- Storage Account for boot diagnostics for VM

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "bootdiag_storage_account" {
  name                     = "${var.art_test_prefix}diag"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false # configuration settings to disable public access enablement
}

# -- Network Interface

resource "azurerm_network_interface" "nic" {
  name                = "nic-vm-test-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = "your_subnet_id"
    private_ip_address_allocation = "Dynamic"
  }
}

# -- Virtual machine (non-encrypted)

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.art_test_prefix}-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  storage_os_disk {
    name              = "${var.art_test_prefix}-vm-test-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vm-test-01"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# -- Enable Diagnostics for Storage Account and its data storage objects

data "azurerm_monitor_diagnostic_categories" "bootdiag_storage_account_logs" {
  resource_id = azurerm_storage_account.bootdiag_storage_account.id
}

resource "azurerm_monitor_diagnostic_setting" "bootdiag_storage_account_diagnostics" {
  name                       = "${var.art_test_prefix}_bootdiag_storage_account_diagnostics"
  target_resource_id         = azurerm_storage_account.bootdiag_storage_account.id
  log_analytics_workspace_id = var.la_workspace_id

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.bootdiag_storage_account_logs.log_category_types
    content {
      category = entry.value
    }
  }

  metric { 
    category = "Transaction"
  }

  metric { 
    category = "Capacity"
  }
}
