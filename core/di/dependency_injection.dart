import 'package:flutter/foundation.dart';

import 'package:datadadtesms/app/app_router.dart';
import 'package:datadadtesms/core/database/app_database.dart';

/// Application-wide dependency container — the single COMPOSITION ROOT.
///
/// Pattern: explicit, typed service locator (hand-rolled — no get_it,
/// no reflection, no codegen). Every dependency the app uses is:
///   - constructed HERE, in dependency order,
///   - exposed through a typed getter,
///   - resolved by consumers via constructor injection from the
///     registration point (providers in `app_providers.dart`).
///
/// REGISTRATION ORDER (locked — mirrors the roadmap):
///   Core infra  (router, database)                    Phase 01/03
///   Security & logging services                       Phase 04
///   DataSources (native bridge)                       Phase 05+
///   Repositories / Engines / UseCases                 Phase 03 Step 03.6+
///   Providers are NOT stored here — they are created
///   lazily in `app_providers.dart` (Phase 11).
///
/// RULES:
///  - No business logic here. Construction + lifetime only.
///  - Getters throw [StateError] if read before [initialize] —
///    wiring mistakes must be loud, never silent nulls.
///  - [resetForTesting] exists so tests get a clean container.
class DependencyInjection {
  DependencyInjection._();

  // ---------------------------------------------------------------------------
  // Singleton access
  // ---------------------------------------------------------------------------

  static final DependencyInjection instance = DependencyInjection._();

  // ---------------------------------------------------------------------------
  // Core infrastructure — private fields, typed getters
  // ---------------------------------------------------------------------------

  AppRouter? _appRouter;

  /// Central navigator configuration (root navigator key owner).
  AppRouter get appRouter => _notReady(_appRouter, 'appRouter');

  AppDatabase? _appDatabase;

  /// The offline-first local store (Drift over SQLite).
  ///
  /// LIFECYCLE: constructed eagerly in [initialize] but OPENED
  /// LAZILY by Drift on the first query — construction costs
  /// nothing until the pipeline actually reads. Closed in [dispose]
  /// (reverse order: DB closes BEFORE infra fields are nulled).
  ///
  /// TESTS: construct their own `AppDatabase(NativeDatabase.memory())`
  /// instance directly — they do NOT use this getter (the production
  /// file-backed connection is not what schema/CRUD tests verify).
  AppDatabase get appDatabase => _notReady(_appDatabase, 'appDatabase');

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  /// Builds the dependency graph. Must complete before the first frame
  /// (called with `await` in `main.dart`).
  Future<void> initialize() async {
    // ------------------------------------------------------------------
    // Phase 01 — App bootstrap
    // ------------------------------------------------------------------
    _appRouter = AppRouter();

    // ------------------------------------------------------------------
    // Phase 03 — Local database (Drift).
    // Lazily opened by Drift on first query; migration strategy and
    // schema versioning live in database_migrations.dart / db_constants.
    // ------------------------------------------------------------------
    _appDatabase = AppDatabase();

    // ------------------------------------------------------------------
    // Phase 04 — Security & logging services — appended here:
    //   _secureStorageService = SecureStorageService();
    //   _hashUtils / _maskService = ...
    //   _appLogger = AppLogger(...);
    //   _auditLogger = AuditLogger(...);
    //
    // Phase 03 Step 03.6+ — Repositories — appended here in
    // dependency order (they consume appDatabase).
    //
    // Phase 05+ — DataSources / Engines / UseCases — appended per phase.
    // ------------------------------------------------------------------
  }

  /// Releases every owned resource — REVERSE order of [initialize]:
  /// the database (which may have in-flight statements) closes
  /// BEFORE infrastructure fields are nulled.
  Future<void> dispose() async {
    await _appDatabase?.close();
    _appDatabase = null;
    _appRouter = null;
  }

  /// Wipes the container so a test can start from a clean slate.
  ///
  /// Usage in tests:
  ///   setUp(() { DependencyInjection.resetForTesting(); });
  @visibleForTesting
  static void resetForTesting() {
    instance._appRouter = null;
    instance._appDatabase = null;
    // Future phases null-out their fields here as well.
  }

  // ---------------------------------------------------------------------------
  // Internals
  // ---------------------------------------------------------------------------

  /// Guard helper — turns "accessed before initialize" into a loud,
  /// descriptive [StateError] instead of a silent null crash later.
  T _notReady<T>(T? value, String name) {
    if (value == null) {
      throw StateError(
        'DependencyInjection.$name accessed before initialize(). '
        'Ensure DependencyInjection.instance.initialize() completed '
        'in main() before the first frame.',
      );
    }
    return value;
  }
}