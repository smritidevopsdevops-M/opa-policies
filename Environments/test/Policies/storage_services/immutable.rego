#Immutability Enabled

package storage_services.immutable
import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.immutability_policy.enabled

    msg := sprintf(
        "FAIL: Storage Account %v must enable immutability protection",
        [sa.name]
    )
}
