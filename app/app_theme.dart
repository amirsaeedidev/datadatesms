import 'package:flutter/material.dart';

/// Central theme of the application.
///
/// RULE: NO feature-specific styling. This file defines the product-wide
/// design system — colors, typography scale, component themes. Feature
/// widgets consume `Theme.of(context)` and NEVER hard-code colors.
///
/// Font strategy: system default for now (Persian glyphs render fine on
/// Android). If a branded font (e.g. Vazirmatn) is added later, only the
/// `_fontFamily` constant below changes.
library;

/// Single source of truth for theme-related constants that are also
/// needed OUTSIDE the theme (e.g. constants, logs) — keeps magic values
/// out of widgets.
abstract final class AppThemeConstants {
  /// Brand seed color — deep teal, calm and trustworthy for a financial app.
  /// Drives both light & dark [ColorScheme.fromSeed].
  static const Color seedColor = Color(0xFF0F6E5C);

  /// Semantic background used by [LoadingView]/[ErrorView]/[EmptyView]
  /// for the large illustration icon.
  static const Color statusIconColor = Color(0xFF9AA5B1);
}

/// Builds the application [ThemeData].
///
/// Pass [brightness] explicitly — the [DadehTadApp] widget decides the
/// mode (system / light / dark) at bootstrap; theme file stays pure.
class AppTheme {
  AppTheme._();

  /// Font family applied to the whole theme.
  /// null = platform default. Change here to switch to a bundled font.
  static const String? _fontFamily = null;

  // ---------------------------------------------------------------------------
  // Color schemes
  // ---------------------------------------------------------------------------

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

      // --- Global RTL awareness -------------------------------------------------
      // Material handles direction automatically for layout, but explicit
      // component tweaks for mirrored icons live per-widget, not here.

      // --- AppBar ----------------------------------------------------------------
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

      // --- Cards (used by lists across all features) -----------------------------
      cardTheme: CardTheme(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surface,
        // Subtle outline keeps cards readable on tinted backgrounds.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),

      // --- Filled buttons (primary actions) --------------------------------------
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // --- Outlined / Text buttons ------------------------------------------------
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // --- Text buttons (row/inline actions) --------------------------------------
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
        ),
      ),

      // --- Inputs (Parser Rule editor, settings, auth) ---------------------------
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
          borderRadius:  BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
      ),

      // --- Floating action button -------------------------------------------------
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      // --- Chips (filters, status tags) --------------------------------------------
      chipTheme: ChipThemeData(
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // --- Dialogs -----------------------------------------------------------------
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // --- Snackbars -----------------------------------------------------------------
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      // --- Dividers -------------------------------------------------------------------
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
    );
  }
}