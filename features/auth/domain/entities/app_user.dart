import 'package:equatable/equatable.dart';

import 'package:datadadtesms/features/auth/domain/entities/user_role.dart';

/// Signed-in account of the application — auth domain entity.
///
/// Contract locked in Phase 02:
///  - Pure domain: no Flutter, no Supabase SDK, no serialization here.
///    Wire mapping lives in the data layer (`AuthUserModel`, Phase 09+)
///    — "Serialization is separate from Domain Model".
///  - SECURITY: credentials/tokens NEVER live on this entity.
///    Tokens belong to SecureStorage (Phase 04); the entity carries
///    identity + role only.
///  - `deviceId` is intentionally NOT part of the user: it is a
///    device property carried by SmsMessage / Transaction / API DTOs.
class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.email,
    this.fullName,
  });

  /// Sentinel user for the bootstrap window — used by AuthProvider
  /// (Phase 11) while the persisted session is being restored and it
  /// is not yet known whether a user is signed in.
  ///
  /// Detectable via [isInitializing]; everywhere else in the app an
  /// [AppUser] is guaranteed to be a REAL account (non-empty [id]).
  factory AppUser.initializing() => AppUser(
        id: '',
        role: UserRole.viewer,
        createdAt: DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
      );

  /// Stable unique identifier of the account (backend/Supabase user id).
  /// Empty ONLY on the [initializing] sentinel.
  final String id;

  /// Email of the account — nullable: device-credential sign-in
  /// may not expose an email.
  final String? email;

  /// Display name of the account — optional.
  final String? fullName;

  /// Authorization role of the account.
  final UserRole role;

  /// When the account was created (UTC).
  final DateTime createdAt;

  /// When the account was last updated (UTC).
  final DateTime updatedAt;

  /// True while this is the [AppUser.initializing] sentinel —
  /// i.e. session state is still being resolved at bootstrap.
  bool get isInitializing => id.isEmpty;

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: passing `null` does NOT clear a field — copyWith only
  /// overwrites with non-null values. This entity has no use-case
  /// for clearing to null after creation.
  AppUser copyWith({
    String? id,
    String? email,
    String? fullName,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        email,
        fullName,
        role,
        createdAt,
        updatedAt,
      ];
}