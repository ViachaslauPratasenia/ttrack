# Dashboard Feature

## Описание

Dashboard - главный экран приложения Spin Track, отображающий статистику пользователя, прогресс, достижения и последние тренировки.

## Структура

```
lib/features/dashboard/
├── presentation/
│   ├── pages/
│   │   └── dashboard_page.dart          # Главная страница dashboard
│   └── widgets/
│       ├── greeting_section.dart         # Приветствие и мотивация
│       ├── stats_cards.dart              # Карточки статистики (часы, сессии, win rate)
│       ├── badges_section.dart           # Секция с достижениями и прогрессом
│       ├── performance_chart.dart        # График прогресса
│       └── recent_sessions.dart          # Последние тренировки
```

## Компоненты

### DashboardPage
Главная страница с:
- AppBar (меню, поиск, переключатель темы, аватар)
- Pull-to-refresh
- Floating Action Button для добавления новой тренировки
- Scroll view со всеми секциями

### GreetingSection
- Динамическое приветствие (утро/день/вечер)
- Текущая дата
- Мотивационная цитата

### StatsCards
Три карточки статистики:
- **Часы**: общее время тренировок
- **Сессии**: количество записанных сессий
- **Win Rate**: процент побед в матчах

Адаптивный layout:
- Portrait mode: карточки в колонку
- Landscape/tablet (>600px): карточки в ряд

### BadgesSection
- Текущий бейдж с иконкой
- Описание достижения
- Прогресс до следующего уровня

### PerformanceChart
- График прогресса (средний рейтинг по дням)
- Custom painter для отрисовки графика
- TODO: Интеграция с fl_chart для более продвинутой визуализации

### RecentSessions
- Список последних 3 тренировок
- Для каждой: тип, дата, длительность, локация
- Клик на карточку → переход к деталям (TODO)

## Данные (Mock)

На данный момент используются замокированные данные. В будущем будет интеграция с:
- State management (Bloc/Cubit)
- API для получения реальной статистики
- Локальное хранилище для offline режима

## Поддержка Portrait режима

Все компоненты адаптированы для portrait режима:
- `StatsCards` переключается между column/row layout
- Все элементы responsive
- Оптимизированы отступы и размеры для мобильных экранов

## TODO

- [ ] Интеграция с state management
- [ ] Подключение к реальному API
- [ ] Добавить fl_chart для графиков
- [ ] Реализовать navigation к деталям сессий
- [ ] Добавить skeleton loading
- [ ] Реализовать pull-to-refresh логику
- [ ] Добавить dark mode поддержку
- [ ] Анимации при загрузке данных

## Использование

```dart
// В main.dart или после успешного логина
Navigator.pushReplacementNamed(context, '/dashboard');

// Или напрямую
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DashboardPage()),
);
```

