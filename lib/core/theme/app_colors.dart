import 'package:flutter/material.dart';

/// Цветовая палитра для темной темы приложения
/// Использует более светлые и читабельные оттенки
class AppColors {
  AppColors._();

  // Основные цвета фона
  static const Color background = Color(0xFF1E2128); // Главный фон - темнее для комфорта
  static const Color backgroundSecondary = Color(0xFF282C34); // Вторичный фон
  static const Color surface = Color(0xFF2C3038); // Поверхности (карточки)
  static const Color surfaceElevated = Color(0xFF353A45); // Поднятые элементы

  // Цвета для диалогов (светлее для лучшей читаемости форм)
  static const Color dialogBackground = Color(0xFF3A3F52); // Светлый фон для диалогов
  static const Color dialogSurface = Color(0xFF434857); // Поверхности в диалогах

  // Цвета текста (еще более светлые для максимальной читаемости)
  static const Color textPrimary = Color(0xFFF5F6FA); // Основной текст (почти белый)
  static const Color textSecondary = Color(0xFFCBCFDD); // Вторичный текст (значительно светлее)
  static const Color textTertiary = Color(0xFFA5A9BC); // Третичный текст
  static const Color textDisabled = Color(0xFF7A7E8F); // Отключенный текст

  // Акцентные цвета
  static const Color primary = Color(0xFF6366F1); // Индиго - основной акцент
  static const Color primaryLight = Color(0xFF818CF8); // Светлее для hover
  static const Color primaryDark = Color(0xFF4F46E5); // Темнее для active

  static const Color secondary = Color(0xFF8B5CF6); // Фиолетовый - вторичный
  static const Color secondaryLight = Color(0xFFA78BFA);
  static const Color secondaryDark = Color(0xFF7C3AED);

  // Семантические цвета
  static const Color success = Color(0xFF10B981); // Зеленый
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  static const Color warning = Color(0xFFF59E0B); // Оранжевый
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  static const Color error = Color(0xFFEF4444); // Красный
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color info = Color(0xFF3B82F6); // Синий
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);

  static const Color teal = Color(0xFF14B8A6); // Teal для GPI
  static const Color tealLight = Color(0xFF2DD4BF);
  static const Color tealDark = Color(0xFF0D9488);
  
  static const Color gearAccent = Color(0xFF4ECDC4); // Бирюзовый для карточек экипировки

  static const Color olive = Color(0xFF84CC16); // Lime для средних показателей
  static const Color orange = Color(0xFFFF9800); // Оранжевый для износа

  // Границы и разделители (более видимые)
  static const Color border = Color(0xFF525869); // Более светлые и заметные границы
  static const Color borderLight = Color(0xFF646A7D);
  static const Color divider = Color(0xFF454A5C);

  // Overlay и тени
  static const Color overlay = Color(0x50000000); // Для модальных окон
  static const Color shadow = Color(0x40000000); // Более заметные тени

  // Специальные цвета для спина
  static const Color spinHighlight = Color(0xFF8B5CF6); // Фиолетовый для счетчика спинов
  static const Color sessionActive = Color(0xFF10B981); // Зеленый для активных сессий
  static const Color sessionCompleted = Color(0xFF6366F1); // Индиго для завершенных

  // Цвета для графиков и статистики (светлее для лучшей видимости)
  static const Color chartPrimary = Color(0xFF818CF8); // Светлее индиго
  static const Color chartSecondary = Color(0xFFA78BFA); // Светлее фиолетовый
  static const Color chartTertiary = Color(0xFF34D399); // Светлее зеленый
  static const Color chartBackground = Color(0xFF3A3F52); // Соответствует backgroundSecondary
  static const Color chartGrid = Color(0xFF525869); // Соответствует border

  // Градиенты
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
