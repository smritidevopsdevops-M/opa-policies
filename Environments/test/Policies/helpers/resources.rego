package helpers.resources

#for storage account
storage_accounts contains sa if {
    some i

    sa := input.resource_changes[i]

    sa.type == "azurerm_storage_account"
}

#for management lock
management_locks contains lock if {
    some i

    lock := input.resource_changes[i]

    lock.type == "azurerm_management_lock"
}

#for private endpoint
private_endpoints contains pe if {
    some i
    pe := input.resource_changes[i]
    pe.type == "azurerm_private_endpoint"
}

#for diagnostic setting 
diagnostic_settings contains ds if {
    some i
    ds := input.resource_changes[i]
    ds.type == "azurerm_monitor_diagnostic_setting"
}