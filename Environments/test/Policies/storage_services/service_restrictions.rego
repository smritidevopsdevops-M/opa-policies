package storage_services.trusted_services

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    rule := sa.change.after.network_rules[_]

    rule.bypass[_] == "AzureServices"

    msg := sprintf(
        "FAIL: Storage Account %v must not allow Trusted Microsoft Services bypass",
        [sa.name]
    )
}