package storage_services.public_network_access

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    sa.change.after.public_network_access_enabled

    msg := sprintf(
        "FAIL: Storage Account %v must disable public network access",
        [sa.name]
    )
}