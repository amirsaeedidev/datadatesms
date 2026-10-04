import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:datadadtesms/app/app_router.dart';
import 'package:datadadtesms/core/di/dependency_injection.dart';

/// Root provider composition of the application.
///
/// RULES:
///  1. This is the ONLY place where providers are composed into the tree.
///     Feature widgets NEVER create their own ChangeNotifierProviders.
///  2. Infrastructure objects owned by the DI container (like [AppRouter])
///     are exposed via `Provider.value` — DI owns their lifetime, so the
///     provider package must NOT dispose them.
///  3. Feature ChangeNotifier providers are registered with
///     `ChangeNotifierProvider(create: ...)` — LAZY by default, so the
///     provider package owns creation + disposal and unused features
///     cost nothing at startup.
///  4. REGISTRATION ORDER MATTERS: providers that others depend on
///     (Auth before anything session-dependent) are registered FIRST.
///
/// Phase 01 state: only real infrastructure is wired. Feature slots
/// below are filled exactly in Phase 11 — not earlier.
class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});

  /// The rest of the app tree (typically the [MaterialApp]).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        // ---------------------------------------------------------------
        // Infrastructure — REAL, resolved from the DI container.
        // Lifetime: owned by DI → registered by value, never disposed here.
        // ---------------------------------------------------------------
        Provider<AppRouter>.value(
          value: DependencyInjection.instance.appRouter,
        ),

        // ---------------------------------------------------------------
        // Feature providers — registration slots, filled phase by phase:
        //
        // Phase 11 (Providers):
        //   ChangeNotifierProvider<AuthProvider>(...)            // FIRST
        //   ChangeNotifierProvider<PermissionProvider>(...)
        //   ChangeNotifierProvider<BankProvider>(...)
        //   ChangeNotifierProvider<SmsProvider>(...)
        //   ChangeNotifierProvider<ParserProvider>(...)
        //   ChangeNotifierProvider<TransactionProvider>(...)
        //   ChangeNotifierProvider<MatchingProvider>(...)
        //   ChangeNotifierProvider<SyncProvider>(...)
        //   ChangeNotifierProvider<LogProvider>(...)
        //   ChangeNotifierProvider<DashboardProvider>(...)       // LAST
        //
        // Each registration resolves its dependencies (repositories /
        // engines / usecases) from DI — no direct construction here.
        // ---------------------------------------------------------------
      ],
      child: child,
    );
  }
}