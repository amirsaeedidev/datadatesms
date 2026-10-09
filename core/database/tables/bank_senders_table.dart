import 'package:drift/drift.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';
import 'package:datadadtesms/core/database/tables/banks_table.dart';

/// Registered sender addresses per bank — Drift table
/// (bank_senders).
///
/// PHYSICAL mapping of the Phase 02 [BankSender] entity. Config
/// rows synced from the backend like banks: a mirror, not a source.
///
/// FK CHAIN (this is the anchor of the whole referential spine):
///  - bank_senders.bank_id → banks.id (RESTRICT: never orphan rows
///    by cascade-deleting bank config — deleting banks is not a
///    flow in this product; rows are retained for audit).
///
/// CANONICAL FORM contract (from the entity): [sender] stores
/// digits-only canonical form for numeric addresses, lowercase for
/// alphanumeric sender IDs. The CANONICALIZATION itself runs in
/// MessageNormalizer (Phase 07) BEFORE storage — this table only
/// receives already-canonical values. Persisting canonical form
/// makes the BankDetector's lookup an exact/prefix compare against
/// a normalized input, with no per-row scrubbing at query time.
///
/// matchType is stored as the wire TEXT ('exact' | 'prefix'); model
/// layer marshals the enum — same convention as banks.parserType.
class BankSendersTable extends Table {
  @override
  String get tableName => DbConstants.tableBankSenders;

  /// Primary key — [BankSender.id], backend identifier. TEXT
  /// (config rows arrive with ids). Not auto-increment.
  TextColumn get id => text().clientDefault(() => '')();

  /// Owning bank — banks.id. RESTRICT delete: no orphans; bank rows
  /// are never deleted anyway (retained for audit).
  TextColumn get bankId =>
      text().references(BanksTable, #id, onDelete: KeyAction.restrict)();

  /// Canonical sender address — already normalized by the time it is
  /// stored (see the class doc comment).
  TextColumn get sender => text()();

  /// Wire name of BankSenderMatchType ('exact' | 'prefix') — model
  /// layer marshals the enum.
  TextColumn get matchType => text()();

  /// Whether this sender participates in detection —
  /// [BankSender.isEnabled]. Default false: freshly synced rows are
  /// invisible until explicitly enabled (safe-by-default).
  BoolColumn get isEnabled => boolean().withDefault(const Constant(false))();

  /// Optional human note — [BankSender.label]. Nullable 1:1.
  TextColumn get label => text().nullable()();

  /// Creation time (UTC) — [BankSender.createdAt].
  DateTimeColumn get createdAt => dateTime()();

  /// Last-update time (UTC) — [BankSender.updatedAt].
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => <Column>{id};
}