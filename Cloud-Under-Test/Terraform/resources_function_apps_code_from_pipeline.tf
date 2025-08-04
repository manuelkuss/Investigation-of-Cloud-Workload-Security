# --------------------------------------------------------------------
#  Function app (function code from storage blob)
# --------------------------------------------------------------------

# -- Storage Account for Function App

resource "azurerm_storage_account" "staccforfunctionapp" {
  name                     = "${var.art_test_prefix}stacc2"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false # configuration settings to disable public access enablement
}


# -- Service Plan

# Note: azurerm_app_service_plan is deprecated

resource "azurerm_service_plan" "plan" {
  name                = "${var.art_test_prefix}-f-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "Y1"  # Consumption plan
}

# -- Application Insights
resource "azurerm_application_insights" "finsights" {
  name                = "${var.art_test_prefix}-f-insights"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  # workspace_id        = var.la_workspace_id
  application_type    = "web"
}

# -- Function App

resource "azurerm_linux_function_app" "function" {
  name                = "${var.art_test_prefix}-f-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.staccforfunctionapp.name
  storage_account_access_key = azurerm_storage_account.staccforfunctionapp.primary_access_key
  functions_extension_version = "~4"
  https_only = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      python_version = "3.11"
    }
    cors {
      allowed_origins = ["https://portal.azure.com"]  # allow azure portal to talk to the function
      support_credentials = true
    }
    application_insights_key = azurerm_application_insights.finsights.instrumentation_key
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    AzureWebJobsFeatureFlags    = "EnableWorkerIndexing"
  }
}

# -- Enable Diagnostics for Function App

data "azurerm_monitor_diagnostic_categories" "function_app_logs" {
  resource_id = azurerm_linux_function_app.function.id
}

resource "azurerm_monitor_diagnostic_setting" "function_app_diagnostics" {
  name                       = "${var.art_test_prefix}_FunctionAppDiagnostics"
  target_resource_id         = azurerm_linux_function_app.function.id
  log_analytics_workspace_id = var.la_workspace_id

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.function_app_logs.log_category_types
    content {
      category = entry.value
    }
  }

  metric {
    category = "AllMetrics"
  }
}


# -- Enable Diagnostics for Service Plan

data "azurerm_monitor_diagnostic_categories" "service_plan_logs" {
  resource_id = azurerm_service_plan.plan.id
}

resource "azurerm_monitor_diagnostic_setting" "service_plan_diagnostics" {
  name                       = "${var.art_test_prefix}_FunctionAppServicePlanDiagnostics"
  target_resource_id         = azurerm_service_plan.plan.id
  log_analytics_workspace_id = var.la_workspace_id

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.service_plan_logs.log_category_types
    content {
      category = entry.value
    }
  }

  metric {
    category = "AllMetrics"
  }
}


# -- Enable Diagnostics for Storage Account and its data storage objects

data "azurerm_monitor_diagnostic_categories" "storage_logs" {
  resource_id = azurerm_storage_account.staccforfunctionapp.id
}

resource "azurerm_monitor_diagnostic_setting" "function_storage_diagnostics" {
  name                       = "${var.art_test_prefix}_Storage2Diagnostics"
  target_resource_id         = azurerm_storage_account.staccforfunctionapp.id
  log_analytics_workspace_id = var.la_workspace_id 

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.storage_logs.log_category_types
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

