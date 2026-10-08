import 'package:drift/drift.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';

/// Bank configuration rows — Drift table (banks).
///
/// PHYSICAL mapping of the Phase 02 [Bank] entity. Config data
/// SYNCED from the backend and cached locally (Phase 09+): this
/// table is a mirror, not a source — writes happen only through
/// BankRepository implementations when configs arrive, and
/// enable/disable mutations from the Phase 11 review flows.
///
/// NULLABILITY maps 1:1 to the entity: only [parserVersion] and the
/// timestamps are entity-nullable. [detectionKeywords] is stored as
/// a JSON array string — the model layer marshals List<String> ↔
/// JSON (the entity never sees storage shapes).
///
/// NO createdAt/updatedAt drift helpers — timestamps are explicit
/// columns written by the model layer from entity values, so the
/// entity remains the single source of truth for time semantics
/// (no hidden auto-now magic that can drift from wire data).
class BanksTable extends Table {
  @override
  String get tableName => DbConstants.tableBanks;

  /// Primary key — [Bank.id], the stable backend identifier.
  /// TEXT because bank rows are backend-authored (their UUIDs).
  /// Not auto-increment: config rows arrive with ids, never
  /// generated locally.
  TextColumn get id => text().clientDefault(() => '')();

  /// Stable wire code ('MELLAT', 'MELLI', ...) — [Bank.code].
  /// Unique: two banks sharing a code would corrupt parser-registry
  /// lookup (one bank per code, by contract).
  TextColumn get code => text().unique()();

  /// Display name snapshot — [Bank.name]. Plain TEXT; Persian
  /// names stored/compared as-is (no case folding).
  TextColumn get name => text()();

  /// Wire name of BankParserType ('dedicated' | 'configurable') —
  /// persisted as TEXT; model layer marshals the enum. Deliberately
  /// NOT an int-mapped enum: wire values arrive from backend sync.
  TextColumn get parserType => text()();

  /// Whether the app processes SMS for this bank — [Bank.isEnabled].
  BoolColumn get isEnabled => boolean().withDefault(const Constant(false))();

  /// Parser version tag — [Bank.parserVersion]. Nullable 1:1.
  TextColumn get parserVersion => text().nullable()();

  /// Detection keywords — [Bank.detectionKeywords] as a JSON array
  /// string ('["ملت","Mellat"]'). Empty array = no keyword fallback;
  /// NOT null (the entity's list is always present, possibly empty).
  TextColumn get detectionKeywords =>
      text().withDefault(const Constant('[]'))();

  /// Creation time (UTC) — [Bank.createdAt].
  DateTimeColumn get createdAt => dateTime()();

  /// Last-config-update time (UTC) — [Bank.updatedAt].
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => <Column>{id};
}