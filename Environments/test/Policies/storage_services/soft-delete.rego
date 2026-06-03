#Soft delete 

package storage_services.soft_delete
import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.blob_properties.delete_retention_policy.enabled

    msg := sprintf(
        "FAIL: Storage Account %v must enable soft delete",
        [sa.name]
    )
}

