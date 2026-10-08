/// Lifecycle state of a sync-queue entry — sync domain enum.
///
/// State machine (contract locked in Phase 02; transitions are
/// OWNED by SyncEngine / queue-manager usecases in Phase 10 — this
/// enum is vocabulary + documentation only):
///
/// ```text
///             enqueue (Phase 08/11 mutations)
///                  ↓
///            ┌───────────┐   claim/lock (attempt starting)
///            │  pending  │ ──────────────┐
///            └───────────┘              ↓
///                                  ┌──────────┐
///            re-enqueue (retry     │ inFlight │
///            backoff expired)      └────┬─────┘
///                  ↑    crash recovery   │ outcome
///            ┌──────────┐  re-queues     │
///            │ pending  │←── stuck ones  │
///            └──────────┘               ↓
///        ┌─────────────┬──────────────┬─────────────┐
///        ↓             ↓              ↓             ↓
///   ┌─────────┐   ┌─────────┐   ┌──────────┐  ┌─────────┐
///   │ synced  │   │ failed  │   │ pending  │  │ failed  │
///   └─────────┘   └─────────┘   └──────────┘  └─────────┘
///   success /     permanent    retryable     unauthorized:
///   dup-confirmed error        → backoff      token dead —
///   (TERMINAL)    (TERMINAL,    re-enqueued    surfaced for
///                see error)    (NOT failed)   manual re-auth,
///                                              then retried
/// ```
///
/// THE IN-FLIGHT/PROCESSING SPLIT (why the middle state is called
/// `inFlight`, not `processing`): the queue manager CLAIMS an entry
/// (pending → inFlight) before the HTTP attempt so that concurrent
/// processing of the same entry is structurally prevented. If the
/// app dies mid-attempt, the entry is stuck `inFlight` — crash
/// recovery on app restart re-queues stuck entries back to pending
/// (a re-send is SAFE because operation-level idempotency is the
/// whole design of Phase 09). This mirrors the crash-recovery
/// contract of SmsProcessingStatus.processing.
///
/// OUTCOME CLASSIFICATION (see the SyncFailureClass doc below) is
/// aligned 1:1 with the Phase 09 API error mapping:
///  409 duplicate → synced   (idempotent duplicates are SUCCESS)
///  5xx / network → retryable backoff, NOT failed
///  401/403 dead token → surfaced (manual re-auth) then retried
///  4xx permanent → failed (TERMINAL, admin attention)
///
/// TERMINAL SET: `synced` and `failed`. A failed entry stays in the
/// queue table (audit + the sync screen's failed tab with manual
/// retry, Phase 12) — failed is NOT deleted.
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
enum SyncStatus {
  /// Waiting to be claimed. Entry created by enqueue usecases
  /// (Phase 08 pipeline, Phase 11 review mutations).
  pending('pending'),

  /// Claimed/locked by a sync attempt — the HTTP call is in
  /// progress (or was, when a crash struck). See the in-flight
  /// contract in the enum doc comment.
  inFlight('inFlight'),

  /// TERMINAL — backend acknowledged: success or
  /// idempotent-duplicate-confirmed. The entry is DONE; the queue
  /// row is retained (audit + history).
  synced('synced'),

  /// TERMINAL — permanent error (4xx-class): not retryable, needs
  /// admin attention. Retained in the table; visible on the sync
  /// screen's failed tab with manual retry. Never deleted.
  failed('failed');

  const SyncStatus(this.wireName);

  /// Stable wire/serialization name — persisted in the local DB
  /// (`sync_queue.status`) and consumed by the data-layer mapper.
  /// IMPORTANT: this wire value is a SINGLE WORD (not
  /// `in_flight`) — it is persisted forever; never rename existing
  /// values. (`processing` as a wire value was rejected: this
  /// middle state is a claim, not work-in-progress.)
  final String wireName;

  /// Whether this is a terminal state — the entry does not
  /// transition further (manual retry of a failed entry is a NEW
  /// attempt cycle, documented on the sync screen contract).
  bool get isTerminal => switch (this) {
        SyncStatus.pending || SyncStatus.inFlight => false,
        SyncStatus.synced || SyncStatus.failed => true,
      };

  /// Parses a serialized status coming from local storage or the
  /// data layer.
  ///
  /// STRICT — returns `null` for unknown values (standing-enum
  /// policy): a wrong persisted status silently misreports
  /// transmission outcomes (a fake `synced` would fake backend
  /// acknowledgment). Must be surfaced and logged by the mapper —
  /// never silently remapped.
  static SyncStatus? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final SyncStatus status in SyncStatus.values) {
      if (status.wireName == name) {
        return status;
      }
    }
    return null;
  }
}

/// Classification of a failed attempt outcome — how the sync layer
/// interprets an error response for retry decisions.
///
/// Aligned 1:1 with the Phase 09 API error mapping contract; the
/// mapping ITSELF is implemented by ApiClient error mapping (Phase
/// 09). This type is the vocabulary the queue manager and retry
/// policy consume in Phase 10.
///
/// Wire names are OUTBOUND serialization only (logs, the sync
/// screen). If a future phase ever persists these, the fromName
/// added THEN must be STRICT (null + quarantine).
enum SyncFailureClass {
  /// Transient (5xx / network): retryable with backoff — the entry
  /// returns to pending with `next_retry_at` set.
  retryable('retryable'),

  /// Permanent (4xx-class): not retryable — the entry goes to
  /// failed (TERMINAL) and needs admin attention.
  permanent('permanent');

  const SyncFailureClass(this.wireName);

  /// Stable outbound name for logs — never rename existing values.
  final String wireName;
}