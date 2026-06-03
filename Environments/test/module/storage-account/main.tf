# resource "azurerm_storage_account" "this" {
#   name                = var.storage_account_name
#   resource_group_name = var.resource_group_name
#   location            = var.location

#   account_tier             = "Standard"
#   account_replication_type = var.replication_type

#   https_traffic_only_enabled = var.enable_https_traffic_only
#   min_tls_version            = var.min_tls_version
#   allow_nested_items_to_be_public = var.allow_blob_public_access

#   blob_properties {

#     versioning_enabled = var.enable_versioning
#     change_feed_enabled = var.enable_change_feed

#     delete_retention_policy {
#       days = var.soft_delete_days
#     }

#     container_delete_retention_policy {
#       days = var.container_delete_days
#     }
#   }

#   tags = {
#     environment = "test"
#     critical    = var.is_critical ? "true" : "false"
#   }
# }

resource "azurerm_storage_account" "storage_account" {
  name                              = var.name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = var.account_tier
  https_traffic_only_enabled        = var.https_traffic_only_enabled
  account_kind                      = var.account_kind
  account_replication_type          = var.account_replication_type
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  access_tier                       = var.access_tier
  min_tls_version                   = var.min_tls_version
  public_network_access_enabled     = var.public_network_access_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  nfsv3_enabled                     = var.nfsv3_enabled
  local_user_enabled                = var.local_user_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  allowed_copy_scope                = var.allowed_copy_scope
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  is_hns_enabled                    = var.is_hns_enabled
  tags                              = var.tags

  dynamic "immutability_policy" {
    for_each = var.immutability_policy != null ? [var.immutability_policy] : []
    content {
      state                         = immutability_policy.value.state
      allow_protected_append_writes = immutability_policy.value.allow_protected_append_writes
      period_since_creation_in_days = immutability_policy.value.period_since_creation_in_days
    }
  }


  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids

      dynamic "private_link_access" {
        for_each = var.private_link_access != null ? [var.private_link_access] : []
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
        }
      }
    }
  }
}