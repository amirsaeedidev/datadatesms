import 'package:equatable/equatable.dart';

import 'package:datadadtesms/core/logging/log_level.dart';

/// A technical log entry — core logging entity.
///
/// Infrastructure contract (locked in Phase 02; PRODUCED by AppLogger
/// in Phase 04, PERSISTED by the logs datasource, CONSUMED by the
/// logs feature's entities/queries — this class is the single
/// definition both sides share):
///
/// WHAT GOES IN: operational/technical facts — network failures,
/// DB errors, parser errors, permission denials, sync outcomes.
/// NOT business events: money-related milestones
/// (received/parsed/validated/matched/queued/sent/failed) are
/// FINANCIAL AUDIT territory (AuditEvent) — the two systems are
/// disjoint by design and never overlap.
///
/// SECURITY CONTRACT — "Raw SMS در Log عادی ذخیره نشود":
///  - [message] is written by AppLogger callers and must contain
///    only SAFE references: message hash, masked values, ids
///    (smsId/bankId/deviceId/parserVersion/fieldName/ruleId).
///    AppLogger (Phase 04) enforces this by REVIEW CONVENTION +
///    unit tests that scan for raw-looking content — the entity
///    itself cannot inspect strings, so the contract is documented
///    and test-enforced rather than type-enforced. This is the
///    honest, senior-level boundary: type safety where possible,
///    convention + tests where strings are the only carrier.
///  - [details] (free-form metadata map) follows the same rule.
///  - NO raw SMS body, NO unmasked PAN/account — never, at any
///    severity.
///
/// CONTENT RULES:
///  - [module] — lowercase snake_case dot-path of the origin
///    subsystem, e.g. 'core.db.migration', 'sync.engine',
///    'parser.engine'. Free-form vocabulary owned by the producing
///    subsystem; the logs screen filters on it.
///  - [event] — short stable event name within the module, e.g.
///    'open_failed', 'attempt_exhausted'. Pairs with [module] as the
///    logs screen's search key; snake_case, never a sentence.
///  - [errorCode] — optional machine-readable code
///    (e.g. 'DB-001'); rendered by the logs UI as the compact
///    technical tag (same convention as ErrorView's code).
///  - [stackTrace] — for LogLevel.error/critical with a caught
///    exception; data-only, no logic.
///
/// BUCKET RULE: this record is TECHNICAL infrastructure — it lives
/// in core/logging (dual-home contract: features/logs re-exports it,
/// see LogLevel's NOTE). It has no feature-perspective fields
/// (no screen names, no user ids) on purpose: it must stay usable
/// by AppLogger before ANY feature exists.
class LogEvent extends Equatable {
  const LogEvent({
    required this.id,
    required this.timestamp,
    required this.level,
    required this.module,
    required this.event,
    required this.message,
    this.errorCode,
    this.stackTrace,
    this.details,
  });

  /// Creates an entry at log time — AppLogger's builder in
  /// Phase 04 assembles this from a caught error context.
  const LogEvent.error({
    required String id,
    required DateTime timestamp,
    required String module,
    required String event,
    required String message,
    required StackTraceData stackTrace,
    String? errorCode,
    Map<String, Object?>? details,
  }) : this(
          id: id,
          timestamp: timestamp,
          level: LogLevel.error,
          module: module,
          event: event,
          message: message,
          errorCode: errorCode,
          stackTrace: stackTrace,
          details: details,
        );

  /// Local unique identifier (UUID v4) — assigned at log time.
  final String id;

  /// When the event was logged (UTC).
  final DateTime timestamp;

  /// Severity — [LogLevel].
  final LogLevel level;

  /// Origin subsystem, lowercase snake_case dot-path. See the
  /// content rules in the class doc comment.
  final String module;

  /// Stable short event name within the module. Snake_case.
  final String event;

  /// Human-readable entry — MUST obey the security contract (safe
  /// references only; see the class doc comment). Technical data
  /// like hash prefixes stays unlocalized.
  final String message;

  /// Optional machine-readable code (e.g. 'DB-001').
  final String? errorCode;

  /// Captured stack trace for error/critical entries — data-only.
  final StackTraceData? stackTrace;

  /// Free-form safe metadata (same security rule as [message]).
  /// Key naming convention: snake_case keys, JSON-safe values.
  final Map<String, Object?>? details;

  @override
  List<Object?> get props => <Object?>[
        id,
        timestamp,
        level,
        module,
        event,
        message,
        errorCode,
        stackTrace,
        // Equatable performs deep map comparison.
        details,
      ];
}

/// Captured stack-trace information — data-only value object.
///
/// Kept as STRUCTURED data (not a raw StackTrace object) so the
/// record remains serializable into the local DB and inspectable by
/// the logs screen without depending on the VM's StackTrace type.
class StackTraceData extends Equatable {
  const StackTraceData({
    required this.exceptionType,
    required this.firstLine,
    this.frames = const <String>[],
  });

  /// The exception's runtime type, e.g. 'StateError',
  /// 'TimeoutException'.
  final String exceptionType;

  /// The exception's message — short, technical, safe for display.
  final String firstLine;

  /// Selected frames (top N captured by AppLogger) as plain strings.
  final List<String> frames;

  @override
  List<Object?> get props => <Object?>[
        exceptionType,
        firstLine,
        // Equatable performs deep list comparison.
        frames,
      ];
}