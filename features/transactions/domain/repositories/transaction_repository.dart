import 'package:datadadtesms/core/constants/app_constants.dart';
import 'package:datadadtesms/features/transactions/domain/entities/transaction.dart';
import 'package:datadadtesms/features/transactions/domain/entities/transaction_status.dart';
import 'package:datadadtesms/features/transactions/domain/entities/transaction_type.dart';

/// Optional filters for [TransactionRepository.getTransactions].
///
/// All fields nullable = unconstrained. A record — filters are pure
/// data with no behavior; a class would be ceremony.
typedef TransactionFilters = ({
  String? bankCode,
  TransactionType? type,
  TransactionStatus? status,
});

/// Persistence contract of the financial records — transactions
/// domain repository (abstract interface; the Drift-backed impl
/// `transaction_repository_impl.dart` lands with its feature phase).
///
/// METHOD SET — exactly the MD 08.4 list: save / get / list /
/// updateStatus / findByHash / findByReference. No more (no delete —
/// records are audit-retained), no field-partial updates (whole
/// entity or nothing).
///
/// DUPLICATE-PREVENTION COUPLING (locked here, implemented in the
/// feature phase): record creation and its sync-queue entry are
/// written in ONE database transaction — the enqueue usecase drives
/// both through this repository and the sync repository, and the
/// impl phase makes the atomicity explicit. The INTERFACE here
/// stays per-concern so the sync feature's repository (next file)
/// keeps its own contract; the atomicity note lives on BOTH.
///
/// LOOKUP PAIR (dedup checks of DeduplicationEngine, Phase 08):
///  - [findByDedupKey] — the canonical duplicate check. Returns
///    null (no duplicate) or the EXISTING record. NOTE: the UNIQUE
///    index on the column is the last line of defense; the engine
///    must consult this method FIRST — a constraint violation at
///    insert time is a BUG, not a control flow.
///  - [findBySms] — one-sms-one-record invariant (also UNIQUE at
///    storage).
///
/// ERROR CONTRACT (same lock as BankRepository): implementations
/// THROW typed exceptions (DatabaseException family, Phase 04);
/// signatures FINAL, no Result/Failure; usecases wrap for providers.
///
/// Pure domain: no Drift, no Table types — entities only.
abstract interface class TransactionRepository {
  // -------------------------------------------------------------------------
  // Writes
  // -------------------------------------------------------------------------

  /// INSERT of a newly created record (TransactionMapper output,
  /// Phase 08). Throws on id/dedupKey/smsId collision — collisions
  /// reaching this method are engine bugs (see the lookup pair).
  ///
  /// See the class doc comment: the caller (enqueue usecase) wraps
  /// this together with the sync-queue entry in ONE DB transaction.
  Future<void> save(Transaction transaction);

  /// Whole-entity update for lineage/standing mutations. The
  /// [Transaction.copyWith] output (set-once serverTransactionId,
  /// updatedAt refresh) persists through this.
  Future<void> update(Transaction transaction);

  /// Standing-only update (UpdateTransactionStatus usecase,
  /// Phase 11 review flows) — the only field-level API, because
  /// standing changes are high-frequency and audit-coupled.
  Future<void> updateStatus(String id, TransactionStatus status);

  // -------------------------------------------------------------------------
  // Reads
  // -------------------------------------------------------------------------

  /// One record by id — null when absent (GetTransaction usecase).
  Future<Transaction?> getTransaction(String id);

  /// Paged list, NEWEST FIRST (timestamp DESC) — the transactions
  /// screen. [page] 0-based; optional [filters]; optional full-text
  /// [search] across bankName/referenceNumber/traceNumber.
  Future<List<Transaction>> getTransactions({
    int page = 0,
    int pageSize = AppConstants.defaultPageSize,
    TransactionFilters filters,
    String? search,
  });

  /// The canonical duplicate check (DeduplicationEngine, Phase 08).
  /// Null = no duplicate. See the class doc comment — consult FIRST,
  /// constraint violations at insert are bugs.
  Future<Transaction?> findByDedupKey(String dedupKey);

  /// The one-sms-one-record invariant check (Phase 08).
  Future<Transaction?> findBySms(String smsId);

  /// Reference-based lookup (matching input, Phase: matching) —
  /// indexed on the column.
  Future<Transaction?> findByReference(String referenceNumber);

  /// Source-hash lookup — the sms-side lineage query (detail view's
  /// "parsed from" thread).
  Future<Transaction?> findByHash(String sourceSmsHash);
}