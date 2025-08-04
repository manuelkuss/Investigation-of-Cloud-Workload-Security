variable "agent_vm_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "admin_username" { 
    type = string
    sensitive = true
    }
variable "admin_password" {
  type      = string
  sensitive = true
}
variable "vm_size" { type = string }
variable "art_test_prefix" { type = string }
variable "la_workspace_id" {
  type = string
}

# -- storage files

variable "files_for_pipeline_path" {
  type = string
}

# -- automation runbook

variable "runbook_resource_group" {
}

variable "runbook_name" {
}

variable "runbook_automation_account_name" {
}