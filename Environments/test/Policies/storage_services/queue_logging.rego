package storage_services.queue_logging

import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.queue_properties[0].logging.read

    msg := sprintf(
        "FAIL: Storage Account %v must enable Queue Read Logging",
        [sa.name]
    )
}

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.queue_properties[0].logging.write

    msg := sprintf(
        "FAIL: Storage Account %v must enable Queue Write Logging",
        [sa.name]
    )
}

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.queue_properties[0].logging.delete

    msg := sprintf(
        "FAIL: Storage Account %v must enable Queue Delete Logging",
        [sa.name]
    )
} 

# Queue Retention Policy
deny contains msg if {
    sa := resources.storage_accounts[_]

    sa.change.after.queue_properties[0].logging.retention_policy_days < 7

    msg := sprintf(
        "FAIL: Storage Account %v must retain Queue logs for at least 7 days",
        [sa.name]
    )
}