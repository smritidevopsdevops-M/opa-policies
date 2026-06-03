#Secure Transfer Required

package storage_services.encryption
import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.https_traffic_only_enabled

    msg := sprintf(
        "FAIL: Storage Account %v must enable Secure Transfer (HTTPS only)",
        [sa.name]
    )
}

deny contains msg if {
    sa := resources.storage_accounts[_]

    sa.change.after.min_tls_version != "TLS1_2"

    msg := sprintf(
        "FAIL: Storage Account %v must use TLS 1.2",
        [sa.name]
    )
}

deny contains msg if {
    sa := resources.storage_accounts[_]

    not sa.change.after.blob_properties.versioning_enabled

    msg := sprintf(
        "FAIL: Storage Account %v must enable Blob Versioning",
        [sa.name]
    )
}