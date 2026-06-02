# variable "location" { type = string}
# variable "resource_group_name" {type = string}
# variable "storage_account_name" {type = string}

# variable "soft_delete_days" {
#     type = number
#   default = 1
# }

# variable "container_delete_days" {
#     type = number
#   default = 1
# }

# # Security controls (REQUIRED for OPA policies)
# variable "enable_https_traffic_only" {
#   type    = bool
#  # default = true
# }

# variable "min_tls_version" {
#   type    = string
#   #default = "TLS1_2"
# }

# variable "allow_blob_public_access" {
#   type    = bool
#   #default = false
# }

# # Data protection
# variable "enable_versioning" {
#   type    = bool
#   #default = true
# }

# variable "enable_change_feed" {
#   type    = bool
#  # default = true
# }

# # Resiliency (used in OPA for critical storage)
# variable "replication_type" {
#   type    = string
#   default = "LRS" # OPA will enforce GRS/GZRS if critical=true
# }

# variable "is_critical" {
#   type    = bool
#  # default = false
# }

# # Governance (optional but useful)
# variable "lock_level" {
#   type    = string
#   default = "CanNotDelete" # or ReadOnly
# }

variable "name" {
  description = "The name of the storage account."
  type        = string

  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 24 && can(regex("^[a-z0-9]+$", var.name))
    error_message = "The storage account name must be between 3 and 24 characters long and can only contain lowercase letters and numbers."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "location" {
  description = "The location where the storage account will be created."
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account."
  type        = string

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = "The replication type of the storage account."
  type        = string

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS"], var.account_replication_type)
    error_message = "account_replication_type must be one of 'LRS', 'GRS', 'RAGRS', or 'ZRS'."
  }
}

variable "https_traffic_only_enabled" {
  description = "Boolean flag to enable HTTPS traffic only."
  type        = bool
  default     = true
}

variable "account_kind" {
  description = "The kind of storage account."
  type        = string
  default     = "StorageV2"

  validation {
    condition = contains(
      ["Storage", "StorageV2", "BlobStorage", "FileStorage", "BlockBlobStorage"],
      var.account_kind
    )
    error_message = "account_kind must be one of 'Storage', 'StorageV2', 'BlobStorage', 'FileStorage', or 'BlockBlobStorage'."
  }
}

variable "cross_tenant_replication_enabled" {
  description = "Should cross-tenant replication be enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "access_tier" {
  description = "The access tier for BlobStorage and StorageV2 accounts."
  type        = string
  default     = null
}

variable "min_tls_version" {
  description = "The minimum TLS version to be permitted on requests to storage."
  type        = string
  default     = "TLS1_2"

  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "min_tls_version must be one of 'TLS1_0', 'TLS1_1', or 'TLS1_2'."
  }
}

variable "public_network_access_enabled" {
  description = "Boolean flag to enable public network access."
  type        = bool
  default     = false
}
variable "default_to_oauth_authentication" {
  description = "Azure Active Directory authorization in the Azure Portal when accessing the Storage Account."
  type        = bool
  default     = true
}

variable "nfsv3_enabled" {
  description = "Boolean flag to enable NFSv3."
  type        = bool
  default     = false
}

variable "local_user_enabled" {
  description = "Boolean flag to enable/disable local user"
  type        = bool
  default     = false
}

variable "infrastructure_encryption_enabled" {
  description = "Boolean flag to enable infrastructure encryption."
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  type        = bool
  default     = false
}

variable "allowed_copy_scope" {
  description = "Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink."
  type        = string
  default     = "AAD"

  validation {
    condition     = contains(["AAD", "PrivateLink"], var.allowed_copy_scope)
    error_message = "allowed_copy_scope must be either 'AAD' or 'PrivateLink'."
  }
}
variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public."
  type        = bool
  default     = false
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Enter tags for the Storage account"
}

variable "immutability_policy" {
  description = "The immutability policy for the storage account."
  type = object({
    state                         = string
    allow_protected_append_writes = bool
    period_since_creation_in_days = number
  })
  default = null
}

variable "network_rules" {
  description = "The network rules for the storage account."
  type = object({
    default_action             = string
    bypass                     = optional(list(string))
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  default = null
}

variable "private_link_access" {
  description = "The private link access configuration for the storage account."
  type = object({
    endpoint_resource_id = string
    endpoint_tenant_id   = optional(string)
  })
  default = null
}
variable "blob_properties" {
  description = "A blob_properties block as defined below."

  type = object({
    delete_retention_policy = optional(object({
      days                     = optional(number, 7)
      permanent_delete_enabled = optional(bool, false)
    }), null)

    restore_policy = optional(object({
      days = number
    }), null)

    versioning_enabled            = optional(bool, false)
    change_feed_enabled           = optional(bool, false)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool, false)

    container_delete_retention_policy = optional(object({
      days = optional(number, 7)
    }), null)
  })

  default = null

  validation {
    condition = (
      try(var.blob_properties.restore_policy, null) == null || (
        try(var.blob_properties.versioning_enabled, false) == true &&
        try(var.blob_properties.change_feed_enabled, false) == true &&
        try(var.blob_properties.delete_retention_policy, null) != null &&
        try(var.blob_properties.delete_retention_policy.permanent_delete_enabled, false) == false
      )
    )

    error_message = "When restore_policy is enabled, versioning_enabled and change_feed_enabled must be true, delete_retention_policy must be configured, and permanent_delete_enabled must be false."
  }
}

variable "is_hns_enabled" {
  description = "Boolean flag to enable Hierarchical Namespace (Data Lake Storage Gen2)."
  type        = bool
  default     = false
}