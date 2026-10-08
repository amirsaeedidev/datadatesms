import 'package:drift/drift.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';

/// Configurable parser rules per bank — Drift table (parser_rules).
///
/// PHYSICAL mapping of the Phase 02 [ParserRule] entity. Admin
/// config synced from the backend (Phase 09+), cached locally; the
/// Phase 07 RuleMatcher executes from this cache — parsing is NEVER
/// internet-dependent.
///
/// NULLABILITY maps 1:1 to the entity:
///  - [pattern] nullable (keyword rules have none)
///  - [extractionGroup] non-null with default 0
///  - [keywords] JSON array string, default '[]' — always present,
///    possibly empty (entity list is never null)
///  - [validation] JSON object string — typed ParserRuleValidation
///    marshaled by the model layer; 'null' JSON (lowercase) for
///    ParserRuleValidation.empty. Nullable column + JSON-null
///    inside is avoided: empty validation persists as '{}'.
///
/// FROZEN WIRE ENUMS as TEXT: field / ruleType store their wire
/// names ('amount', 'regex', ...) exactly as they arrive from sync
/// — model layer marshals; unknown wire values were already
/// quarantined by the strict fromName parsers at the entity layer.
///
/// PRIORITY TIE-BREAK is a storage concern: the entity locks
/// "priority ASC, ties by id ASC" for deterministic execution order.
/// The UNIQUE index on (bankId, field, priority) enforces at most
/// one rule per (bank, field, priority) slot — making the executed
/// ORDER fully deterministic without relying on id at query time.
class ParserRulesTable extends Table {
  @override
  String get tableName => DbConstants.tableParserRules;

  /// Primary key — [ParserRule.id], backend identifier. TEXT, not
  /// auto-increment (config rows arrive with ids).
  TextColumn get id => text().clientDefault(() => '')();

  /// Owning bank — banks.id. RESTRICT delete: no orphans.
  TextColumn get bankId =>
      text().references(BanksTable, #id, onDelete: KeyAction.restrict)();

  /// Frozen wire name of ParserRuleField ('amount', 'card_number',
  /// 'transaction_type', ...). TEXT; model marshals.
  TextColumn get field => text()();

  /// Frozen wire name of ParserRuleType ('regex' | 'keyword'). TEXT;
  /// model marshals.
  TextColumn get ruleType => text()();

  /// Regex source — nullable 1:1 (keyword rules have no pattern).
  /// Stored verbatim; compiled only in the Phase 07 parser layer.
  TextColumn get pattern => text().nullable()();

  /// Capturing group index — default 0 (whole match).
  IntColumn get extractionGroup => integer().withDefault(const Constant(0))();

  /// Keywords — JSON array string, default '[]'. Always present;
  /// the entity's list is never null.
  TextColumn get keywords => text().withDefault(const Constant('[]'))();

  /// Validation config — JSON object string; '{}' for
  /// ParserRuleValidation.empty. Model marshals the typed class.
  TextColumn get validation => text().withDefault(const Constant('{}'))();

  /// Execution order — LOWER runs first. UNIQUE with (bankId,
  /// field): one rule per slot (the entity's deterministic
  /// tie-break, enforced structurally at storage).
  IntColumn get priority =>
      integer().withDefault(const Constant(100))();

  /// Whether a failed extraction from this rule fails the whole
  /// parse — [ParserRule.isRequired].
  BoolColumn get isRequired => boolean().withDefault(const Constant(false))();

  /// Whether the rule participates in parsing — retained when off
  /// (rollback/history contract from Phase 02).
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  /// Creation time (UTC) — [ParserRule.createdAt].
  DateTimeColumn get createdAt => dateTime()();

  /// Last-update time (UTC) — [ParserRule.updatedAt].
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => <Column>{id};

  @override
  List<String> get uniqueKeys => <List<Column>>[
        <Column>[bankId, field, priority],
      ].map((List<Column> cols) => cols.join('_')).toList();
}