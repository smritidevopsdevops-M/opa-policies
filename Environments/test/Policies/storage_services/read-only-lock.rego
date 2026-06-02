# Require readonly Lock

package storage_services.read_only_lock
import data.helpers.resources

deny contains msg if {
    lock := resources.management_locks[_]

    lock.change.after.lock_level != "ReadOnly"

    msg := sprintf(
        "FAIL: Resource %v must have ReadOnly lock enabled",
        [lock.name]
    )
}