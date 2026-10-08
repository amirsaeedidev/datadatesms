/// Severity level of a technical log entry — core logging enum.
///
/// Infrastructure contract (locked in Phase 02; AppLogger and
/// LogEvent in Phase 04 are its primary consumers — the logs FEATURE
/// only displays what already exists):
///
///  - [debug]    — developer diagnostics; noisy detail. Never shown
///                 in production builds (gated by AppLogger, Phase 04).
///  - [info]     — normal lifecycle milestones (reader started,
///                 queue drained, sync finished).
///  - [warning]  — degraded-but-recovered situations (stuck inFlight
///                 entry re-queued, timestamp fallback used).
///  - [error]    — a failed operation that needs attention
///                 (parse failure, DB error, API 5xx exhausted).
///  - [critical] — data-integrity / security-grade events
///                 (duplicate insert hit the UNIQUE guard, token
///                 rejected as invalid by SecureStorage).
///
/// ORDERING: [severity] is the canonical numeric severity
/// (10/20/30/40/50), decoupled from declaration order. The logs
/// screen's "minimum level" filter (Phase 12) and FilterLogs usecase
/// (Phase 11) consume [isAtLeast] — pure derived comparison, no
/// policy decisions live here.
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
/// NOTE (dual-home contract): the canonical definition lives HERE
/// in core infrastructure; `features/logs/domain/entities/
/// log_level.dart` re-exports this file so the logs domain never
/// depends on core internals directly.
enum LogLevel {
  /// Developer diagnostics — noisy detail; never in production.
  debug('debug', 10),

  /// Normal lifecycle milestones.
  info('info', 20),

  /// Degraded but recovered situations.
  warning('warning', 30),

  /// Failed operation needing attention.
  error('error', 40),

  /// Data-integrity / security-grade events.
  critical('critical', 50);

  const LogLevel(this.wireName, this.severity);

  /// Stable wire/serialization name — persisted in the local DB
  /// (`logs.level`) and consumed by the data-layer mapper.
  /// Never rename existing values.
  final String wireName;

  /// Canonical numeric severity — used for ordering and
  /// minimum-level filters. Decoupled from declaration order on
  /// purpose: reordering enum values in source must never change
  /// filter behavior.
  final int severity;

  /// Whether this level is at or above [other] — the comparison the
  /// minimum-level filter is built on.
  bool isAtLeast(LogLevel other) => severity >= other.severity;

  /// Parses a serialized level coming from local storage or the
  /// data layer.
  ///
  /// STRICT — returns `null` for unknown values instead of a
  /// fallback. Unlike TransactionType (which owns a legitimate safe
  /// member `unknown`), LogLevel has NO safe fallback: every wrong
  /// remap either HIDES severity (unknown→debug buries a critical
  /// event) or FABRICATES it (unknown→error invents alarm). A
  /// persisted level written by a newer app version must surface to
  /// the mapper and be logged — never silently remapped.
  static LogLevel? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final LogLevel level in LogLevel.values) {
      if (level.wireName == name) {
        return level;
      }
    }
    return null;
  }
}