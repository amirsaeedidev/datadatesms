import 'package:drift/drift.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';

/// TECHNICAL log entries — Drift table (logs).
///
/// PHYSICAL mapping of the Phase 02 [LogEvent] entity (core/logging).
/// The TECHNICAL half of the disjoint logging pair: operational
/// facts only (network/DB/parser/permission/sync errors) — money
/// milestones live in [AuditEventsTable], NEVER here. Two physical
/// tables are the storage expression of the Phase 02 disjointness
/// contract (decision locked at Phase 03 head).
///
/// MARSHALING (model layer): [level] stores the LogLevel wire name;
/// [stackTrace] is the StackTraceData JSON object string ('null'
/// when absent); [details] the safe-metadata JSON object string.
/// The entity never sees storage shapes.
///
/// RETENTION (Phase 15 policy, noted here so the schema honors it):
/// technical logs are PRUNABLE by age/count — audit events are NOT.
/// Different tables make different retention rules trivial; a
/// single mixed table could never honor both.
@TableIndex(
  name: 'ix_logs_module_event',
  columns: <Symbol>{#module, #event},
)
@TableIndex(
  name: 'ix_logs_level',
  columns: <Symbol>{#level},
)
class LogsTable extends Table {
  @override
  String get tableName => DbConstants.tableLogs;

  /// Primary key — [LogEvent.id], UUID at log time. TEXT, not
  /// auto-increment.
  TextColumn get id => text().clientDefault(() => '')();

  /// When the event was logged (UTC).
  DateTimeColumn get timestamp => dateTime()();

  /// LogLevel wire name ('debug'|'info'|'warning'|'error'|
  /// 'critical') — model marshals. Indexed: the minimum-level
  /// filter reads it.
  TextColumn get level => text()();

  /// Origin subsystem dot-path ('core.db.migration') — see the
  /// LogEvent content rules.
  TextColumn get module => text()();

  /// Stable short event name within the module ('open_failed').
  TextColumn get event => text()();

  /// Human-readable entry — SAFE references only (the LogEvent
  /// security contract; enforced by convention + tests at the
  /// logger layer).
  TextColumn get message => text()();

  /// Machine-readable code ('DB-001') — nullable 1:1.
  TextColumn get errorCode => text().nullable()();

  /// StackTraceData JSON object string; 'null' when absent —
  /// model marshals the structured value object.
  TextColumn get stackTrace =>
      text().withDefault(const Constant('null'))();

  /// Safe-metadata JSON object string; 'null' when absent.
  TextColumn get details =>
      text().withDefault(const Constant('null'))();

  @override
  Set<Column> get primaryKey => <Column>{id};
}

/// FINANCIAL audit entries — Drift table (audit_events).
///
/// PHYSICAL mapping of the Phase 02 [AuditEvent] entity
/// (features/logs/domain). The FINANCIAL half of the disjoint pair:
/// the money story — every milestone of every transaction. Never
/// pruned, never mixed with technical logs.
///
/// MARSHALING (model layer): [type] / [actorRole] store their wire
/// names; [metadata] the safe-metadata JSON object string (default
/// '{}' — the entity's map is always present, possibly empty).
///
/// The dual-anchor slots ([smsId]/[transactionId]) are SOFT
/// references — deliberately NO foreign keys: audit rows must
/// outlive any message/record lifecycle change (RESTRICT would
/// freeze history; CASCADE would falsify it). Referential story is
/// told by the anchors themselves, not by FK enforcement.
@TableIndex(
  name: 'ix_audit_events_type',
  columns: <Symbol>{#type},
)
@TableIndex(
  name: 'ix_audit_events_transaction_id',
  columns: <Symbol>{#transactionId},
)
class AuditEventsTable extends Table {
  @override
  String get tableName => DbConstants.tableAuditEvents;

  /// Primary key — [AuditEvent.id], UUID at emission time. TEXT,
  /// not auto-increment.
  TextColumn get id => text().clientDefault(() => '')();

  /// When the event happened (UTC).
  DateTimeColumn get timestamp => dateTime()();

  /// AuditEventType wire name ('sms_received', ... — the frozen
  /// snake_case vocabulary) — model marshals. Indexed: the audit
  /// screen's facet filter.
  TextColumn get type => text()();

  /// Device that produced the event.
  TextColumn get deviceId => text()();

  /// App version at emission time — anchors every decision to the
  /// exact build.
  TextColumn get appVersion => text()();

  /// AuditActorRole wire name ('system' | 'admin') — model marshals.
  TextColumn get actorRole => text()();

  /// Acting human user id — null for system events. Nullable 1:1.
  TextColumn get actorUserId => text().nullable()();

  /// Anchor slot 1 — the source SMS (sms_messages.id). SOFT
  /// reference; see the class doc comment.
  TextColumn get smsId => text().nullable()();

  /// Anchor slot 2 — the financial record (transactions.id). SOFT
  /// reference; null until transaction_created.
  TextColumn get transactionId => text().nullable()();

  /// SHA-256 of the source message — the SAFE identity reference.
  TextColumn get smsHash => text().nullable()();

  /// Safe-metadata JSON object string; default '{}' (the entity's
  /// map is always present, possibly empty) — model marshals.
  TextColumn get metadata =>
      text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => <Column>{id};
}