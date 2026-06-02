package storage_services.sas_expiry

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    count(sa.change.after.sas_policy) == 0

    msg := sprintf(
        "FAIL: Storage Account %v must configure a SAS expiry policy",
        [sa.name]
    )
}

deny contains msg if {
    sa := resources.storage_accounts[_]

    count(sa.change.after.sas_policy) > 0

    sa.change.after.sas_policy[0].expiration_period != "00.01:00:00"

    msg := sprintf(
        "FAIL: Storage Account %v must configure SAS expiry to 1 hour",
        [sa.name]
    )
}