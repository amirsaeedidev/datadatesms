import 'package:drift/drift.dart';

/// One migration step of the schema chain — applies the transition
/// FROM version `key` TO version `key + 1`.
typedef MigrationStep = FutureOr<void> Function(Migrator m);

/// Migration infrastructure of the local store — Phase 03.
///
/// Owns EVERYTHING that happens to a PRE-EXISTING database between
/// versions. Fresh installs never touch this class's steps — they
/// are created at head by `createAll` (the birth handler).
///
/// THE BUMP RULE (locked in db_constants.dart, executed here):
///  1. every schema change bumps DbConstants.schemaVersion by +1
///  2. AND registers its step in [_steps] keyed by the FROM version
///  3. no step, no bump — a version without its step throws (the
///     broken-chain guard below), because guessing a migration on a
///     financial store is never acceptable.
///
/// DESTRUCTIVE MIGRATIONS (dropping/renaming user data) are a last
/// resort and require an explicit audit note inside the step body —
/// this store is the offline source of truth; losing it means
/// losing unsynced financial records.
///
/// v1 STATE: the registry is EMPTY — v1 is the birth schema. The
/// rails below are the contract; the first real step (v1→v2) lands
/// with the first schema change of a later phase.
///
/// Phase 04 NOTE: per-step progress logging will hook
/// MigrationStrategy.onStepFinished when AppLogger exists — noted
/// here so the wiring point is not reinvented then.
class DatabaseMigrations {
  const DatabaseMigrations();

  /// Step registry, keyed by FROM-version. Static-method tear-offs
  /// keep this const-constructible.
  ///
  /// ```dart
  /// // Example — the first real step (v1 → v2):
  /// // static Future<void> _v1ToV2(Migrator m) async {
  /// //   // AUDIT NOTE: additive only — no data dropped.
  /// //   // await m.addColumn(transactions, transactions.newCol);
  /// // }
  /// ```
  static const Map<int, MigrationStep> _steps = <int, MigrationStep>{
    // 2: _v1ToV2,
  };

  /// Builds the complete [MigrationStrategy] for [db] — the single
  /// strategy definition; AppDatabase delegates to this.
  ///
  /// Takes the database as [GeneratedDatabase] (drift type) — no
  /// import of AppDatabase needed, keeping this file decoupled from
  /// the bootstrap class (no circular wiring).
  MigrationStrategy strategy({required GeneratedDatabase db}) =>
      MigrationStrategy(
        // FRESH INSTALL: birth at head version — wholesale creation.
        onCreate: (Migrator m) => m.createAll(),

        // PRE-EXISTING INSTALL: walk the chain step by step, from
        // the stored version up to head.
        onUpgrade: (Migrator m, int from, int to) async {
          for (int v = from; v < to; v++) {
            final MigrationStep? step = _steps[v];
            if (step == null) {
              // BROKEN-CHAIN GUARD — BUMP RULE violation. Refusing
              // beats guessing on a financial store: a silent skip
              // would leave the schema half-migrated.
              throw StateError(
                'Broken migration chain: no step from v$v to v${v + 1} '
                '(installed: v$from, head: v$to). A schema bump without '
                'its step violates the BUMP RULE.',
              );
            }
            await step(m);
          }
        },

        // Runs on EVERY connection open (both fresh and migrated):
        // SQLite ships with foreign-key enforcement OFF per
        // connection — the RESTRICT chains of the config/ingestion
        // spine only mean something with this pragma on.
        beforeOpen: (Migrator m, OpeningDetails details) async {
          await db.customStatement('PRAGMA foreign_keys = ON');
        },
      );
}