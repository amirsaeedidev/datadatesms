import 'package:datadadtesms/features/sync/domain/entities/sync_queue_item.dart';
import 'package:datadadtesms/features/sync/domain/entities/sync_status.dart';

/// Persistence contract of the outbound queue — sync domain
/// repository (abstract interface; the Drift-backed impl
/// `sync_repository_impl.dart` lands with Phase 10).
///
/// REPOSITORY vs ENGINE (the Phase 03.6 split, mirroring
/// ParserRepository/MatchingRepository): this interface PERSISTS
/// queue state — enqueue, claim, complete, requeue, count. It never
/// performs HTTP and never decides retry timing: the SyncEngine
/// (Phase 10) consumes these methods; the RetryPolicy computes
/// backoff and hands the result to [requeueForRetry].
///
/// LIFECYCLE LOCKS (each method enforces part of the Phase 02.6
/// contract; the impl makes them transactional):
///  - ENQUEUE — insert-only, initial state (the SyncQueueItem
///    .enqueued factory invariant).
///  - CLAIM — the single pending→inFlight transition, setting
///    attemptStartedAt (the concurrency lock). A claim on a
///    non-pending/expired-backoff entry throws — guards against
///    double-processing even under engine bugs.
///  - COMPLETE — synced/failed only; completedAt set; entries are
///    NEVER deleted (retained for audit + the failed tab's manual
///    retry).
///  - REQUEUE — retryable outcomes: back to pending with
///    nextRetryAt, attempt marker CLEARED, retryCount incremented
///    by the impl (a spent attempt — including a crash recovered by
///    [requeueStuck], which shares this accounting).
///
/// ERROR CONTRACT (same lock as BankRepository): implementations
/// THROW typed exceptions (DatabaseException family, Phase 04);
/// signatures FINAL, no Result/Failure; usecases/engine wrap.
///
/// Pure domain: no Drift, no dio — entities only.
abstract interface class SyncRepository {
  // -------------------------------------------------------------------------
  // Enqueue & claim
  // -------------------------------------------------------------------------

  /// INSERT of a newly enqueued entry (the SyncQueueItem.enqueued
  /// output). Throws on id collision — the id is the operation
  /// idempotency handle; a duplicate enqueue is a wiring bug.
  ///
  /// NOTE (atomicity): transaction-creating usecases (Phase 08) call
  /// this TOGETHER with TransactionRepository.save in ONE database
  /// transaction — the coupling is documented on both interfaces.
  Future<void> enqueue(SyncQueueItem item);

  /// Claims the NEXT claimable entry: status pending AND backoff
  /// expired (nextRetryAt null or <= now), ordered oldest-first.
  /// Returns null when the queue is empty.
  ///
  /// The claim IS the lock: the impl transitions to inFlight +
  /// sets attemptStartedAt transactionally. A second concurrent
  /// claim skips the same row (SQLite serializes the write).
  Future<SyncQueueItem?> claimNext();

  /// Requeues entries STUCK in inFlight since before [olderThan] —
  /// crash recovery on app restart (Phase 10). Back to pending,
  /// retryCount incremented (conservative accounting: a crash
  /// mid-attempt counts), attempt marker cleared.
  ///
  /// Returns the ids of re-queued entries (audit/logging input).
  Future<List<String>> requeueStuck(DateTime olderThan);

  // -------------------------------------------------------------------------
  // Outcomes
  // -------------------------------------------------------------------------

  /// Marks the claimed entry SYNCED — genuine backend acceptance or
  /// idempotent-duplicate-confirmed. Sets completedAt. The entry is
  /// retained (never deleted — the Phase 02.6 lock).
  Future<void> completeSynced(String id);

  /// Marks the claimed entry FAILED — permanent (4xx-class) error.
  /// Sets completedAt + lastError/failureClass. Retained; visible on
  /// the sync screen's failed tab with manual retry.
  Future<void> completeFailed({
    required String id,
    required String lastError,
  });

  /// Requeues the claimed entry for a retryable outcome: back to
  /// pending, [nextRetryAt] computed by the RetryPolicy (Phase 10)
  /// and handed in, failureClass/lastError carried from the attempt,
  /// attempt marker cleared.
  Future<void> requeueForRetry({
    required String id,
    required DateTime nextRetryAt,
    required String lastError,
  });

  // -------------------------------------------------------------------------
  // Reads & counts (screens + engine guards)
  // -------------------------------------------------------------------------

  /// One entry by id — null when absent (sync screen detail).
  Future<SyncQueueItem?> getItem(String id);

  /// The transmission history of ONE record (entityType+entityId) —
  /// the transaction detail's sync-status section. Newest first.
  Future<List<SyncQueueItem>> getHistoryForEntity({
    required String entityType,
    required String entityId,
  });

  /// Entries by status — the sync screen's tabs. Paged, newest
  /// first.
  Future<List<SyncQueueItem>> getByStatus({
    required SyncStatus status,
    int page = 0,
    int pageSize = 20,
  });

  /// Count of entries currently claimable (pending + backoff
  /// expired) — the dashboard's "Pending Sync" tile and the
  /// engine's skip-when-empty guard.
  Future<int> countClaimable();

  /// Count of entries in a given status — dashboard tiles (failed
  /// count) and the GetPendingCount usecase.
  Future<int> countByStatus(SyncStatus status);
}