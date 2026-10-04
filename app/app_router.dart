import 'package:flutter/material.dart';

import 'package:datadadtesms/core/constants/app_constants.dart';
import 'package:datadadtesms/l10n/app_localizations.dart';

/// Named-route contract of the application — locked in Phase 01.
///
/// Route NAMES are the contract; route BUILDERS are registered in
/// [AppRouter.onGenerateRoute] as their owning phases land:
///
///   auth / permissions  -> Phase 11 / 12
///   main shell screens  -> Phase 12
///
/// Navigating to a route whose builder is not registered yet falls
/// through to [AppRouter.onUnknownRoute] — never a blank screen.
abstract final class AppRoutes {
  /// Bootstrap / splash — initial route. Builder lands in Phase 12.
  static const String splash = '/';

  // ---- Auth (Phase 11/12) ----
  static const String login = '/login';

  // ---- Permission onboarding (Phase 11/12) ----
  static const String permissions = '/permissions';

  // ---- Main shell (Phase 12) ----
  static const String dashboard = '/dashboard';
  static const String smsHistory = '/sms';
  static const String transactions = '/transactions';
  static const String transactionDetail = '/transactions/detail';
  static const String matching = '/matching';
  static const String banks = '/banks';
  static const String parserRules = '/parser/rules';
  static const String parserTest = '/parser/test';
  static const String sync = '/sync';
  static const String logs = '/logs';
  static const String auditLogs = '/logs/audit';
  static const String settings = '/settings';
}

/// Central navigator configuration.
///
/// Registered as a SINGLETON in DI (Phase 01) — a single instance must
/// own [navigatorKey] for the whole app lifetime.
///
/// RULE: routing only. No business logic, no feature imports except
/// the pages it builds.
class AppRouter {
  AppRouter();

  /// Root navigator key — enables root-level dialogs/banners (e.g.
  /// connectivity banner in Phase 10) from non-widget layers.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// The route the app opens on.
  String get initialRoute => AppRoutes.splash;

  /// Route factory — consumed by `MaterialApp.onGenerateRoute`.
  ///
  /// Returns `null` for unregistered routes so the framework falls
  /// through to [onUnknownRoute].
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const _FoundationGatePage(),
        );

      // ------------------------------------------------------------------
      // Feature builders are appended here, phase by phase:
      //
      //   case AppRoutes.login:          // Phase 11/12
      //   case AppRoutes.dashboard:      // Phase 12
      //   case AppRoutes.smsHistory:     // Phase 12
      //   ...
      // ------------------------------------------------------------------

      default:
        return null;
    }
  }

  /// Permanent fallback for unregistered / mistyped routes and bad
  /// deep-links. Production behavior — never a white screen.
  Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) =>
          _RouteNotFoundPage(route: settings.name ?? '<null>'),
    );
  }
}

/// TEMPORARY Phase-01 smoke page.
///
/// Proves the Phase-01 gate end-to-end with REAL wiring:
///   DI boots → router resolves '/' → theme applies →
///   l10n resolves (fa) → RTL lays out.
///
/// REPLACED by the real Splash/Bootstrap page in Phase 12 —
/// delete this widget (and its case above) when that lands.
class _FoundationGatePage extends StatelessWidget {
  const _FoundationGatePage();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.verified_outlined,
              size: 64,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(l10n.appTitle, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'v${AppConstants.appVersion}',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// Permanent "route not found" view. Reuses core-level l10n keys —
/// the offending route path is technical data and stays unlocalized.
class _RouteNotFoundPage extends StatelessWidget {
  const _RouteNotFoundPage({required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.errorTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.route_outlined,
                size: 56,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.errorGeneric,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(route, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}