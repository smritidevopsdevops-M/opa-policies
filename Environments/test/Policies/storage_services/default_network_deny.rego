package storage_services.default_network_deny

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    sa.change.after.network_rules.default_action != "Deny"

    msg := sprintf(
        "FAIL: Storage Account %v must set network default action to Deny",
        [sa.name]
    )
}