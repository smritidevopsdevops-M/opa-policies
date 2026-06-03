package storage_services.private_endpoint

import data.helpers.resources

deny contains msg if {
    count(resources.private_endpoints) == 0

    msg := "FAIL: Storage Account must use Private Endpoint"
}