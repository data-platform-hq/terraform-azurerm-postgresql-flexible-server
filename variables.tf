variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "suffix" {
  type        = string
  description = "PostgreSQL server name suffix"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}

variable "resource_group" {
  type        = string
  description = "Resource group name"
}

variable "storage_mb" {
  type        = number
  description = "Storage in MB"
  default     = 32768
  validation {
    condition = anytrue([
      var.storage_mb == 32768,
      var.storage_mb == 65536,
      var.storage_mb == 131072,
      var.storage_mb == 262144,
      var.storage_mb == 524288,
      var.storage_mb == 1048576,
      var.storage_mb == 2097152,
      var.storage_mb == 4194304,
      var.storage_mb == 8388608,
      var.storage_mb == 16777216,
    ])
    error_message = "The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, and 16777216."
  }
}

variable "zone" {
  type        = number
  description = "Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located"
  default     = 1
}


variable "administrator_login" {
  type        = string
  description = "The administrator login name for the PostgreSQL Flexible Server"
  default     = null
}

variable "administrator_password" {
  type        = string
  description = "The administrator password for the PostgreSQL Flexible Server"
  default     = null
}

variable "psql_version" {
  type        = string
  description = "The version of the PostgreSQL Flexible Server"
  default     = "12"
}

variable "sku_name" {
  type        = string
  description = "The SKU name for the PostgreSQL Flexible Server"
  default     = "GP_Standard_D4s_v3"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the virtual network subnet to create the PostgreSQL Flexible Server"
  default     = null
}

variable "zone_id" {
  type        = string
  description = "The ID of the private DNS zone to create the PostgreSQL Flexible Server"
  default     = null
}

variable "databases" {
  type = list(object({
    name      = string
    collation = string
    charset   = string
  }))
  description = "List of databases to create"
  default     = []
}

variable "ip_rules" {
  type        = map(string)
  description = "Map of IP addresses permitted for access to DB"
  default     = {}
}

variable "allow_azure_services" {
  type        = bool
  description = "Allow access from Azure services"
  default     = true
}

variable "analytics_workspace_id" {
  type        = string
  description = "Resource ID of Log Analytics Workspace"
  default     = null
}

variable "analytics_destination_type" {
  type        = string
  description = "Possible values are AzureDiagnostics and Dedicated."
  default     = "Dedicated"
}

variable "enable_diagnostic_setting" {
  type        = bool
  description = "Enable diagnostic setting. var.analytics_workspace_id must be provided"
  default     = false
}
