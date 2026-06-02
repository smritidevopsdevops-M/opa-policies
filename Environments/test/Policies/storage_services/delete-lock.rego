# Require Delete Lock

package storage_services.delete_lock
import data.helpers.resources

deny contains msg if {
    lock := resources.management_locks[_]

    lock.change.after.lock_level != "CanNotDelete"

    msg := sprintf(
        "FAIL: Resource %v must have CanNotDelete lock enabled",
        [lock.name]
    )
}