module "resource_group" {
  source = "./module/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "storage_account" {
  source = "./module/storage-account"

  # Basic Configuration
  name                = var.storage_account_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  # Storage Account Settings
  account_tier                     = var.account_tier
  account_kind                     = var.account_kind
  account_replication_type         = var.account_replication_type
  access_tier                      = var.access_tier
  min_tls_version                  = var.min_tls_version
  https_traffic_only_enabled       = var.https_traffic_only_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled

  # Authentication & Security
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  allowed_copy_scope                = var.allowed_copy_scope

  # Data Lake / NFS
  is_hns_enabled     = var.is_hns_enabled
  nfsv3_enabled      = var.nfsv3_enabled
  local_user_enabled = var.local_user_enabled

  # Public Access
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public

  # Tags
  tags = var.tags

  # Immutability Policy
  immutability_policy = var.immutability_policy

  # Network Rules
  network_rules = var.network_rules

  # Private Link Access
  private_link_access = var.private_link_access

  # Blob Properties
  blob_properties = var.blob_properties
}
# module "storage_account" {
#   source = "./module/storage-account"

#   storage_account_name = var.storage_account_name
#   resource_group_name  = module.resource_group.resource_group_name
#   location             = module.resource_group.location

#   soft_delete_days     = var.soft_delete_days
#   container_delete_days = var.container_delete_days

#   enable_https_traffic_only = var.enable_https_traffic_only
#   min_tls_version           = var.min_tls_version
#   allow_blob_public_access  = var.allow_blob_public_access

#   enable_versioning = var.enable_versioning
#   enable_change_feed = var.enable_change_feed

#   replication_type = var.replication_type
#   is_critical      = var.is_critical
# }

module "blob_containers" {
  source         = "./module/blob-container"
  container_name = var.container_name
  #storage_account_id = module.storage_account.storage_account_id
  storage_account_name = module.storage_account.storage_account_name
  depends_on = [ module.storage_account ]
}

