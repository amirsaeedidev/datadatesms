import 'package:flutter/material.dart';

import 'package:datadadtesms/l10n/app_localizations.dart';

/// Generic centered error view.
///
/// Used by every feature page for the `Error` state of its provider.
///
/// RULES:
///  - Presentation only — no business logic, no provider access.
///  - This widget does NOT know about the typed `Failure` system.
///    When Phase 04 lands, the OWNER (provider/page) maps
///    `Failure -> (message, code)` and passes the result here.
///    That keeps this widget stable across all future phases.
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.message,
    this.code,
    this.onRetry,
  });

  /// Human-readable error message.
  /// When null, the shared localized generic message is shown.
  final String? message;

  /// Optional technical error code (e.g. 'NET-001').
  /// Rendered as small secondary text — technical data stays unlocalized.
  final String? code;

  /// Optional retry callback. When provided, a retry button is shown.
  /// The OWNER decides what retry means (re-run usecase, refresh, etc.).
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              size: 56,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.errorTitle,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message ?? l10n.errorGeneric,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (code != null) ...<Widget>[
              const SizedBox(height: 4),
              Text(
                l10n.errorWithCode(code!),
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...<Widget>[
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}