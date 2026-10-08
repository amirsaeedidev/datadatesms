/// Lifecycle status of a bank-transaction RECORD — transactions
/// domain enum.
///
/// WHAT THIS IS (contract locked in Phase 02): the STANDING of the
/// record as financial evidence — persisted on `transactions.status`
/// and displayed as the "Status" column on the transactions screens.
///
/// WHAT THIS IS NOT — the three-way separation, locked here so no
/// phase ever conflates them:
///  ┌─────────────────┬──────────────────────────────────┬──────────────────┐
///  │ TransactionStatus│ record standing as evidence      │ transactions     │
///  │ SyncStatus       │ transmission to backend          │ sync_queue (sync)│
///  │ MatchStatus      │ matching outcome vs orders       │ matching_records │
///  └─────────────────┴──────────────────────────────────┴──────────────────┘
/// All three appear INDEPENDENTLY on the transaction detail screen
/// ("Status" + "Sync Status" + match outcome) — per the UI contract.
/// A record can be `confirmed` while its latest sync retry is still
/// in flight, or `pending` while already synced; neither implies the
/// other.
///
/// STATE MACHINE (transitions are OWNED by UseCases in Phases
/// 08/10/11 — this enum is vocabulary + documentation only):
///
/// ```text
///   Phase 08 create (validation + dedup PASSED)
///              ↓
///         ┌─────────┐  admin reject (Phase 11 review)
///         │ pending │ ────────────────────────────→ rejected
///         └────┬────┘
///              │ backend ACCEPTS (Phase 10 SyncEngine — the
///              │ server-of-record acknowledgment)
///              │ OR admin confirm (Phase 11 review)
///              ↓
///         ┌──────────┐   admin void (rare, audited)
///         │ confirmed│ ────────────────────────────→ rejected
///         └──────────┘
/// ```
///
/// CREATION INVARIANT: a Transaction is created ONLY as [pending] —
/// after Phase 08 validation and deduplication passed. Records for
/// failed parses or duplicates never exist (the SmsMessage carries
/// `failed`/`duplicate` instead) — so this enum deliberately has NO
/// error values.
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
enum TransactionStatus {
  /// CREATED & LIVE — the record exists as valid financial evidence
  /// (validation + dedup passed) and is awaiting confirmation.
  pending('pending'),

  /// VERIFIED — the server of record has acknowledged the record
  /// (set by SyncEngine on backend acceptance), or an admin has
  /// confirmed it through review. The record's financial truth is
  /// settled.
  confirmed('confirmed'),

  /// VOIDED BY ADMIN — the record is excluded from matching
  /// eligibility and from financial reports/dashboards. The row is
  /// RETAINED (audit trail); rejection itself is recorded in the
  /// audit log. Never set automatically — admin action only.
  rejected('rejected');

  const TransactionStatus(this.wireName);

  /// Stable wire/serialization name — persisted in the local DB
  /// (`transactions.status`) and consumed by the data-layer mapper.
  /// Never rename existing values.
  final String wireName;

  /// Parses a serialized status name coming from local storage or
  /// the data layer.
  ///
  /// STRICT — returns `null` for unknown values instead of a
  /// fallback (same policy as SmsProcessingStatus):
  ///  - A persisted status written by a NEWER app version must be
  ///    surfaced and logged by the mapper — never silently remapped,
  ///    because a WRONG standing silently misreports financial
  ///    outcomes (e.g. `rejected` data would still count toward
  ///    reports; a fake `confirmed` would fake settled money).
  ///  - Contrast with the lenient contracts (TransactionType /
  ///    Currency): those degrade to a safe member that loses no
  ///    financial truth; here every wrong value IS financial truth
  ///    corruption.
  ///
  /// Adding new enum values in later phases stays non-breaking for
  /// both storage and wire.
  static TransactionStatus? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final TransactionStatus status in TransactionStatus.values) {
      if (status.wireName == name) {
        return status;
      }
    }
    return null;
  }
}