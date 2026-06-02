# Geo-Redundant Storage for Critical Accounts

package storage_services.critical_account

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    lower(sa.change.after.tags.critical) == "true"

    not valid_replication(sa.change.after.account_replication_type)

    msg := sprintf(
        "FAIL: Critical Storage Account %v must use GRS, GZRS, RAGRS, or RAGZRS replication",
        [sa.name]
    )
}

valid_replication(replication) if {
    replication == "GRS"
}

valid_replication(replication) if {
    replication == "GZRS"
}

valid_replication(replication) if {
    replication == "RAGRS"
}

valid_replication(replication) if {
    replication == "RAGZRS"
}