# Azure Blob Storage Control:
# Allowed Protocols for SAS = HTTPS only

package storage_services.sas_https_only
import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    sa.change.after.sas_policy[0].allowed_protocols != "HTTPS"

    msg := sprintf(
        "FAIL: Storage Account %v must allow SAS tokens over HTTPS only",
        [sa.name]
    )
}