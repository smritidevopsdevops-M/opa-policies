package storage_services.shared_key_access

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    sa.change.after.shared_access_key_enabled

    msg := sprintf(
        "FAIL: Storage Account %v must disable Shared Key Access",
        [sa.name]
    )
}