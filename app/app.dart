import 'package:flutter/material.dart';

import 'package:datadadtesms/app/app_providers.dart';
import 'package:datadadtesms/app/app_router.dart';
import 'package:datadadtesms/app/app_theme.dart';
import 'package:datadadtesms/core/di/dependency_injection.dart';
import 'package:datadadtesms/l10n/app_localizations.dart';

/// Root widget — bootstrap wiring only, no business logic.
class DadehTadApp extends StatelessWidget {
  const DadehTadApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter router = DependencyInjection.instance.appRouter;

    return AppProviders(
      child: MaterialApp(
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.system,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        navigatorKey: router.navigatorKey,
        initialRoute: router.initialRoute,
        onGenerateRoute: router.onGenerateRoute,
        onUnknownRoute: router.onUnknownRoute,
      ),
    );
  }
}