package storage_services.key_rotation

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    count(sa.change.after.customer_managed_key) == 0

    msg := sprintf(
        "FAIL: Storage Account %v must use Customer Managed Keys",
        [sa.name]
    )
}