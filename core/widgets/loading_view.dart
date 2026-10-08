import 'package:flutter/material.dart';

import 'package:datadadtesms/l10n/app_localizations.dart';

/// Generic centered loading view.
///
/// Used by every feature page for the `Loading` state of its provider.
///
/// RULES:
///  - Presentation only — no business logic, no provider access.
///  - Message defaults to the shared `loading` l10n key; a custom
///    message is allowed for operation-specific feedback (e.g. sync).
///  - Styling comes from the central theme — nothing hard-coded here.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message});

  /// Optional custom message. When null, the shared localized
  /// "Loading…" string is shown.
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            message ?? AppLocalizations.of(context).loading,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}