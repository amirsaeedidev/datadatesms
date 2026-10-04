import 'package:flutter/foundation.dart';

import 'package:datadadtesms/app/app_router.dart';

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
///   Core infra  (router, logger, security)          Phase 01/04
///   DataSources (drift DB, native bridge)           Phase 03/05
///   Repositories                                     Phase 03+
///   Engines / Services (parser, matching, sync)      Phase 07/10
///   UseCases                                         Phase 06+
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

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  /// Builds the dependency graph. Must complete before the first frame
  /// (called with `await` in `main.dart`).
  ///
  /// Phase 01: only the router exists. Each later phase APPENDS its
  /// registrations in dependency order — nothing is ever constructed
  /// before its own dependencies are ready.
  Future<void> initialize() async {
    // ------------------------------------------------------------------
    // Phase 01 — App bootstrap
    // ------------------------------------------------------------------
    _appRouter = AppRouter();

    // ------------------------------------------------------------------
    // Phase 03 — Local database (Drift) — appended here:
    //   _appDatabase = AppDatabase();
    //   (Drift opens the connection lazily on first query.)
    //
    // Phase 04 — Security & logging — appended here:
    //   _secureStorageService = SecureStorageService();
    //   _appLogger = AppLogger(...);
    //
    // Phase 03+ — DataSources / Repositories / Engines / UseCases —
    // appended in strict dependency order, one block per phase.
    // ------------------------------------------------------------------
  }

  /// Releases every owned resource. Called on app teardown —
  /// in later phases this also closes the database and stops engines.
  Future<void> dispose() async {
    // ------------------------------------------------------------------
    // Reverse order of initialize(). Appended phase by phase:
    //
    //   await _appDatabase?.close();   // Phase 03
    // ------------------------------------------------------------------
    _appRouter = null;
  }

  /// Wipes the container so a test can start from a clean slate.
  ///
  /// Usage in tests:
  ///   setUp(() { DependencyInjection.resetForTesting(); });
  @visibleForTesting
  static void resetForTesting() {
    instance._appRouter = null;
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