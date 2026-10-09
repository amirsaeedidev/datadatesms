import 'package:drift/drift.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';
import 'package:datadadtesms/core/database/tables/banks_table.dart';
import 'package:datadadtesms/core/database/tables/sms_messages_table.dart';

/// THE financial records — Drift table (transactions).
///
/// PHYSICAL mapping of the Phase 02 [Transaction] entity. Records
/// exist ONLY after the Phase 08 pipeline (validation + dedup
/// passed) — this table is, by construction, "money that actually
/// happened".
///
/// DUPLICATE PREVENTION — three structural locks (the Phase 02
/// contract expressed in storage):
///  1. [dedupKey] UNIQUE — the engine check is the first line of
///     defense; this constraint is the LAST. A second record with
///     the same canonical key is impossible at the storage level,
///     not just unlikely.
///  2. [smsId] UNIQUE — one SMS produces at most one record (the
///     entity contract); enforced here even if a future engine bug
///     tried otherwise.
///  3. [serverTransactionId] UNIQUE (nullable — SQLite allows many
///     NULLs) — two local records can never claim the same backend
///     identity. Set once by SyncEngine (Phase 10).
///
/// SNAPSHOT SEMANTICS (Phase 02): [bankName] / [parserVersion] are
/// captured at creation. Later admin config changes do NOT rewrite
/// existing records — this table is historical evidence.
///
/// WIRE ENUMS as TEXT: type / currency / status store their wire
/// names; model layer marshals (strict fromName already quarantined
/// unknown values at the entity layer).
///
/// NO sync/match state here — the three-way separation (record
/// standing vs transmission vs matching) lives in three tables:
/// this one carries ONLY the record standing.
@TableIndex(
  name: 'ix_transactions_timestamp',
  columns: <String>['timestamp'],
)
@TableIndex(
  name: 'ix_transactions_reference_number',
  columns: <String>['referenceNumber'],
)
class TransactionsTable extends Table {
  @override
  String get tableName => DbConstants.tableTransactions;

  /// Primary key — [Transaction.id], locally generated UUID. Also
  /// the Idempotency-Key of the send path (Phase 09). TEXT, not
  /// auto-increment.
  TextColumn get id => text().clientDefault(() => '')();

  /// Source SMS — sms_messages.id. RESTRICT delete (messages are
  /// audit-retained anyway). UNIQUE: one SMS → at most one record.
  TextColumn get smsId =>
      text().references(SmsMessagesTable, #id, onDelete: KeyAction.restrict)();

  /// Capturing device — [Transaction.deviceId].
  TextColumn get deviceId => text()();

  /// Bank config row — banks.id. RESTRICT delete. Soft reference for
  /// local relations; the RESILIENCE identity is [bankCode].
  TextColumn get bankId =>
      text().references(BanksTable, #id, onDelete: KeyAction.restrict)();

  /// Stable bank wire code ('MELLAT') — survives bank-row re-syncs;
  /// powers the API bank_code payload.
  TextColumn get bankCode => text()();

  /// Bank display name SNAPSHOT at creation — lists render without
  /// a join; historical records keep the name that was true then.
  TextColumn get bankName => text()();

  /// Wire name of TransactionType ('deposit', ...) — model marshals.
  TextColumn get type => text()();

  /// Amount in the smallest unit (rials) — non-negative integer;
  /// sign implied by type (never stored separately).
  IntColumn get amount => integer()();

  /// ISO-4217 style code ('IRR') — model marshals.
  TextColumn get currency => text()();

  /// Transaction time (UTC) — from the message body or receive-time
  /// fallback. Indexed: default sort of the transactions screens.
  DateTimeColumn get timestamp => dateTime()();

  /// Already-masked card ('6037********1234') — masked at the
  /// extraction boundary; a full PAN never existed past the parser.
  TextColumn get cardNumberMasked => text().nullable()();

  /// Account number, verbatim — nullable 1:1.
  TextColumn get accountNumber => text().nullable()();

  /// Bank reference, verbatim (leading zeros kept) — nullable 1:1.
  /// Indexed: findByReference lookup.
  TextColumn get referenceNumber => text().nullable()();

  /// Bank trace, verbatim — nullable 1:1.
  TextColumn get traceNumber => text().nullable()();

  /// Post-transaction balance (smallest unit) — nullable 1:1.
  IntColumn get balance => integer().nullable()();

  /// Deterministic parse score 0.0..1.0 — the number sent as
  /// "confidence" in the API payload.
  RealColumn get confidenceScore => real()();

  /// Wire name of TransactionStatus ('pending'|'confirmed'|
  /// 'rejected') — model marshals. Created only as 'pending'.
  TextColumn get status => text()();

  /// Canonical duplicate-prevention key (DeduplicationEngine,
  /// Phase 08) — UNIQUE: the storage-level last line of defense.
  TextColumn get dedupKey => text().unique()();

  /// SHA-256 of the source SMS — the safe lineage reference; the
  /// raw body never travels past this table's inputs.
  TextColumn get sourceSmsHash => text()();

  /// Parser version SNAPSHOT at creation — the parser-config audit
  /// chain.
  TextColumn get parserVersion => text()();

  /// Backend identifier — set ONCE on acceptance; immutable after.
  /// Nullable-UNIQUE (SQLite: many NULLs allowed) — two records can
  /// never claim the same server identity.
  TextColumn get serverTransactionId => text().nullable().unique()();

  /// When the record was created (UTC).
  DateTimeColumn get createdAt => dateTime()();

  /// When last mutated (UTC) — refreshed by any standing/lineage
  /// change.
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => <Column>{id};
}