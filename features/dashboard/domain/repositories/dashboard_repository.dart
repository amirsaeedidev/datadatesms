import 'package:datadadtesms/features/dashboard/domain/entities/dashboard_data.dart';

/// Aggregation contract of the dashboard — dashboard domain
/// repository (abstract interface; the Drift-backed impl
/// `dashboard_repository_impl.dart` lands with the dashboard phase).
///
/// ONE METHOD BY DESIGN: the dashboard reads a SNAPSHOT of the
/// persisted state — [getDashboardData] runs all the counts and
/// returns one [DashboardData]. No filters, no pagination, no
/// per-tile queries: the screen refreshes as a whole, so the
/// contract refreshes as a whole.
///
/// ATOMICITY (impl responsibility, locked here): the impl wraps all
/// count queries in ONE database transaction, so the snapshot is
/// internally CONSISTENT — no tile pair ever disagrees because one
/// count ran a moment later than another (a pipeline write landing
/// between two separate queries would produce e.g. smsProcessed=10
/// with transactionsTotal=9 — an impossible state rendered as
/// truth).
///
/// RUNTIME TILES ARE NOT HERE (the entity's scope lock): reader
/// running / connectivity / permission state are composed ABOVE by
/// the GetDashboardData usecase from their owning services. This
/// repository answers ONLY what the local database knows.
///
/// PERFORMANCE NOTE: all counts are single-column COUNTs over
/// indexed status columns (the Phase 03 indexes) — the snapshot is
/// cheap; the refresh POLICY (pull-to-refresh, periodic, on-resume)
/// is a provider concern, never a repository concern.
///
/// ERROR CONTRACT (same lock as BankRepository): implementations
/// THROW typed exceptions (DatabaseException family, Phase 04);
/// signatures FINAL, no Result/Failure; usecases wrap for providers.
///
/// Pure domain: no Drift, no Table types — the read model only.
abstract interface class DashboardRepository {
  /// The consistent persisted-state snapshot — every dashboard tile
  /// that derives from the local database, in one call.
  Future<DashboardData> getDashboardData();
}