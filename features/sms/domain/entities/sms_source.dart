/// Provenance of an SMS message — sms domain enum.
///
/// Distinguishes HOW a message entered the local store:
///  - [broadcast] — real-time push from the native
///    SmsBroadcastReceiver (Phase 05). The primary, offline-first
///    ingestion path: works with no internet at all.
///  - [inbox] — backfill/recovery pull from the device inbox via the
///    native reader service (initial history sync, or messages that
///    arrived while the receiver was unavailable).
///
/// SEMANTICS:
///  - Source is PROVENANCE metadata, NOT identity: the same physical
///    message captured by both paths (e.g. receiver missed it, inbox
///    backfill catches it) deduplicates through body hash in Phase 08
///    regardless of its source value.
///  - Parser-test / simulation input (Phase 12) is NEVER persisted
///    as an SmsMessage — simulateParser only renders a result —
///    therefore no `manual`/`test` value exists in this contract.
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
enum SmsSource {
  /// Real-time receipt: SmsBroadcastReceiver → Flutter bridge →
  /// ReceiveSmsUseCase.
  broadcast('broadcast'),

  /// Backfilled from the device inbox by the native reader service —
  /// initial history sync or recovery of missed messages.
  inbox('inbox');

  const SmsSource(this.wireName);

  /// Stable wire/serialization name — persisted in the local DB
  /// (`sms_messages.source`) and consumed by the data-layer mapper.
  /// Never rename existing values.
  final String wireName;

  /// Parses a serialized source name coming from local storage.
  ///
  /// STRICT — returns `null` for unknown values (same policy as
  /// SmsProcessingStatus): persisted provenance written by a newer
  /// app version must be surfaced and logged by the data-layer
  /// mapper — never silently remapped.
  static SmsSource? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final SmsSource source in SmsSource.values) {
      if (source.wireName == name) {
        return source;
      }
    }
    return null;
  }
}