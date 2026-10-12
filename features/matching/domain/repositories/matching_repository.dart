import 'package:datadadtesms/core/constants/app_constants.dart';
import 'package:datadadtesms/features/matching/domain/entities/matching_result.dart';
import 'package:datadadtesms/features/transactions/domain/entities/pending_transaction.dart';

/// Persistence contract of the matching feature — matching domain
/// repository (abstract interface; the Drift-backed impl
/// `matching_repository_impl.dart` lands with the matching feature
/// phase).
///
/// TWO DATA OWNERSHIPS behind one surface:
///  1. The PENDING POOL — reads of active PendingTransactions
///     (candidate pool). The records THEMSELVES are backend-authored
///     mirrors: standing mutations (e.g. fulfilled by an approved
///     match) go through the transactions feature's entities and
///     ride the SYNC QUEUE — the review usecases orchestrate that
///     ABOVE this repository; nothing here ever bypasses the queue
///     (the Phase 02.6 lock).
///  2. The EVALUATION ROWS (matching_records) — one row per
///     Transaction × PendingTransaction pair, upserted BY PAIR (the
///     table's UNIQUE constraint); review decisions land here with
///     actor + timestamps.
///
/// ENGINE DISTINCTION (locked): this repository PERSISTS outcomes —
/// it never computes them. Score/status derivation is the
/// MatchingEngine's job (matching feature phase); the interface
/// carries ready-made [MatchingResult]s in and rows out.
///
/// ERROR CONTRACT (same lock as BankRepository): implementations
/// THROW typed exceptions (DatabaseException/MatchingException
/// family, Phase 04); signatures FINAL, no Result/Failure;
/// usecases wrap for providers.
///
/// Pure domain: no Drift, no Table types — entities only.
abstract interface class MatchingRepository {
  // -------------------------------------------------------------------------
  // Pending pool (candidates — read path)
  // -------------------------------------------------------------------------

  /// ACTIVE pending expectations, optionally narrowed by bank code,
  /// paged newest-first. The matching engine's candidate pool.
  Future<List<PendingTransaction>> getActivePendings({
    String? bankCode,
    int page = 0,
    int pageSize = AppConstants.defaultPageSize,
  });

  /// One pending by id — null when absent (review detail view).
  Future<PendingTransaction?> getPending(String id);

  // -------------------------------------------------------------------------
  // Evaluation rows (matching_records)
  // -------------------------------------------------------------------------

  /// All evaluation rows of ONE transaction, newest first — the
  /// transaction detail's match-history section.
  Future<List<MatchingResult>> getResultsForTransaction(
      String transactionId);

  /// All rows in a given status — the matching screen's tabs
  /// (needsReview queue, matched history, rejected). Paged.
  Future<List<MatchingResult>> getResultsByStatus({
    required MatchingResultStatus status,
    int page = 0,
    int pageSize = AppConstants.defaultPageSize,
  });

  /// UPSERT by (transactionId, pendingTransactionId) pair — the
  /// pair's CURRENT state (re-runs update, never duplicate; the
  /// table's UNIQUE constraint). Called by the engine's usecase
  /// after evaluating a pair.
  Future<void> upsertResult(MatchingResult result);

  /// One pair's current row — null when the pair was never
  /// evaluated. The ambiguity-resolution flow reads it before
  /// writing the decision.
  Future<MatchingResult?> getResultForPair({
    required String transactionId,
    required String pendingTransactionId,
  });

  // -------------------------------------------------------------------------
  // Review decisions (admin actions on evaluation rows)
  // -------------------------------------------------------------------------

  /// Persists an APPROVED match decision (ApproveMatch usecase):
  /// the pair row is written with admin actor + decision time. The
  /// usecase — ABOVE this repository — additionally mutates the
  /// pending's standing (fulfilled) through the transactions
  /// repository and enqueues that mutation on the sync queue. This
  /// method owns ONLY the evaluation row.
  Future<void> saveApprovedDecision({
    required MatchingResult result,
    required String actorUserId,
  });

  /// Persists a REJECTED / ambiguous-resolved decision (RejectMatch
  /// / ResolveAmbiguous usecases) — same single-ownership rule as
  /// [saveApprovedDecision].
  Future<void> saveRejectedDecision({
    required MatchingResult result,
    required String actorUserId,
  });
}