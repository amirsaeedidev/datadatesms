import 'package:datadadtesms/features/auth/domain/entities/app_user.dart';

/// Authentication contract — auth domain repository (abstract
/// interface; the impl `auth_repository_impl.dart` — local session
/// restore + the Supabase-backed remote datasource — lands with
/// Phase 09, when backend wiring begins).
///
/// WHAT THIS IS (locked): the SESSION surface — sign in, sign out,
/// current user, session refresh. AuthProvider (Phase 11) consumes
/// exactly these four through its usecases.
///
/// WHAT IT IS NOT:
///  - NO credential types in method signatures: [signIn] takes the
///    raw email/password pair and the IMPL forwards them to the
///    remote datasource — credentials never become entities, never
///    get stored on any object, never appear in logs (the Phase 02
///    AppUser lock: tokens/credentials are NOT domain data).
///  - NO token access: token storage/refresh mechanics are the
///    impl's business via SecureStorage (Phase 04) + the remote
///    datasource. Nothing above this interface ever touches a
///    token.
///
/// BOOTSTRAP SEMANTICS (pairs with AppUser.initializing, Phase 02):
///  - [currentUser] returns null when NO persisted session exists —
///    distinct from "session not yet restored" (that is the
///    initializing-sentinel phase ABOVE this repository, in the
///    provider's restore flow).
///  - [refreshSession] returns null when the persisted session is
///    expired/dead — the provider maps that to unauthenticated.
///
/// ERROR CONTRACT (same lock as BankRepository): implementations
/// THROW typed exceptions (ApiException/NetworkException family,
/// Phase 04/09) — wrong credentials, network down, expired session
/// each surface as their own typed error; signatures FINAL, no
/// Result/Failure; usecases wrap for providers.
///
/// Pure domain: no Supabase, no dio, no SecureStorage types — the
/// entity and nothing else.
abstract interface class AuthRepository {
  /// Signs in with email + password. Returns the signed-in user on
  /// success; throws the typed wrong-credentials exception on
  /// failure. The IMPL persists the session (SecureStorage) —
  /// credentials themselves are never persisted anywhere.
  Future<AppUser> signIn({
    required String email,
    required String password,
  });

  /// Signs out and clears the persisted session. Idempotent —
  /// signing out with no session is a no-op, never an error.
  Future<void> signOut();

  /// The persisted session's user, if a session EXISTS.
  /// Null = no session (see the bootstrap semantics in the class
  /// doc comment). Local-first: no network round-trip on the
  /// restore path.
  Future<AppUser?> currentUser();

  /// Validates/refreshes the persisted session against the backend.
  /// Returns the refreshed user, or null when the session is dead —
  /// the caller decides the unauthenticated transition.
  Future<AppUser?> refreshSession();
}