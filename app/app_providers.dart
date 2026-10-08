import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:datadadtesms/app/app_router.dart';
import 'package:datadadtesms/core/di/dependency_injection.dart';

/// Root provider composition of the application.
///
/// RULES:
///  1. This is the ONLY place where providers are composed into the tree.
///  2. Infrastructure owned by DI (like [AppRouter]) is exposed via
///     Provider.value - DI owns its lifetime, provider never disposes it.
///  3. Feature ChangeNotifier providers are registered here (lazy)
///     in Phase 11 - each resolving its dependencies from DI.
class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppRouter>.value(
          value: DependencyInjection.instance.appRouter,
        ),
      ],
      child: child,
    );
  }
}