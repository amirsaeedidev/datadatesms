import 'package:flutter/material.dart';

/// Compact status chip used across features (transaction status,
/// sync status, sms processing status, ...).
///
/// RULES:
///  - Presentation only — receives a pre-localized [label].
///  - Does NOT map domain enums to labels — that mapping belongs to
///    the feature layer when each feature's entities land.
///  - Styling derives from the central color scheme — no hard-coded
///    colors survive theme changes.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    this.tone = StatusBadgeTone.neutral,
    this.showDot = true,
  });

  /// Pre-localized, human-readable status text.
  final String label;

  /// Visual tone of the badge.
  final StatusBadgeTone tone;

  /// Whether to show the small leading dot. Default `true`.
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor(scheme),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: _foregroundColor(scheme)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (showDot) ...<Widget>[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: _foregroundColor(scheme),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: _foregroundColor(scheme),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Tone -> color mapping (single source of truth for badge colors)
  // ---------------------------------------------------------------------------

  Color _backgroundColor(ColorScheme scheme) {
    return switch (tone) {
      StatusBadgeTone.neutral => scheme.surfaceContainerHighest,
      StatusBadgeTone.info => scheme.secondaryContainer,
      StatusBadgeTone.success => Color.lerp(
          scheme.primary, scheme.surfaceContainerHighest, 0.82)!,
      StatusBadgeTone.warning => scheme.tertiaryContainer,
      StatusBadgeTone.error => scheme.errorContainer,
    };
  }

  Color _foregroundColor(ColorScheme scheme) {
    return switch (tone) {
      StatusBadgeTone.neutral => scheme.onSurfaceVariant,
      StatusBadgeTone.info => scheme.onSecondaryContainer,
      StatusBadgeTone.success => scheme.primary,
      StatusBadgeTone.warning => scheme.onTertiaryContainer,
      StatusBadgeTone.error => scheme.onErrorContainer,
    };
  }
}

/// Visual tones available to [StatusBadge].
///
/// Deliberately GENERIC — feature entities keep their own semantic
/// status enums (TransactionStatus, SyncStatus, ...) and map them to
/// one of these tones in the presentation layer of their feature.
enum StatusBadgeTone {
  /// Grey — unknown / idle / disabled.
  neutral,

  /// Muted blue — in progress / pending / processing.
  info,

  /// Muted green — synced / accepted / matched.
  success,

  /// Amber — warning / needs review / ambiguous.
  warning,

  /// Red — failed / rejected / error.
  error,
}