location             = "Central India"
resource_group_name  = "rg-softdelete-dev"
storage_account_name = "softdeletebenchsa01"
container_name       = "benchmark-container"

# soft_delete_days      = 1
# container_delete_days = 7

# enable_https_traffic_only = false
# min_tls_version           = "TLS1_0"
# allow_blob_public_access  = true

# enable_versioning = false
# enable_change_feed = true

# replication_type = "LRS"
# is_critical      = true
# =========================================================
# Storage Account Basic Configuration
# =========================================================

account_tier             = "Standard"
account_kind             = "StorageV2"
account_replication_type = "LRS"
access_tier              = "Hot"

# =========================================================
# Security & Network
# =========================================================

https_traffic_only_enabled       = true
public_network_access_enabled    = true
cross_tenant_replication_enabled = false

min_tls_version = "TLS1_2"

default_to_oauth_authentication   = true
infrastructure_encryption_enabled = false
shared_access_key_enabled         = true

allowed_copy_scope = "AAD"

# =========================================================
# Data Lake / HNS / NFS
# =========================================================

is_hns_enabled     = false
nfsv3_enabled      = false
local_user_enabled = false

# =========================================================
# Public Access
# =========================================================

allow_nested_items_to_be_public = false

# =========================================================
# Tags
# =========================================================

tags = {
  environment = "dev"
  project     = "storage-account"
  owner       = "terraform"
}

# =========================================================
# Immutability Policy
# =========================================================

immutability_policy = null

# Example:
# immutability_policy = {
#   state                         = "Unlocked"
#   allow_protected_append_writes = true
#   period_since_creation_in_days = 30
# }

# =========================================================
# Network Rules
# =========================================================

network_rules = {
  default_action = "Deny"

  bypass = [
    "AzureServices"
  ]

  ip_rules = [
    "103.21.244.0/22"
  ]

  virtual_network_subnet_ids = []
}

# =========================================================
# Private Link Access
# =========================================================

private_link_access = null

# Example:
# private_link_access = {
#   endpoint_resource_id = "/subscriptions/xxxx/resourceGroups/rg/providers/Microsoft.Storage/storageAccounts/test"
#   endpoint_tenant_id   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
# }

# =========================================================
# Blob Properties
# =========================================================

blob_properties = {

  versioning_enabled            = true
  change_feed_enabled           = true
  change_feed_retention_in_days = 7

  default_service_version  = "2020-06-12"
  last_access_time_enabled = true

  delete_retention_policy = {
    days                     = 7
    permanent_delete_enabled = false
  }

  container_delete_retention_policy = {
    days = 7
  }

  # restore_policy works only when:
  # versioning_enabled = true
  # change_feed_enabled = true
  # delete_retention_policy exists
  # permanent_delete_enabled = false

  restore_policy = {
    days = 7
  }
}