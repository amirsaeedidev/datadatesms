import 'package:flutter/material.dart';

import 'package:datadadtesms/l10n/app_localizations.dart';

/// Generic centered empty-state view.
///
/// Used by every feature page when its provider's data list is empty
/// (SMS history, transactions, sync queue, logs, banks, ...).
///
/// RULES:
///  - Presentation only — no business logic, no provider access.
///  - Defaults come from the shared l10n keys; feature pages may pass
///    a specific message/icon (e.g. "no transactions yet") without
///    creating a new widget.
class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.icon = Icons.inbox_outlined,
    this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  /// Large illustration icon above the text.
  /// Defaults to an inbox glyph — fits "no items here" in every feature.
  final IconData icon;

  /// Title line. When null, the shared localized empty title is shown.
  final String? title;

  /// Secondary line. When null, the shared localized empty message is shown.
  final String? message;

  /// Optional action button label (e.g. "Sync now", "Retry").
  /// The button only appears when [onAction] is provided too.
  final String? actionLabel;

  /// Optional action callback — the OWNER defines what it does.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ThemeData theme = Theme.of(context);

    final bool hasAction = actionLabel != null && onAction != null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 56,
              // Muted tone — an empty state is informational, not an error.
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              title ?? l10n.emptyTitle,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message ?? l10n.emptyGeneric,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (hasAction) ...<Widget>[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add_circle_outline),
                label: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}