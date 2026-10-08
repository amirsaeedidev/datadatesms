import 'package:equatable/equatable.dart';

import 'package:datadadtesms/features/sync/domain/entities/sync_operation.dart';
import 'package:datadadtesms/features/sync/domain/entities/sync_status.dart';

/// One entry in the outbound sync queue — sync domain entity.
///
/// Contract locked in Phase 02 (the queue that guarantees
/// offline-first: a mutation is DURABLE locally the moment it is
/// enqueued, and the SyncEngine in Phase 10 delivers it whenever
/// connectivity allows — the sync layer NEVER deletes an entry
/// before real success, RULE: "پاک‌کردن Queue قبل از Success واقعی
/// ممنوع"):
///
/// ENQUEUE INVARIANT — created ONLY as pending, by the enqueue
/// usecases (Phase 08 pipeline / Phase 11 review mutations):
/// `retryCount == 0`, `nextRetryAt == null`, `failureClass == null`,
/// `lastError == null`, `attemptStartedAt == null`. The
/// [SyncQueueItem.enqueued] factory enforces this structurally —
/// an entry cannot be born with a history it does not have.
///
/// CLAIM (inFlight, Phase 10): the queue manager sets
/// [attemptStartedAt] as the claim marker. A stuck claim after a
/// crash is recovered on restart by re-queue: reset to pending with
/// [retryCount] INCREMENTED — a crash mid-attempt counts as one
/// spent attempt (conservative accounting; the re-send is safe by
/// operation-level idempotency).
///
/// RETRY CYCLE (retryable outcomes): status back to pending with
/// [nextRetryAt] set by the retry policy, [failureClass] carried
/// from the attempt, `attemptStartedAt` CLEARED (the claim is over —
/// the reset-on-requeue rule).
///
/// COMPLETION is set ONLY on genuine backend acknowledgment:
/// success or idempotent-duplicate-confirmed → synced. A retrying
/// entry is NEVER marked completed before real success.
///
/// PAYLOAD — [payload] is the fully-marshaled, API-ready body as a
/// versioned JSON contract ([payloadVersion], see below). Built ONCE
/// at enqueue time by the enqueue usecase from the LIVE record, and
/// it is IMMUTABLE from then on: retries replay the EXACT SAME
/// bytes — no re-marshaling from a possibly-mutated record between
/// attempts. Retries are byte-identical replays.
///
/// ENTITY TYPE — [entityType] is a free-form snake_case domain
/// discriminator (e.g. 'transaction', 'pending_transaction') with
/// its vocabulary OWNED by the sync feature's usecases. Deliberately
/// a String, not an enum: adding a new synced entity kind later must
/// not break older readers (unknown entityType: log + skip — never
/// crash the queue on a newer entry kind).
///
/// SECURITY: [lastError] must be a SHORT technical message — it
/// never contains raw SMS or unmasked values (same policy as
/// ParserRuleResult.errorMessage).
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// persistence mapping lives in `SyncQueueItemModel` (data layer,
/// Phase 03).
class SyncQueueItem extends Equatable {
  const SyncQueueItem({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payload,
    required this.payloadVersion,
    required this.status,
    required this.createdAt,
    this.retryCount = 0,
    this.nextRetryAt,
    this.failureClass,
    this.lastError,
    this.attemptStartedAt,
    this.completedAt,
  });

  /// Creates an entry in its INITIAL state — the only sanctioned way
  /// a queue entry comes into existence (enqueue usecases).
  /// Enforces the enqueue invariant: pending, no history yet.
  factory SyncQueueItem.enqueued({
    required String id,
    required String entityType,
    required String entityId,
    required SyncOperation operation,
    required Map<String, Object?> payload,
    required int payloadVersion,
    required DateTime createdAt,
  }) {
    return SyncQueueItem(
      id: id,
      entityType: entityType,
      entityId: entityId,
      operation: operation,
      payload: payload,
      payloadVersion: payloadVersion,
      status: SyncStatus.pending,
      createdAt: createdAt,
      retryCount: 0,
      nextRetryAt: null,
      failureClass: null,
      lastError: null,
      attemptStartedAt: null,
      completedAt: null,
    );
  }

  /// Local unique identifier (UUID v4) — the operation idempotency
  /// handle of this queue entry (same role as Transaction.id for
  /// transaction sends: a re-send replays the same handle).
  final String id;

  /// Snake-case domain discriminator of the carried record — see
  /// the entityType note in the class doc comment.
  final String entityType;

  /// Local id of the carried record (e.g. Transaction.id).
  /// Together with [entityType] this addresses the record on both
  /// sides without joins.
  final String entityId;

  /// What kind of write this entry carries — [SyncOperation].
  final SyncOperation operation;

  /// Fully-marshaled, versioned, IMMUTABLE JSON body. Built once at
  /// enqueue; retries replay identical bytes.
  final Map<String, Object?> payload;

  /// Version tag of the payload JSON contract (e.g. 1). Lets the
  /// backend route/migrate old payloads when the contract evolves —
  /// adding fields is v2 while v1 readers stay working.
  final int payloadVersion;

  /// Current lifecycle state — see [SyncStatus].
  final SyncStatus status;

  /// Number of attempts SPENT (a crash mid-attempt also counts —
  /// conservative accounting, see the claim contract in the class
  /// doc comment).
  final int retryCount;

  /// Earliest time the next attempt may start (UTC) — set by the
  /// retry policy on retryable outcomes; null while there is no
  /// scheduled retry.
  final DateTime? nextRetryAt;

  /// Classification of the last attempt's error — [SyncFailureClass].
  /// Null until an error occurs.
  final SyncFailureClass? failureClass;

  /// SHORT technical message from the last attempt — safe for
  /// display on the sync screen (see SECURITY in the class doc
  /// comment). Null until an error occurs.
  final String? lastError;

  /// Claim marker: when the current attempt started (UTC). Set on
/// pending → inFlight; CLEARED on requeue-for-retry (see the
  /// reset-on-requeue rule in the class doc comment). Null while
  /// the entry is not claimed.
  final DateTime? attemptStartedAt;

  /// When this entry reached a TERMINAL state (synced/failed), UTC.
  /// Null until then — completion NEVER happens before genuine
  /// backend acknowledgment (see the completion contract in the
  /// class doc comment).
  final DateTime? completedAt;

  /// Whether this entry currently needs its clock watched: it is
  /// either waiting for its first attempt or for a backoff to
  /// expire. Consumed by the queue manager's claimable-query
  /// (Phase 10) — the logic itself lives there.
  bool get isAwaitingAttempt =>
      status == SyncStatus.pending &&
      (nextRetryAt == null);

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: `null` arguments KEEP the current value. Clearing
  /// [attemptStartedAt] on requeue uses [clearAttemptStartedAt]
  /// below — the ONE sanctioned clear on this entity (the claim
  /// marker is the only field whose lifecycle includes returning to
  /// null).
  SyncQueueItem copyWith({
    String? id,
    String? entityType,
    String? entityId,
    SyncOperation? operation,
    Map<String, Object?>? payload,
    int? payloadVersion,
    SyncStatus? status,
    int? retryCount,
    DateTime? nextRetryAt,
    SyncFailureClass? failureClass,
    String? lastError,
    DateTime? attemptStartedAt,
    DateTime? completedAt,
  }) {
    return SyncQueueItem(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      payloadVersion: payloadVersion ?? this.payloadVersion,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      failureClass: failureClass ?? this.failureClass,
      lastError: lastError ?? this.lastError,
      attemptStartedAt: attemptStartedAt ?? this.attemptStartedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Copy with [attemptStartedAt] explicitly set to null — the
  /// sanctioned claim-release on requeue-for-retry.
  SyncQueueItem clearAttemptStartedAt() {
    return SyncQueueItem(
      id: id,
      entityType: entityType,
      entityId: entityId,
      operation: operation,
      payload: payload,
      payloadVersion: payloadVersion,
      status: status,
      retryCount: retryCount,
      nextRetryAt: nextRetryAt,
      failureClass: failureClass,
      lastError: lastError,
      attemptStartedAt: null,
      completedAt: completedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        entityType,
        entityId,
        operation,
        // Equatable performs deep map comparison.
        payload,
        payloadVersion,
        status,
        retryCount,
        nextRetryAt,
        failureClass,
        lastError,
        attemptStartedAt,
        completedAt,
      ];
}