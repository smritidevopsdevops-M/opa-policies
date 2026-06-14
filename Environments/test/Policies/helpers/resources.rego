package helpers.resources

# For storage account - only created/updated resources
storage_accounts contains sa if {
    some i
    sa := input.resource_changes[i]
    sa.type == "azurerm_storage_account"
    sa.change.actions[_] != "delete"        # ← exclude deletions
    sa.change.after != null                  # ← ensure after state exists
}

# For management lock
management_locks contains lock if {
    some i
    lock := input.resource_changes[i]
    lock.type == "azurerm_management_lock"
    lock.change.actions[_] != "delete"
    lock.change.after != null
}

# For private endpoint
private_endpoints contains pe if {
    some i
    pe := input.resource_changes[i]
    pe.type == "azurerm_private_endpoint"
    pe.change.actions[_] != "delete"
    pe.change.after != null
}

# For diagnostic setting
diagnostic_settings contains ds if {
    some i
    ds := input.resource_changes[i]
    ds.type == "azurerm_monitor_diagnostic_setting"
    ds.change.actions[_] != "delete"
    ds.change.after != null
}