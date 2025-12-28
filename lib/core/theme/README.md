# Тема приложения

## Структура

### `app_colors.dart`
Содержит все цвета для темной темы приложения. Цвета организованы по категориям:

- **Основные цвета фона**: `background`, `backgroundSecondary`, `surface`, `surfaceElevated`
- **Цвета текста**: `textPrimary`, `textSecondary`, `textTertiary`, `textDisabled`
- **Акцентные цвета**: `primary`, `secondary` с вариациями (light/dark)
- **Семантические цвета**: `success`, `warning`, `error`, `info`
- **Границы и разделители**: `border`, `borderLight`, `divider`
- **Специальные цвета**: для спинов, сессий, графиков
- **Градиенты**: готовые градиенты для использования в UI

### `app_theme.dart`
Содержит конфигурацию темы приложения:

- `darkTheme()` - темная тема для ShadcnUI
- `materialDarkTheme()` - темная тема для Material Design компонентов

## Использование

Тема автоматически применяется в `main.dart`:

```dart
import 'core/theme/app_theme.dart';

ShadApp.custom(
  theme: AppTheme.darkTheme(),
  // ...
)
```

Для использования цветов в виджетах:

```dart
import 'package:ttrack/core/theme/app_colors.dart';

Container(
  color: AppColors.surface,
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.textPrimary),
  ),
)
```

## Изменения цветов

Текущая темная тема использует более светлую палитру для лучшей читабельности:

- Фон: `#1A1D23` вместо почти черного
- Текст: `#E8E9ED` для максимальной контрастности
- Акценты: яркие индиго и фиолетовые тона
- Границы: более заметные для четкого разделения элементов

Все цвета выбраны с учетом:
- Достаточного контраста для читабельности (WCAG AA)
- Современного дизайна
- Приятного восприятия при длительном использовании

