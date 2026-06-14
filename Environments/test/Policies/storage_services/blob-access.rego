package storage_services.anonymous_access
import data.helpers.resources

deny contains msg if {
    sa := resources.storage_accounts[_]
    sa.change.after != null
    sa.change.after.allow_nested_items_to_be_public
    msg := sprintf(
        "FAIL: Storage Account %v must disable anonymous blob public access",
        [sa.name]
    )
}

# Only defined when violations exist — safe to use with --fail-defined
violations := deny if {
    count(deny) > 0
}