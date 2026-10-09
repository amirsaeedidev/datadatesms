import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';
import 'package:datadadtesms/core/database/tables/banks_table.dart';
import 'package:datadadtesms/core/database/tables/bank_senders_table.dart';
import 'package:datadadtesms/core/database/tables/parser_rules_table.dart';
import 'package:datadadtesms/core/database/tables/sms_messages_table.dart';
import 'package:datadadtesms/core/database/tables/transactions_table.dart';
import 'package:datadadtesms/core/database/tables/pending_transactions_table.dart';
import 'package:datadadtesms/core/database/tables/matching_records_table.dart';
import 'package:datadadtesms/core/database/tables/sync_queue_table.dart';
import 'package:datadadtesms/core/database/tables/logs_table.dart';

part 'app_database.g.dart';

/// The offline-first local store — Drift database over SQLite.
///
/// BOOTSTRAP (Phase 03 contract):
///  - Single app-lifetime instance, owned by the DI container
///    (registered in initialize(); closed in dispose()).
///  - Connection via `driftDatabase()` (drift_flutter) — it handles
///    the native sqlite3 library loading AND the database file
///    placement (platform databases dir, `<databaseName>.sqlite`).
///    The bundled-native-library question was settled at Phase 03
///    head by this choice.
///  - OPENED LAZILY by Drift on the first query — constructing this
///    class in DI costs nothing until the pipeline actually reads.
///
/// SCHEMA VERSIONING (the BUMP RULE, locked in db_constants.dart):
///  - [schemaVersion] MUST stay paired with
///    DbConstants.schemaVersion (single source: this reads that).
///  - Every schema change: +1 version AND a matching step in
///    database_migrations.dart — the file next to this one.
///  - Fresh installs create the schema directly at head (v1 today);
///    the migration chain is walked only by pre-existing installs.
///
/// WHAT THIS CLASS IS NOT: no repositories, no business logic, no
/// feature imports beyond the table classes — it is pure storage
/// wiring. Data access flows through datasources/repositories
/// (Phase 03 Step 03.6 + feature phases).
@DriftDatabase(
  tables: <Type>[
    BanksTable,
    BankSendersTable,
    ParserRulesTable,
    SmsMessagesTable,
    TransactionsTable,
    PendingTransactionsTable,
    MatchingRecordsTable,
    SyncQueueTable,
    LogsTable,
    AuditEventsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: DbConstants.databaseName));

  /// Single source: DbConstants.schemaVersion (the BUMP RULE pair —
  /// see the class doc comment).
  @override
  int get schemaVersion => DbConstants.schemaVersion;

  /// FRESH-INSTALL PATH ONLY (v1): creates every table at head.
  ///
  /// The MIGRATION PATH (v1→v2→...) for pre-existing installs is
  /// NOT onStepCreate — it lives in database_migrations.dart
  /// (migration steps + the strategy runner). This override stays
  /// the minimal, verifiable "birth" handler; the migration file
  /// owns everything that happens AFTER birth.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
      );
}