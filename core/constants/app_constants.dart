/// Application-wide constants.
///
/// Scope: values shared across MULTIPLE features/layers that belong to
/// the app as a whole. Feature-specific or infra-specific constants
/// live in their own files:
///   - API constants  -> api_constants.dart   (Phase 09)
///   - DB constants   -> db_constants.dart    (Phase 03)
///   - Security       -> security_constants.dart (Phase 04)
///
/// RULE: constants only. No logic, no side effects, no I/O.
library;

class AppConstants {
  AppConstants._();

  // ---------------------------------------------------------------------------
  // App identity
  // ---------------------------------------------------------------------------

  /// Matches the Dart package name (`name:` in pubspec.yaml).
  static const String appName = 'datatade_bank_sms';

  /// Display title is localized — see l10n key `appTitle`.
  /// This constant is only used where a locale-independent identifier
  /// is required (logs, audit metadata, device registration payload).

  /// Current app version as a machine-readable constant.
  /// NOTE: keep in sync with `version:` in pubspec.yaml. It is read by
  /// audit/log records in later phases.
  static const String appVersion = '1.0.0';

  // ---------------------------------------------------------------------------
  // Localization
  // ---------------------------------------------------------------------------

  /// Product base language — also the l10n template locale.
  static const String defaultLanguageCode = 'fa';

  /// Default country code for the Persian locale.
  static const String defaultCountryCode = 'IR';

  /// All supported language codes. First entry is the default.
  static const List<String> supportedLanguageCodes = <String>['fa', 'en'];

  // ---------------------------------------------------------------------------
  // List / pagination defaults (used by repository list queries)
  // ---------------------------------------------------------------------------

  /// Default page size for paged queries (SMS history, transactions, logs).
  static const int defaultPageSize = 20;

  /// Upper bound accepted from UI filters — protects the local DB from
  /// oversized single-shot reads.
  static const int maxPageSize = 100;

  // ---------------------------------------------------------------------------
  // General UI timing (presentation-level, shared by several features)
  // ---------------------------------------------------------------------------

  /// Debounce for search/filter text fields (ms).
  static const int searchDebounceMs = 300;

  /// Default duration for snackbar visibility.
  static const Duration snackbarDuration = Duration(seconds: 3);

  // ---------------------------------------------------------------------------
  // Display formats (locale-safe, consumed by date/currency formatters)
  // ---------------------------------------------------------------------------

  /// Full date-time — used in lists & detail pages.
  static const String displayDateTimeFormat = 'yyyy/MM/dd HH:mm';

  /// Date-only — used in grouped list headers.
  static const String displayDateFormat = 'yyyy/MM/dd';

  /// Time-only — used in same-day rows.
  static const String displayTimeFormat = 'HH:mm';

  // ---------------------------------------------------------------------------
  // SharedPreferences keys
  // ---------------------------------------------------------------------------
  // NOTE: keys are namespaced by prefix to avoid collisions.
  // Secrets NEVER go here — credentials live in secure storage (Phase 04).

  static const String prefsPrefix = 'app.';

  /// Selected UI language ('fa' | 'en').
  static const String prefsKeyLanguage = '${prefsPrefix}settings.language';
}

/// Namespaced keys for [SharedPreferences].
/// Grouped here so key renames never scatter across the codebase.
class PrefsKeys {
  PrefsKeys._();

  /// Selected UI language code — see [AppConstants.prefsKeyLanguage].
  static const String language = AppConstants.prefsKeyLanguage;
}