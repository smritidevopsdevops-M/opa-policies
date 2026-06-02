#retention

package storage_services.retention
import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    sa.change.after.blob_properties.delete_retention_policy.days < 7

    msg := sprintf(
        "FAIL: Soft delete retention is %v days, must be at least 7",
        [sa.change.after.blob_properties.delete_retention_policy.days]
    )
}