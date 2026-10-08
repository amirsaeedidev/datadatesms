/// Lifecycle state of an SMS message inside the ingestion pipeline —
/// sms domain enum.
///
/// State machine (contract locked in Phase 02; transitions are driven
/// by ReceiveSmsUseCase / ProcessIncomingSmsUseCase in Phase 06):
///
/// ```text
///            ┌──────────┐
///   ingest → │ received │  stored locally, hash computed, awaiting
///            └────┬─────┘  processing
///                 ↓
///            ┌───────────┐
///            │ processing │  in-flight (crash recovery re-queues
///            └────┬──────┘  messages stuck here on app restart)
///        ┌────────┼─────────┬──────────┐
///        ↓        ↓         ↓          ↓
///   ┌──────────┐ ┌────────┐ ┌───────┐ ┌───────┐
///   │ processed │ │duplicate│ │ignored│ │failed │
///   └──────────┘ └────────┘ └───────┘ └───────┘
///   transaction   dedup hit,  not bank-  error during
///   created       no second   related or  processing;
///                 transaction bank off    see technical log
/// ```
///
/// SEMANTICS:
///  - [processed]  → a Transaction was created (success path).
///  - [duplicate]  → same logical message seen before; NO second
///                   financial record (dedup contract, Phase 08).
///  - [ignored]    → NORMAL skip: unknown sender, bank disabled, or
///                   promotional noise. Not an error condition.
///  - [failed]     → something went wrong (parser/validation error).
///                   Transaction NOT created; reason is in technical
///                   logs — the status itself stays coarse.
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
enum SmsProcessingStatus {
  /// Stored locally, awaiting processing. Initial state.
  received('received'),

  /// Currently in the processing pipeline. A message stuck here
  /// after a crash is re-queued on app restart (offline-first).
  processing('processing'),

  /// TERMINAL — successfully parsed into a Transaction.
  processed('processed'),

  /// TERMINAL — duplicate detection hit; no second Transaction.
  duplicate('duplicate'),

  /// TERMINAL — intentionally skipped (not bank-related / disabled).
  ignored('ignored'),

  /// TERMINAL — processing error; no Transaction; see logs.
  failed('failed');

  const SmsProcessingStatus(this.wireName);

  /// Stable wire/serialization name — persisted in the local DB and
  /// exchanged with the data layer. Never rename existing values.
  final String wireName;

  /// Whether this is a terminal state of the lifecycle — the message
  /// will not transition any further without manual reprocessing.
  bool get isTerminal => switch (this) {
        SmsProcessingStatus.received ||
        SmsProcessingStatus.processing => false,
        SmsProcessingStatus.processed ||
        SmsProcessingStatus.duplicate ||
        SmsProcessingStatus.ignored ||
        SmsProcessingStatus.failed => true,
      };

  /// Parses a serialized status name coming from local storage or
  /// the data layer.
  ///
  /// STRICT — returns `null` for unknown values instead of a
  /// fallback: an unrecognized persisted status means the state
  /// machine contract is broken (or data came from a newer version)
  /// and must be surfaced and logged by the mapper — never silently
  /// remapped, because a wrong status silently misreports financial
  /// processing outcomes.
  static SmsProcessingStatus? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final SmsProcessingStatus status in SmsProcessingStatus.values) {
      if (status.wireName == name) {
        return status;
      }
    }
    return null;
  }
}