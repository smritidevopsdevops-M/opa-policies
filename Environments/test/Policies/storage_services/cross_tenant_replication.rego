package storage_services.cross_tenant_replication

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    sa.change.after.cross_tenant_replication_enabled

    msg := sprintf(
        "FAIL: Storage Account %v must disable Cross Tenant Replication",
        [sa.name]
    )
}