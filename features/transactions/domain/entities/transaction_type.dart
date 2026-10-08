/// Canonical transaction-type vocabulary — transactions domain enum.
///
/// SHARED VOCABULARY (contract locked in Phase 02): the single source
/// of truth for the type of a financial movement, consumed by:
///  - parser       — KeywordClassifier emits it onto
///                   ParsedTransaction (Phase 07); an ambiguous
///                   classification resolves to [unknown] together
///                   with a warning (see
///                   ParserConfidenceWarningKind.ambiguousTransactionType).
///  - transactions — Transaction / PendingTransaction carry it as a
///                   field (Step 02.5).
///  - matching     — TransactionTypeMatcher compares expected vs
///                   parsed type.
///  - API DTO      — serialized as `transaction_type` (Phase 09).
///
/// It lives in the transactions domain (not parser) because the
/// Transaction entity OWNS the financial semantics; parser is a
/// consumer. This keeps the cross-feature dependency direction
/// `parser/entities → transactions/entities` one-way and acyclic.
///
/// CLASSIFICATION RULE (no guessing — RULE-009 spirit): when bank
/// SMS keywords match CONFLICTING types or nothing conclusive, the
/// classifier MUST emit [unknown] — never a random pick. `unknown`
/// is a first-class, legitimate classification result, not an error.
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
enum TransactionType {
  /// Money IN — e.g. 'واریز', 'واریز شد' deposit notifications.
  deposit('deposit'),

  /// Money OUT via cash/ATM — e.g. 'برداشت', 'برداشت وجه'.
  withdrawal('withdrawal'),

  /// Account-to-account / card-to-card movement — e.g. 'انتقال',
  /// 'کارت به کارت'. Direction (in/out) is NOT implied by the type
  /// alone; the message text decides it.
  transfer('transfer'),

  /// Payment / purchase — e.g. 'خرید', 'پرداخت' (POS / internet).
  purchase('purchase'),

  /// Classification failed or ambiguous. A legitimate terminal
  /// classification result — NOT an error state.
  unknown('unknown');

  const TransactionType(this.wireName);

  /// Stable wire/serialization name — persisted in the local DB,
  /// sent as `"transaction_type"` in the API payload, and used as
  /// the canonical target values of parser keyword `valueMap`
  /// configs. Never rename existing values.
  final String wireName;

  /// Parses a serialized type name coming from local storage, API
  /// responses, or parser validation configs.
  ///
  /// LENIENT BY DESIGN — unlike the strict null-returning contracts
  /// (SmsProcessingStatus, ParserRuleField, ...), an unrecognized
  /// value falls back to [TransactionType.unknown]:
  ///  - `unknown` is an explicit member meaning "classification
  ///    failed", so remapping unrecognized data to it loses NO
  ///    financial truth (amount / references / bank stay intact) —
  ///    whereas remapping to a wrong CONCRETE type (e.g.
  ///    `withdrawal`) would corrupt the financial direction.
  ///  - A type written by a NEWER app version (e.g. 'bill_payment'
  ///    someday) degrades to `unknown` on older versions — honest,
  ///    not corrupting.
  ///  - Wire names appear inside ADMIN parser configs (valueMap
  ///    targets); a typo there must degrade to `unknown` + a
  ///    validation warning, never crash the pipeline.
  ///
  /// Adding new enum values in later phases is therefore
  /// non-breaking for both storage and wire.
  static TransactionType fromName(
    String? name, {
    TransactionType fallback = TransactionType.unknown,
  }) {
    if (name == null) {
      return fallback;
    }
    for (final TransactionType type in TransactionType.values) {
      if (type.wireName == name) {
        return type;
      }
    }
    return fallback;
  }
}