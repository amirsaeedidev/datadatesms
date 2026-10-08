/// Facet grouping of audit events — consumed by the audit screen's
/// filter chips (Phase 12). Wire names are outbound-only (display
/// grouping may evolve); no fromName needed.
enum AuditEventCategory {
  /// SMS-level ingestion events.
  ingestion('ingestion'),

  /// Parser outcomes.
  parsing('parsing'),

  /// Validate → dedup → create → queue.
  pipeline('pipeline'),

  /// Matching outcomes.
  matching('matching'),

  /// Admin/standing decisions.
  review('review'),

  /// Transmission to the backend.
  sync('sync');

  const AuditEventCategory(this.wireName);

  /// Stable outbound name for logs/UI grouping — never rename.
  final String wireName;
}