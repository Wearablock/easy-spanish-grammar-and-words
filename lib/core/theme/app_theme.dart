import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Material 3 Design System 기반 앱 테마
///
/// - 폰트: Google Fonts - Outfit (단일 패밀리)
/// - 폰트 두께: 3단계 (w700 / w600 / w500)
/// - Border Radius: 계층별 (12 인터랙티브 / 16 컨테이너 / 20 오버레이)
/// - Elevation: 0 · 2 · 3
class AppTheme {
  AppTheme._();

  // ============================================================
  // Font Weight — 3단계 시스템
  // ============================================================

  static const _bold = FontWeight.w700; // Display, Headline, AppBar
  static const _semiBold = FontWeight.w600; // Title, Label, 버튼
  static const _medium = FontWeight.w500; // Body, 일반 텍스트

  // ============================================================
  // Light Theme
  // ============================================================

  static ThemeData get light {
    final colorScheme = const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.black,
      error: AppColors.negative,
      surface: AppColors.surfaceLight,
      onSurface: Color(0xFF1C1B1F),
      outline: Color(0xFF79747E),
    );

    final baseTextTheme = GoogleFonts.outfitTextTheme(
      ThemeData.light().textTheme,
    );
    final textTheme = _buildTextTheme(baseTextTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.surfaceLight,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: _bold,
          color: colorScheme.primary,
        ),
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.outfit(fontWeight: _semiBold),
        ),
      ),

      // OutlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.outfit(fontWeight: _semiBold),
        ),
      ),

      // TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: GoogleFonts.outfit(fontWeight: _semiBold),
        ),
      ),

      // InputDecoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // NavigationBar (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        elevation: 3,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: _semiBold,
              color: colorScheme.primary,
            );
          }
          return GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: _medium,
            color: Colors.grey,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.primary);
          }
          return const IconThemeData(color: Colors.grey);
        }),
      ),

      // ListTile
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(thickness: 1),

      // ProgressIndicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.outline.withValues(alpha: 0.15),
      ),

      // BottomSheet
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  // ============================================================
  // Dark Theme
  // ============================================================

  static ThemeData get dark {
    final colorScheme = const ColorScheme.dark(
      primary: AppColors.primaryLight,
      onPrimary: Colors.white,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.black,
      error: AppColors.negative,
      surface: AppColors.surfaceDark,
      onSurface: Color(0xFFE6E1E5),
      outline: Color(0xFF938F99),
    );

    final baseTextTheme = GoogleFonts.outfitTextTheme(
      ThemeData.dark().textTheme,
    );
    final textTheme = _buildTextTheme(baseTextTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xFF121212),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: _bold,
          color: colorScheme.primary,
        ),
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.outfit(fontWeight: _semiBold),
        ),
      ),

      // OutlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.outfit(fontWeight: _semiBold),
        ),
      ),

      // TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: GoogleFonts.outfit(fontWeight: _semiBold),
        ),
      ),

      // InputDecoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // NavigationBar (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        elevation: 3,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: _semiBold,
              color: colorScheme.primary,
            );
          }
          return GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: _medium,
            color: Colors.grey,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.primary);
          }
          return const IconThemeData(color: Colors.grey);
        }),
      ),

      // ListTile
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(thickness: 1),

      // ProgressIndicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.outline.withValues(alpha: 0.15),
      ),

      // BottomSheet
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  // ============================================================
  // Typography Builder — 3단계 두께 시스템
  // ============================================================

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      // Bold (w700) — Display, Headline
      displayLarge: base.displayLarge?.copyWith(fontWeight: _bold),
      displayMedium: base.displayMedium?.copyWith(fontWeight: _bold),
      displaySmall: base.displaySmall?.copyWith(fontWeight: _bold),
      headlineLarge: base.headlineLarge?.copyWith(fontWeight: _bold),
      headlineMedium: base.headlineMedium?.copyWith(fontWeight: _bold),
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: _bold),
      // Semi-bold (w600) — Title, Label
      titleLarge: base.titleLarge?.copyWith(fontWeight: _semiBold),
      titleMedium: base.titleMedium?.copyWith(fontWeight: _semiBold),
      titleSmall: base.titleSmall?.copyWith(fontWeight: _semiBold),
      labelLarge: base.labelLarge?.copyWith(fontWeight: _semiBold),
      labelMedium: base.labelMedium?.copyWith(fontWeight: _semiBold),
      labelSmall: base.labelSmall?.copyWith(fontWeight: _semiBold),
      // Medium (w500) — Body
      bodyLarge: base.bodyLarge?.copyWith(fontWeight: _medium),
      bodyMedium: base.bodyMedium?.copyWith(fontWeight: _medium),
      bodySmall: base.bodySmall?.copyWith(fontWeight: _medium),
    );
  }
}
