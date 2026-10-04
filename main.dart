import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'core/di/dependency_injection.dart';

/// Application entry point.
///
/// Phase 01 — Bootstrap ONLY:
///   1. Initialize Flutter bindings
///   2. Lock device orientation
///   3. Initialize the DI container
///   4. Launch the root [DadehTadApp] widget
///
/// RULE: main() contains NO business logic and NO feature initialization.
/// Feature wiring happens exclusively inside [DependencyInjection] as
/// each phase lands (DB → SMS → Parser → Transaction → API → Sync →
/// Providers → UI).
Future<void> main() async {
  // Required before touching any platform channel — the DI init
  // (path provider / secure storage) uses them.
  WidgetsFlutterBinding.ensureInitialized();

  // Portrait-only: this is a financial data capture/review app —
  // landscape adds no value and complicates RTL layouts.
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  // Build the dependency graph:
  // Core → DataSource → Repository → Engine/Service → UseCase → Provider.
  // In Phase 01 this wires core infrastructure only; feature
  // registrations are appended phase by phase.
  await DependencyInjection.instance.initialize();

  runApp(const DadehTadApp());
}