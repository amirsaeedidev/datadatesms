/// Central theme of the application.
///
/// RULE: NO feature-specific styling. This file defines the product-wide
/// design system — colors, typography scale, component themes. Feature
/// widgets consume `Theme.of(context)` and NEVER hard-code colors.
///
/// Font strategy: system default for now (Persian glyphs render fine on
/// Android). If a branded font (e.g. Vazirmatn) is added later, only the
/// [_fontFamily] constant changes — plus a `fonts:` block in pubspec.
library;

import 'package:flutter/material.dart';

/// Single source of truth for theme-related constants that are also
/// needed OUTSIDE ThemeData (e.g. core status views, logs).
abstract final class AppThemeConstants {
  /// Brand seed color — deep teal, calm and trustworthy for a financial app.
  /// Drives both light & dark [ColorScheme.fromSeed].
  static const Color seedColor = Color(0xFF0F6E5C);

  /// Muted icon color used by LoadingView / ErrorView / EmptyView.
  static const Color statusIconColor = Color(0xFF9AA5B1);
}

/// Builds the application [ThemeData].
///
/// Pass [brightness] explicitly — the root widget decides the mode
/// (system / light / dark) at bootstrap; this file stays pure.
class AppTheme {
  AppTheme._();

  /// Font family applied to the whole theme.
  /// `null` = platform default. Change here to switch to a bundled font.
  static const String? _fontFamily = null;

  /// Light color scheme derived from the brand seed.
  static ThemeData light() => _build(Brightness.light);

  /// Dark color scheme derived from the brand seed.
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppThemeConstants.seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: _fontFamily,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // --- AppBar ------------------------------------------------------------------
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
      ),

      // --- Cards (lists across all features) ----------------------------------------
      // NOTE: on current Flutter the parameter type is [CardThemeData]
      // (the old `CardTheme` class is no longer accepted by ThemeData).
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),

      // --- Buttons -------------------------------------------------------------------
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
      ),

      // --- Inputs (Parser Rule editor, settings, auth) ---------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
      ),

      // --- FAB --------------------------------------------------------------------------
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      // --- Dialogs ------------------------------------------------------------------------
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // --- Snackbars -------------------------------------------------------------------------
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      // --- Dividers -----------------------------------------------------------------------------
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }
}