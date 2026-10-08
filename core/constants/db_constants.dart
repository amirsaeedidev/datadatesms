/// Local-database constants — core constants, Phase 03.
///
/// The single vocabulary for the offline store (Drift/SQLite):
/// database name, schema version, and the table names. Column names
/// are NOT declared here — they live inside the Drift table classes
/// (compile-checked named parameters; centralizing 100+ column
/// strings would add noise, not safety).
///
/// SCHEMA VERSIONING CONTRACT (locked at Phase 03 head):
///  - [schemaVersion] is the SINGLE SOURCE; AppDatabase reads it
///    (`schemaVersion => DbConstants.schemaVersion`). The pairing
///    cannot be analyzer-checked across files, so it is documented
///    here, mirrored in app_database.dart, and pinned by the schema
///    tests that close this phase's gate.
///  - BUMP RULE: every schema change — new table, new column, index,
///    constraint, nullability change — increments the version by
///    exactly 1 AND ships a matching step in database_migrations.dart.
///  - The version NEVER decreases. A fresh install creates the
///    database directly at head version (the migration chain is
///    walked only by pre-existing installs).
///  - Destructive migrations (dropping user data) are a last resort
///    and require an explicit audit note inside the migration step —
///    this store is the OFFLINE source of truth; losing it means
///    losing unsynced financial records.
///
/// TABLE NAMES are centralized here because they have multiple
/// consumers: the Drift `tableName` getters in
/// core/database/tables/, rare ad-hoc raw queries (repos), and the
/// schema/migration tests. Renaming any of these after first release
/// orphans existing installs — never rename.
///
/// THE LOGS SPLIT (structural decision, Phase 03 head): the tree
/// allocates ONE file (logs_table.dart) which hosts TWO table
/// classes — `logs` (technical, AppLogger) and `audit_events`
/// (financial, AuditLogger). Phase 02 locked LogEvent and AuditEvent
/// as DISJOINT contracts with different fields; one physical table
/// would force sparse always-null columns and mix the two systems
/// the disjointness contract exists to keep apart. File = tree;
/// tables = contracts.
///
/// NOT TABLE NAMES — the sync queue's `entity_type` values
/// ('transaction', 'pending_transaction' — singular, owned by the
/// sync usecases per the Phase 02.6 lock) are a DIFFERENT
/// vocabulary and deliberately absent here: conflating them would
/// couple the wire contract to storage naming.
library;

class DbConstants {
  DbConstants._();

  // -------------------------------------------------------------------------
  // Database identity
  // -------------------------------------------------------------------------

  /// Logical database name. `driftDatabase(name:)` (drift_flutter)
  /// creates the physical file `<databaseName>.sqlite` inside the
  /// platform databases directory. Never rename after first release
  /// — it orphans existing installs' data.
  static const String databaseName = 'datadadtesms';

  /// Current schema version — pairs with AppDatabase.schemaVersion
  /// (single source: AppDatabase reads this constant).
  static const int schemaVersion = 1;

  // -------------------------------------------------------------------------
  // Table names — configuration (backend-synced, cached locally)
  // -------------------------------------------------------------------------

  /// Bank configuration rows.
  static const String tableBanks = 'banks';

  /// Registered sender addresses per bank.
  static const String tableBankSenders = 'bank_senders';

  /// Configurable parser rules per bank.
  static const String tableParserRules = 'parser_rules';

  // -------------------------------------------------------------------------
  // Table names — ingestion & financial records
  // -------------------------------------------------------------------------

  /// Ingested SMS messages (raw body + hash + processing state).
  static const String tableSmsMessages = 'sms_messages';

  /// THE financial records — created only by the Phase 08 pipeline.
  static const String tableTransactions = 'transactions';

  /// Expected-payment records (backend-authored, cached for matching).
  static const String tablePendingTransactions = 'pending_transactions';

  /// Match evaluations (Transaction × PendingTransaction pairs).
  static const String tableMatchingRecords = 'matching_records';

  // -------------------------------------------------------------------------
  // Table names — transmission & logging
  // -------------------------------------------------------------------------

  /// The outbound transmission queue (offline-first durability).
  static const String tableSyncQueue = 'sync_queue';

  /// Technical log entries (AppLogger). Co-located with
  /// [tableAuditEvents] in the tree's logs_table.dart — see THE
  /// LOGS SPLIT in the library doc above.
  static const String tableLogs = 'logs';

  /// Financial audit entries (AuditLogger) — DISJOINT from technical
  /// logs by the Phase 02 contract; a separate physical table is the
  /// storage expression of that disjointness.
  static const String tableAuditEvents = 'audit_events';
}