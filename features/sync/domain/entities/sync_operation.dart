/// Type of write operation a queue entry carries — sync domain enum.
///
/// Vocabulary for the `operation` column of sync_queue (contract
/// locked in Phase 02).
///
/// SEMANTICS — deliberately UPSERT-ONLY for local-origin mutations:
///  - [create]  — upsert of a locally-originated record to the
///    backend (e.g. a new Transaction: the backend creates it
///    idempotently keyed by our local id — see Phase 09 contract).
///  - [update]  — upsert of a LOCAL standing mutation (e.g. an
///    approved match setting a PendingTransaction to `fulfilled`,
///    or an admin confirming a Transaction). We send the ENTIRE
///    record — the backend is the source of truth for merge and
///    last-write-wins on overlapping fields is the backend's call.
///    The operation is idempotent by [SyncQueueItem.id], so retries
///    never double-apply.
///
/// NO [delete] value — deliberate: this product has no local-origin
/// delete flow. Records are retained for audit (rejected
/// transactions stay, cancelled pendings stay). Backend-originated
/// deletes arrive through the realtime/downsync path as full-row
/// refreshes, not as queue operations. Adding `delete` later, if a
/// real need emerges, is a non-breaking enum addition.
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
enum SyncOperation {
  /// Upsert of a locally-originated record to the backend.
  create('create'),

  /// Upsert of a local standing mutation — the whole record is
  /// sent; the backend merges as the source of truth.
  update('update');

  const SyncOperation(this.wireName);

  /// Stable wire/serialization name — persisted in the local DB
  /// (`sync_queue.operation`) and consumed by the data-layer mapper.
  /// Never rename existing values.
  final String wireName;

  /// Parses a serialized operation coming from local storage or the
  /// data layer.
  ///
  /// STRICT — returns `null` for unknown values instead of a
  /// fallback (standing-enum policy, same as SmsProcessingStatus /
  /// TransactionStatus): a queue entry with an unknown operation
  /// cannot be executed safely — it must be surfaced and logged by
  /// the mapper, never guessed. A wrong guess would replay a
  /// mutation as the WRONG kind of write against the backend.
  static SyncOperation? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final SyncOperation operation in SyncOperation.values) {
      if (operation.wireName == name) {
        return operation;
      }
    }
    return null;
  }
}