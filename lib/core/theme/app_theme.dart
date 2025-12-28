import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  /// Темная тема приложения с улучшенными цветами
  static ShadThemeData darkTheme() {
    return ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: ShadColorScheme(
        // Основные цвета
        background: AppColors.background,
        foreground: AppColors.textPrimary,
        
        // Карточки и поверхности
        card: AppColors.surface,
        cardForeground: AppColors.textPrimary,
        
        // Popover
        popover: AppColors.surfaceElevated,
        popoverForeground: AppColors.textPrimary,
        
        // Primary (основной акцентный цвет)
        primary: AppColors.primary,
        primaryForeground: AppColors.textPrimary,
        
        // Secondary
        secondary: AppColors.backgroundSecondary,
        secondaryForeground: AppColors.textPrimary,
        
        // Muted (приглушенные элементы)
        muted: AppColors.backgroundSecondary,
        mutedForeground: AppColors.textSecondary,
        
        // Accent
        accent: AppColors.secondary,
        accentForeground: AppColors.textPrimary,
        
        // Destructive (для удаления/опасных действий)
        destructive: AppColors.error,
        destructiveForeground: AppColors.textPrimary,
        
        // Границы
        border: AppColors.border,
        input: AppColors.borderLight,
        ring: AppColors.primary,
        
        // Выделение
        selection: AppColors.primaryLight.withOpacity(0.3),
      ),
      
      // Радиус скругления
      radius: BorderRadius.circular(8),
      
      // Цветовая схема для текста
      textTheme: ShadTextTheme(
        h1Large: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        h1: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        h2: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        h3: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        h4: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        p: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        blockquote: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
        table: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
        list: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        lead: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
        large: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        small: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        muted: TextStyle(
          color: AppColors.textTertiary,
          fontSize: 14,
        ),
      ),
    );
  }
  
  /// Material Theme для совместимости
  static ThemeData materialDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.textPrimary),
        displayMedium: TextStyle(color: AppColors.textPrimary),
        displaySmall: TextStyle(color: AppColors.textPrimary),
        headlineLarge: TextStyle(color: AppColors.textPrimary),
        headlineMedium: TextStyle(color: AppColors.textPrimary),
        headlineSmall: TextStyle(color: AppColors.textPrimary),
        titleLarge: TextStyle(color: AppColors.textPrimary),
        titleMedium: TextStyle(color: AppColors.textPrimary),
        titleSmall: TextStyle(color: AppColors.textPrimary),
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textPrimary),
        bodySmall: TextStyle(color: AppColors.textSecondary),
        labelLarge: TextStyle(color: AppColors.textPrimary),
        labelMedium: TextStyle(color: AppColors.textSecondary),
        labelSmall: TextStyle(color: AppColors.textTertiary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shadowColor: AppColors.shadow,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
    );
  }
}

