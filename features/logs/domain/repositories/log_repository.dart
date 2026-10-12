// Logs-domain re-export types (dual-home contract, Phase 02) —
// consumed through this feature's namespace.
import 'package:datadadtesms/core/constants/app_constants.dart';
import 'package:datadadtesms/core/logging/audit_event_type.dart';
import 'package:datadadtesms/core/logging/log_level.dart';
import 'package:datadadtesms/features/logs/domain/entities/audit_event.dart';
import 'package:datadadtesms/features/logs/domain/entities/log_event.dart';

/// Persistence contract of BOTH log systems — logs domain
/// repository (abstract interface; the Drift-backed impl
/// `log_repository_impl.dart` lands with the logging phase).
///
/// ONE SURFACE, TWO DISJOINT STORES (the Phase 02/03 disjointness
/// contract, mirrored by the two table classes in logs_table.dart):
///  - TECHNICAL (logs table) — [LogEvent]s: operational facts.
///    APPEND-ONLY + PRUNABLE by age/count (the retention policy is
///    a Phase 15 concern; [pruneTechnicalLogs] is its hook).
///  - FINANCIAL AUDIT (audit_events table) — [AuditEvent]s: the
///    money story. APPEND-ONLY and NEVER pruned, never updated.
///
/// WRITER distinction (locked): in the runtime architecture the
/// WRITERS are AppLogger/AuditLogger (Phase 04) — they call the
/// datasource directly through their own wiring, NOT through this
/// repository (loggers must work before any feature exists; the
/// dual-home contract). THIS repository is the READER-facing
/// surface for the logs feature (screens, filters, searches) plus
/// the retention hook. Both sides share the same entities/tables —
/// that is why the contract lives in the feature's domain.
///
/// ERROR CONTRACT (same lock as BankRepository): implementations
/// THROW typed exceptions (DatabaseException family, Phase 04);
/// signatures FINAL, no Result/Failure; usecases wrap for providers.
///
/// Pure domain: no Drift, no Table types — entities only.
abstract interface class LogRepository {
  // -------------------------------------------------------------------------
  // Technical logs (read + retention)
  // -------------------------------------------------------------------------

  /// Paged technical entries, NEWEST FIRST — the logs screen.
  /// Optional minimum-level filter (the screen's level chips —
  /// LogLevel.isAtLeast semantics), optional module prefix filter
  /// (e.g. 'sync.'), optional free-text search across
  /// message/errorCode.
  Future<List<LogEvent>> getLogs({
    int page = 0,
    int pageSize = AppConstants.defaultPageSize,
    LogLevel? minLevel,
    String? modulePrefix,
    String? search,
  });

  /// One technical entry by id — null when absent (log detail).
  Future<LogEvent?> getLog(String id);

  /// RETENTION HOOK (Phase 15 policy): deletes technical entries
  /// older than [olderThan]. Returns the deleted count.
  ///
  /// AUDIT events have NO such method — the disjoint retention rule
  /// is enforced by the interface shape itself (impossible to prune
  /// what has no pruning API).
  Future<int> pruneTechnicalLogs(DateTime olderThan);

  // -------------------------------------------------------------------------
  // Financial audit (read-only surface)
  // -------------------------------------------------------------------------

  /// Paged audit entries, NEWEST FIRST — the audit screen. Optional
  /// category filter (the facet chips — AuditEventCategory), optional
  /// transaction anchor filter (the transaction detail's audit
  /// timeline), optional SMS anchor filter.
  Future<List<AuditEvent>> getAuditEvents({
    int page = 0,
    int pageSize = AppConstants.defaultPageSize,
    AuditEventCategory? category,
    String? transactionId,
    String? smsId,
  });

  /// One audit entry by id — null when absent (audit detail).
  Future<AuditEvent?> getAuditEvent(String id);

  /// The complete audit timeline of ONE transaction, OLDEST FIRST —
  /// the chronological story (sms_received → … → current standing).
  /// Anchored on transactionId; context events (sync_started)
  /// without a transaction anchor are NOT included by design.
  Future<List<AuditEvent>> getTransactionTimeline(String transactionId);
}