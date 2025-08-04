# --------------------------------------------------------------------
#  Storage account with objects
# --------------------------------------------------------------------

# -- Storage account

resource "azurerm_storage_account" "storage_account_test_resources" {
    name                     = "${var.art_test_prefix}stacc1"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

# -- Container and Blob
# https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/storage_blob

resource "azurerm_storage_container" "container" {
  name                  = "${var.art_test_prefix}container"
  storage_account_id  = azurerm_storage_account.storage_account_test_resources.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "blob1" {
  name                   = "test_terraform_zippedReadmeFile.zip"
  storage_account_name   = azurerm_storage_account.storage_account_test_resources.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source                 = "${var.files_for_pipeline_path}test_terraform_zippedReadmeFile.zip"
}

# -- Container and Blob with public access enabled

resource "azurerm_storage_container" "container2" {
  name                  = "${var.art_test_prefix}container2"
  storage_account_id  = azurerm_storage_account.storage_account_test_resources.id
  container_access_type = "container"   # "blob" enables anonymous read access on single Clobs, "container" enables read access to Container and Blobs
}

resource "azurerm_storage_blob" "blob2" {
  name                   = "testFile2.txt"
  storage_account_name   = azurerm_storage_account.storage_account_test_resources.name
  storage_container_name = azurerm_storage_container.container2.name
  type                   = "Block"
  source_content         = "This is a sample test file for unauthorized blob read demonstration."
}


# -- File share
# https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/storage_share_file

resource "azurerm_storage_share" "file_share" {
  name                 = "${var.art_test_prefix}fileshare"
  storage_account_id = azurerm_storage_account.storage_account_test_resources.id
  quota                = 1     # The maximum size of the share, in gigabytes.
}

resource "azurerm_storage_share_directory" "file_share_directory" {
  name                 = "${var.art_test_prefix}directory"
  storage_share_id = azurerm_storage_share.file_share.url # storage_share_id seems to mismatch. url works (see: https://github.com/hashicorp/terraform-provider-azurerm/issues/28032)
}

resource "azurerm_storage_share_file" "file" {
  name             = "testFile.txt"
  storage_share_id = azurerm_storage_share.file_share.url # storage_share_id seems to mismatch. url works (see: https://github.com/hashicorp/terraform-provider-azurerm/issues/28032)
  path              = azurerm_storage_share_directory.file_share_directory.name
  source            = "${var.files_for_pipeline_path}testFile.txt"
}

# -- Table
# https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/storage_table_entity

resource "azurerm_storage_table" "table" {
    name                 = "${var.art_test_prefix}table"
    storage_account_name = azurerm_storage_account.storage_account_test_resources.name
}

resource "azurerm_storage_table_entity" "table_entity" {
  storage_table_id = azurerm_storage_table.table.id

  partition_key = "${var.art_test_prefix}partition"
  row_key       = "examplerow"

  entity = {
    example = "example"
  }
}

# -- Queue
# https://registry.terraform.io/providers/hashicorp/azurerm/4.11.0/docs/resources/storage_queue

 resource "azurerm_storage_queue" "queue" {
  name                 = "${var.art_test_prefix}queue"
  storage_account_name = azurerm_storage_account.storage_account_test_resources.name
}


# -- Enable Diagnostics for Storage Account and its data storage objects

data "azurerm_monitor_diagnostic_categories" "storage_logs_test_resources" {
  resource_id = azurerm_storage_account.storage_account_test_resources.id
}

resource "azurerm_monitor_diagnostic_setting" "test_storage_diagnostics" {
  name                       = "${var.art_test_prefix}_Storage1Diagnostics"
  target_resource_id         = azurerm_storage_account.storage_account_test_resources.id
  log_analytics_workspace_id = var.la_workspace_id

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_logs_test_resources.log_category_types
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
