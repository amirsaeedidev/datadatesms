/// User roles of the system — auth domain.
///
/// Contract locked in Phase 02:
///  - [admin]    full access: banks, parser rules, approvals, settings
///  - [operator] daily operations: review/approve transactions & matches
///  - [viewer]   read-only access
///
/// [wireName] is the stable serialization contract used by the data
/// layer (models / API DTOs in Phase 09). Dart identifier names may
/// evolve freely — wire names must NEVER change once shipped.
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
enum UserRole {
  /// Full access — banks, parser rules, approvals, settings.
  admin('admin'),

  /// Daily operations — review and approve transactions / matches.
  operator('operator'),

  /// Read-only access.
  viewer('viewer');

  const UserRole(this.wireName);

  /// Stable wire/serialization name — never rename existing values.
  final String wireName;

  /// Parses a serialized role name coming from local storage or the
  /// backend.
  ///
  /// SECURITY: null / unrecognized values fall back to [fallback]
  /// (least privilege: [UserRole.viewer] by default). An unknown role
  /// from the backend must NEVER escalate permissions.
  static UserRole fromName(
    String? name, {
    UserRole fallback = UserRole.viewer,
  }) {
    if (name == null) {
      return fallback;
    }
    for (final UserRole role in UserRole.values) {
      if (role.wireName == name) {
        return role;
      }
    }
    return fallback;
  }
}