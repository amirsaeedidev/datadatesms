import 'package:drift/drift.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';

/// Outbound transmission queue — Drift table (sync_queue).
///
/// PHYSICAL mapping of the Phase 02 [SyncQueueItem] entity. The
/// offline-first durability core: a mutation is durable the moment
/// it is enqueued here; the Phase 10 SyncEngine drains it whenever
/// connectivity allows. NEVER deleted before genuine success — the
/// Phase 02.6 lock expressed in storage: terminal rows (synced /
/// failed) are RETAINED (audit + the sync screen's failed tab with
/// manual retry).
///
/// NO FOREIGN KEYS OUT — deliberate: [entityId] addresses ANY
/// carried record kind (transaction / pending_transaction / future
/// kinds) through the snake-case discriminator [entityType]. A
/// polymorphic reference cannot be a single FK; integrity of the
/// address is guaranteed by the enqueue usecases (Phase 08/11) that
/// build both the entity row and the queue entry in ONE DB
/// transaction.
///
/// CLAIM MODEL (Phase 02.6): status 'inFlight' + [attemptStartedAt]
/// IS the claim. Crash recovery (Phase 10) re-queues stuck claims.
/// The claimable query — pending AND backoff expired — is the
/// hottest query of this table; the composite index serves it.
///
/// RETRY CYCLE fields map 1:1 to the entity: [retryCount] spent
/// attempts (crash mid-attempt counts), [nextRetryAt] the backoff
/// gate, [failureClass] the last error's classification
/// ('retryable' | 'permanent'), [lastError] a SHORT safe technical
/// message, [completedAt] terminal time.
///
/// PAYLOAD: [payload] is the immutable marshaled JSON body (deep
/// JSON string — byte-identical replays on retry), [payloadVersion]
/// its contract tag. Built once at enqueue; never re-marshaled.
@TableIndex(
  name: 'ix_sync_queue_claimable',
  columns: <Symbol>{#status, #nextRetryAt}
)
@TableIndex(
  name: 'ix_sync_queue_entity',
  columns: <Symbol>{#entityType, #entityId}
)
class SyncQueueTable extends Table {
  @override
  String get tableName => DbConstants.tableSyncQueue;

  /// Primary key — [SyncQueueItem.id], locally generated UUID. The
  /// operation idempotency handle of the sync path. TEXT, not
  /// auto-increment.
  TextColumn get id => text().clientDefault(() => '')();

  /// Snake-case entity discriminator ('transaction' |
  /// 'pending_transaction' | future kinds). Unknown kinds:
  /// log + skip — never crash the queue.
  TextColumn get entityType => text()();

  /// Local id of the carried record — together with [entityType]
  /// the polymorphic address (no FK; see the class doc comment).
  TextColumn get entityId => text()();

  /// Wire name of SyncOperation ('create' | 'update') — the
  /// upsert-only vocabulary. Model marshals.
  TextColumn get operation => text()();

  /// Immutable marshaled JSON body — byte-identical replays.
  /// TEXT (JSON string), never re-marshaled between attempts.
  TextColumn get payload => text()();

  /// Payload contract version tag (e.g. 1) — lets the backend
  /// route/migrate old payloads.
  IntColumn get payloadVersion => integer().withDefault(const Constant(1))();

  /// Wire name of SyncStatus ('pending' | 'inFlight' | 'synced' |
  /// 'failed') — model marshals. NOTE the single-word 'inFlight'
  /// wire value (the Phase 02.6 lock).
  TextColumn get status => text()();

  /// Spent attempts — a crash mid-attempt counts (conservative
  /// accounting, Phase 02.6).
  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  /// Backoff gate — earliest next attempt (UTC); null while no
  /// retry is scheduled.
  DateTimeColumn get nextRetryAt => dateTime().nullable()();

  /// Wire name of SyncFailureClass ('retryable' | 'permanent') —
  /// the last attempt's classification. Model marshals.
  TextColumn get failureClass => text().nullable()();

  /// SHORT safe technical message from the last attempt — never raw
  /// SMS / unmasked values (Phase 02.6 security lock).
  TextColumn get lastError => text().nullable()();

  /// Claim marker — when the current attempt started (UTC). Set on
  /// pending→inFlight; CLEARED on requeue-for-retry (the
  /// reset-on-requeue rule). Null while unclaimed.
  DateTimeColumn get attemptStartedAt => dateTime().nullable()();

  /// Terminal time (UTC) — set only on genuine backend
  /// acknowledgment (synced) or permanent failure (failed). Never
  /// before real success.
  DateTimeColumn get completedAt => dateTime().nullable()();

  /// When the entry was enqueued (UTC).
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => <Column>{id};
}