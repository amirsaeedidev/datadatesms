// Wire names ARE the frozen persisted contract (Phase 02) — snake_case
// identifiers are deliberate and must never be "fixed" by a rename.
// ignore_for_file: constant_identifier_names

/// Type of a FINANCIAL audit event — core logging enum.
///
/// THE FINANCIAL TRAIL (contract locked in Phase 02): the complete,
/// tamper-evident story of money moving through the system — from
/// the moment a bank SMS lands until the record's standing settles
/// and the backend acknowledges it. Complements the technical
/// LogEvent (core/logging): the two systems are disjoint and never
/// overlap (same contract documented on LogEvent).
///
/// PRODUCED by: the pipeline usecases (Phase 06), parser engine
/// (Phase 07), transaction usecases (Phase 08), SyncEngine (Phase
/// 10) and review usecases (Phase 11). AuditLogger (Phase 04) is the
/// single writer; this enum is only the vocabulary.
///
/// NAMING — the master roadmap names coarse UPPER_SNAKE events
/// (TRANSACTION_SENT, TRANSACTION_FAILED). They are deliberately
/// refined here into stage-precise events, because a vague "failed"
/// is useless in a financial trail — the stage that failed IS the
/// information. Mapping (documented once, here):
///   TRANSACTION_SENT      → sync_success | sync_duplicate_confirmed
///   TRANSACTION_FAILED    → parse_failed | validation_failed |
///                           sync_failed  (whichever stage failed)
///   TRANSACTION_RECEIVED  → sms_received
/// All other roadmap names map 1:1. Wire names are lowercase
/// snake_case — consistent with every other wire contract in this
/// codebase; rename never.
///
/// ANCHOR AVAILABILITY (consumed by AuditEvent): events before
/// record creation anchor on the SMS (smsId + hash); from
/// `transaction_created` onward the transactionId exists and is the
/// primary anchor. The doc line of each event states its anchor.
///
/// CATEGORIES: [category] groups events for the audit screen's facet
/// filter (Phase 12) — derived data on the enum, so the UI never
/// hardcodes lists (same pattern as LogLevel.severity).
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
enum AuditEventType {
  // ---------------------------------------------------------------------
  // Ingestion (Phase 06) — anchored on SMS
  // ---------------------------------------------------------------------

  /// A bank SMS was received and stored locally with its hash.
  /// Anchor: smsId. (Roadmap: TRANSACTION_RECEIVED.)
  sms_received('sms_received', AuditEventCategory.ingestion),

  /// Message intentionally skipped — no (enabled) bank detected, or
  /// bank disabled. A normal outcome, recorded for completeness of
  /// the trail. Anchor: smsId.
  sms_ignored('sms_ignored', AuditEventCategory.ingestion),

  /// The SAME message arrived again (bodyHash already seen) —
  /// ingestion-level duplicate; distinct from
  /// transaction_deduplicated (different messages yielding what
  /// would be the same RECORD). Anchor: smsId; the earlier message's
  /// id rides in metadata.
  sms_duplicate('sms_duplicate', AuditEventCategory.ingestion),

  // ---------------------------------------------------------------------
  // Parsing (Phase 07) — anchored on SMS
  // ---------------------------------------------------------------------

  /// Parse succeeded; a ParsedTransaction was produced. Anchor:
  /// smsId; parserVersion + confidence in metadata.
  /// (Roadmap: TRANSACTION_PARSED.)
  transaction_parsed('transaction_parsed', AuditEventCategory.parsing),

  /// Parse failed (required field missing / validation config
  /// failed) or no parser is configured for the bank. Anchor:
  /// smsId; failure reason wire name in metadata.
  parse_failed('parse_failed', AuditEventCategory.parsing),

  // ---------------------------------------------------------------------
  // Pipeline (Phase 08)
  // ---------------------------------------------------------------------

  /// Validation passed; proceeding to the dedup check. Anchor:
  /// smsId. (Roadmap: TRANSACTION_VALIDATED.)
  transaction_validated('transaction_validated', AuditEventCategory.pipeline),

  /// Validation rejected the parsed data — no record will be
  /// created; the message is marked failed. Anchor: smsId;
  /// which-rule-failed detail in metadata.
  validation_failed('validation_failed', AuditEventCategory.pipeline),

  /// Dedup engine blocked a SECOND record (dedupKey collision from
  /// distinct messages); the blocked message is marked duplicate.
  /// Anchor: smsId; the existing record's id in metadata.
  /// (Roadmap: TRANSACTION_DEDUPLICATED.)
  transaction_deduplicated(
      'transaction_deduplicated', AuditEventCategory.pipeline),

  /// THE record's birth: validation + dedup passed, the Transaction
  /// was created locally as pending. Anchor: transactionId (primary),
  /// smsId also present. From this event on, transactionId exists.
  transaction_created('transaction_created', AuditEventCategory.pipeline),

  /// The record was enqueued for sync (queue entry created).
  /// Anchor: transactionId; queue item id in metadata.
  /// (Roadmap: TRANSACTION_QUEUED.)
  transaction_queued('transaction_queued', AuditEventCategory.pipeline),

  // ---------------------------------------------------------------------
  // Sync (Phase 10)
  // ---------------------------------------------------------------------

  /// A sync-engine run started draining the queue.
  /// (Roadmap: SYNC_STARTED.) Context event — anchored on deviceId.
  sync_started('sync_started', AuditEventCategory.sync),

  /// Backend ACCEPTED an entry — success. This is the send-outcome
  /// event (Roadmap: TRANSACTION_SENT / SYNC_SUCCESS). Anchor:
  /// transactionId; serverTransactionId in metadata. If the
  /// acceptance also mutates the record's standing to confirmed, the
  /// handler additionally emits transaction_confirmed.
  sync_success('sync_success', AuditEventCategory.sync),

  /// Backend answered 409 duplicate — accepted-as-success (idempotent
  /// duplicate confirmed). Anchor: transactionId.
  sync_duplicate_confirmed(
      'sync_duplicate_confirmed', AuditEventCategory.sync),

  /// An attempt failed — retryable (returns to queue with backoff)
  /// or permanent (entry failed). The failureClass wire name rides in
  /// metadata. (Roadmap: SYNC_FAILED / TRANSACTION_FAILED at the
  /// send stage.) Anchor: transactionId; attempt number in metadata.
  sync_failed('sync_failed', AuditEventCategory.sync),

  // ---------------------------------------------------------------------
  // Matching (matching feature phase)
  // ---------------------------------------------------------------------

  /// The matching engine routed a record to MANUAL REVIEW (ambiguous
  /// — never a random pick). Anchor: transactionId; the competing
  /// candidates' ids in metadata. (Roadmap: TRANSACTION_AMBIGUOUS.)
  transaction_ambiguous('transaction_ambiguous', AuditEventCategory.matching),

  /// An approved match linked a record to its expected payment; the
  /// PendingTransaction becomes fulfilled (side effect of this same
  /// event — pendingId in metadata). Anchor: transactionId.
  /// (Roadmap: TRANSACTION_MATCHED.)
  transaction_matched('transaction_matched', AuditEventCategory.matching),

  // ---------------------------------------------------------------------
  // Review / standing (Phase 11)
  // ---------------------------------------------------------------------

  /// Standing mutated to confirmed — by admin review, or by the
  /// sync-acceptance handler (whichever usecase performs the
  /// mutation emits this). Anchor: transactionId.
  transaction_confirmed('transaction_confirmed', AuditEventCategory.review),

  /// Admin voided the record (standing → rejected): excluded from
  /// matching eligibility and reports; row retained. Anchor:
  /// transactionId; reviewer identity in metadata.
  /// (Roadmap: TRANSACTION_REJECTED.)
  transaction_rejected('transaction_rejected', AuditEventCategory.review);

  const AuditEventType(this.wireName, this.category);

  /// Stable wire/serialization name — persisted in the local DB and
  /// consumed by the data-layer mapper. Never rename existing values.
  final String wireName;

  /// Facet group for the audit screen's filter — derived data, so
  /// the UI never hardcodes event lists.
  final AuditEventCategory category;

  /// Parses a serialized event type coming from local storage or the
  /// data layer.
  ///
  /// STRICT — returns `null` for unknown values instead of a
  /// fallback (persisted-vocabulary policy, same as the status
  /// enums): an unrecognized audit event written by a NEWER app
  /// version must surface and be logged by the mapper — never
  /// silently remapped. A wrong remap here corrupts the FINANCIAL
  /// trail: it would claim money did (or did not) move.
  static AuditEventType? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final AuditEventType type in AuditEventType.values) {
      if (type.wireName == name) {
        return type;
      }
    }
    return null;
  }
}

/// Facet grouping of audit events — consumed by the audit screen's
/// filter chips (Phase 12). Wire names are outbound-only (display
/// grouping may evolve); no fromName needed.
enum AuditEventCategory {
  /// SMS-level ingestion events.
  ingestion('ingestion'),

  /// Parser outcomes.
  parsing('parsing'),

  /// Validate → dedup → create → queue.
  pipeline('pipeline'),

  /// Matching outcomes.
  matching('matching'),

  /// Admin/standing decisions.
  review('review'),

  /// Transmission to the backend.
  sync('sync');

  const AuditEventCategory(this.wireName);

  /// Stable outbound name for logs/UI grouping — never rename.
  final String wireName;
}