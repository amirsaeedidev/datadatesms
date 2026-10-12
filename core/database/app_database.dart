import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';
import 'package:datadadtesms/core/database/database_migrations.dart';
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
/// LIFECYCLE: single app-lifetime instance in DI (lazy-constructed
/// on first access); Drift opens the connection lazily on the first
/// query. Tests inject an in-memory executor directly.
///
/// SCHEMA VERSIONING: [schemaVersion] pairs with
/// DbConstants.schemaVersion (the BUMP RULE — see db_constants).
/// Fresh installs create at head via the strategy's onCreate; the
/// migration chain (database_migrations.dart) owns pre-existing
/// installs.
///
/// WHAT THIS IS NOT: no repositories, no business logic — pure
/// storage wiring.
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
  /// Production: no argument — the drift_flutter connection (native
  /// sqlite3 library + file placement). Tests: pass an in-memory
  /// executor (NativeDatabase.memory) — no plugins involved.
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: DbConstants.databaseName));

  /// Single source: DbConstants.schemaVersion (the BUMP RULE pair).
  @override
  int get schemaVersion => DbConstants.schemaVersion;

  /// Single strategy definition lives in DatabaseMigrations —
  /// birth (createAll), the version chain, and the FK pragma that
  /// makes every RESTRICT constraint real.
  @override
  MigrationStrategy get migration =>
      const DatabaseMigrations().strategy(db: this);
}