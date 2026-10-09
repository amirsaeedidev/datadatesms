import 'package:drift/drift.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';

/// Ingested SMS messages — Drift table (sms_messages).
///
/// PHYSICAL mapping of the Phase 02 [SmsMessage] entity. The ROOT of
/// the ingestion spine: no foreign keys point OUT of this table —
/// later, transactions.sms_id will point INTO it (RESTRICT).
///
/// RAW BODY IS STORED — the Phase 02 lock: offline-first re-parsing
/// after parser-rule updates requires the original text; failed
/// messages get reprocessed with new rules. Security is enforced at
/// the CONSUMERS (logs/audits reference body_hash; the API sends
/// source_sms_hash only) — storage keeping the body is the feature,
/// not a leak.
///
/// NULLABILITY maps 1:1 to the entity: [normalizedBody] and
/// [processedAt] are nullable until the pipeline runs; everything
/// else is non-null.
///
/// body_hash INDEX — deliberately NOT UNIQUE: the same physical
/// message arriving twice (broadcast + inbox backfill) creates TWO
/// legitimate rows — the later one carries status `duplicate`. The
/// find-by-hash lookup IS the ingestion-level dedup check; a UNIQUE
/// constraint would reject the very row the design exists to detect.
///
/// processingStatus / source store their wire names as TEXT —
/// marshaled by the model layer (same convention as the config
/// tables).
@TableIndex(
  name: 'ix_sms_messages_body_hash',
  columns: <String>['bodyHash'],
)
class SmsMessagesTable extends Table {
  @override
  String get tableName => DbConstants.tableSmsMessages;

  /// Primary key — [SmsMessage.id], locally generated UUID at
  /// receive time. TEXT, not auto-increment.
  TextColumn get id => text().clientDefault(() => '')();

  /// Capturing device — [SmsMessage.deviceId].
  TextColumn get deviceId => text()();

  /// Sender EXACTLY as delivered by the native layer ('+98...',
  /// '5004'). The entity preserves the original for re-detection
  /// after config changes; canonical form is computed at detection
  /// time (Phase 07) — never stored here.
  TextColumn get sender => text()();

  /// Raw message text — SENSITIVE; see the class doc comment. Stored
  /// verbatim; the normalization output goes to [normalizedBody].
  TextColumn get body => text()();

  /// SHA-256 hex of body.trim() — [SmsMessage.bodyHash]. The dedup
  /// lookup key; see the index note in the class doc comment.
  TextColumn get bodyHash => text()();

  /// Device-reported receipt time (UTC).
  DateTimeColumn get receivedAt => dateTime()();

  /// Wire name of SmsProcessingStatus — TEXT, model marshals.
  TextColumn get processingStatus => text()();

  /// Wire name of SmsSource — TEXT, model marshals.
  TextColumn get source => text()();

  /// When the local row was created (UTC).
  DateTimeColumn get createdAt => dateTime()();

  /// Normalized text (Phase 07 output) — nullable until the pipeline
  /// runs. Persisted so re-parsing skips re-normalization drift.
  TextColumn get normalizedBody => text().nullable()();

  /// Terminal-state time (UTC) — nullable until then.
  DateTimeColumn get processedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => <Column>{id};
}