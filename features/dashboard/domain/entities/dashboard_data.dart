import 'package:equatable/equatable.dart';

/// Persisted-state snapshot for the dashboard — dashboard domain
/// entity (read model).
///
/// SCOPE LOCK (the critical boundary): this entity carries ONLY
/// what is derivable from the LOCAL DATABASE — counts and
/// timestamps. The dashboard's RUNTIME tiles are deliberately NOT
/// here and are composed ABOVE, by the GetDashboardData usecase:
///  - SMS reader running     → SmsRepository.isReaderRunning
///  - Internet connectivity  → ConnectivityService (Phase 10)
///  - SMS permission state   → permissions feature
/// The provider receives the COMPOSED view; this snapshot is its
/// persisted half. That split keeps the dashboard repository a pure
/// aggregation surface (RULE: "محاسبات سنگین در UseCase/Service").
///
/// DERIVED RATES are computed by consumers (the provider/usecase),
/// never stored: e.g. the parser-error rate is smsFailedCount over
/// (smsProcessed + smsFailed). A snapshot carries FACTS, not
/// interpretations — interpretations change with product decisions,
/// facts don't.
///
/// COMPUTED FRESH per call (no caching inside the entity — the
/// repository query is the source; the provider owns refresh
/// policy). Immutable snapshot — no copyWith (same policy as the
/// log/audit read models).
class DashboardData extends Equatable {
  const DashboardData({
    required this.smsPendingCount,
    required this.smsProcessedCount,
    required this.smsDuplicateCount,
    required this.smsIgnoredCount,
    required this.smsFailedCount,
    required this.transactionsTotal,
    required this.transactionsPending,
    required this.transactionsConfirmed,
    required this.transactionsRejected,
    required this.matchesMatched,
    required this.matchesNeedsReview,
    required this.matchesRejected,
    required this.syncClaimable,
    required this.syncFailed,
    required this.enabledBanks,
    this.lastSyncAt,
  });

  // -----------------------------------------------------------------------
  // SMS pipeline (sms_messages by processing status)
  // -----------------------------------------------------------------------

  /// Messages awaiting or undergoing processing (received +
  /// processing) — the pipeline backlog.
  final int smsPendingCount;

  /// Messages that became transactions — the success path volume.
  final int smsProcessedCount;

  /// Ingestion-level duplicates blocked (no second record).
  final int smsDuplicateCount;

  /// Intentionally skipped (unknown sender / disabled bank).
  final int smsIgnoredCount;

  /// Processing failures — the parser-error tile (MD Phase 16).
  final int smsFailedCount;

  // -----------------------------------------------------------------------
  // Transaction standings (transactions by status)
  // -----------------------------------------------------------------------

  /// All records ever created (the "money that happened" total).
  final int transactionsTotal;

  /// Standing `pending` — awaiting confirmation.
  final int transactionsPending;

  /// Standing `confirmed` — settled.
  final int transactionsConfirmed;

  /// Standing `rejected` — admin-voided, retained for audit.
  final int transactionsRejected;

  // -----------------------------------------------------------------------
  // Matching outcomes (matching_records by status)
  // -----------------------------------------------------------------------

  /// Approved matches.
  final int matchesMatched;

  /// The AMBIGUOUS / manual-review queue (the RULE-009 tile).
  final int matchesNeedsReview;

  /// Rejected evaluations.
  final int matchesRejected;

  // -----------------------------------------------------------------------
  // Sync (sync_queue)
  // -----------------------------------------------------------------------

  /// Entries currently claimable (pending + backoff expired) — the
  /// "Pending Sync" tile.
  final int syncClaimable;

  /// Terminally failed entries — the "Failed Transactions" tile /
  /// admin attention.
  final int syncFailed;

  /// When the last entry reached `synced` — null when nothing ever
  /// synced (the "Last Sync" tile).
  final DateTime? lastSyncAt;

  // -----------------------------------------------------------------------
  // Config
  // -----------------------------------------------------------------------

  /// Banks currently enabled — the "وضعیت بانک‌ها" summary.
  final int enabledBanks;

  @override
  List<Object?> get props => <Object?>[
        smsPendingCount,
        smsProcessedCount,
        smsDuplicateCount,
        smsIgnoredCount,
        smsFailedCount,
        transactionsTotal,
        transactionsPending,
        transactionsConfirmed,
        transactionsRejected,
        matchesMatched,
        matchesNeedsReview,
        matchesRejected,
        syncClaimable,
        syncFailed,
        enabledBanks,
        lastSyncAt,
      ];
}