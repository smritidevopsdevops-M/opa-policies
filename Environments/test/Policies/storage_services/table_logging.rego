package storage_services.table_logging

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.table_properties[0].logging.read

    msg := sprintf(
        "FAIL: Storage Account %v must enable Table Read Logging",
        [sa.name]
    )
}

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.table_properties[0].logging.write

    msg := sprintf(
        "FAIL: Storage Account %v must enable Table Write Logging",
        [sa.name]
    )
}

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.table_properties[0].logging.delete

    msg := sprintf(
        "FAIL: Storage Account %v must enable Table Delete Logging",
        [sa.name]
    )
}

deny contains msg if {
    sa := resources.storage_accounts[_]

    sa.change.after.table_properties[0].logging.retention_policy_days < 7

    msg := sprintf(
        "FAIL: Storage Account %v must retain Table logs for at least 7 days",
        [sa.name]
    )
}