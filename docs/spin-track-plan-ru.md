# Spin Track: План разработки и описание экранов

## Содержание
1. [План разработки](#план-разработки)
2. [Архитектура приложения](#архитектура-приложения)
3. [Описание экранов](#описание-экранов)
4. [User Flow](#user-flow)
5. [API Endpoints](#api-endpoints)

---

## План разработки

### Фаза 1: Foundation (Неделя 1-2)
**Цель:** Установка инфраструктуры, настройка backend и frontend

**Задачи:**
- [ ] Настроить Flutter проект с зависимостями
- [ ] Настроить Backend (Node.js/Express или Python/FastAPI)
- [ ] Настроить PostgreSQL базу данных
- [ ] Создать CI/CD pipeline (GitHub Actions)
- [ ] Настроить Sentry для error tracking
- [ ] Реализовать JWT аутентификацию
- [ ] Создать Data Models в БД

**Deliverables:**
- Рабочее dev окружение
- Basic API endpoints для auth
- Пустой Flutter проект с navigation структурой

---

### Фаза 2: Core Authentication & Profile (Неделя 3-4)
**Цель:** Пользователи могут регистрироваться, логиниться и редактировать профиль

**Задачи:**
- [ ] Экран Sign Up (регистрация)
- [ ] Экран Login (вход)
- [ ] Экран My Profile (профиль пользователя)
- [ ] API endpoints: POST /auth/register, POST /auth/login, GET/PUT /user/profile
- [ ] Локальное хранение токена (secure storage)
- [ ] Validation и обработка ошибок

**Deliverables:**
- Полная аутентификация
- Экран профиля с редактированием
- Error handling и loading states

---

### Фаза 3: Session Logging MVP (Неделя 5-7)
**Цель:** Основная функция - логирование тренировок

**Задачи:**
- [ ] Экран Log Entry с двумя вкладками (Quick Timer, Manual Entry)
- [ ] Quick Timer функционал
- [ ] Manual Entry форма для Practice и Match
- [ ] API endpoints: POST /sessions, GET /sessions
- [ ] Сохранение сессий локально (offline support)
- [ ] Валидация данных формы

**Deliverables:**
- Полная система логирования сессий
- Offline поддержка
- Синхронизация при восстановлении соединения

---

### Фаза 4: Dashboard & History (Неделя 8-9)
**Цель:** Пользователи видят статистику и историю

**Задачи:**
- [ ] Экран Dashboard с widgets:
  - Lifetime Stats (часы, сессии, win rate)
  - Badges (текущий прогресс)
  - Performance Trend Chart (линейный график)
  - Recent Sessions
- [ ] Экран History с фильтрацией
- [ ] Редактирование/удаление сессий
- [ ] API endpoints: GET /stats, GET /sessions/history
- [ ] Интеграция fl_chart для графиков

**Deliverables:**
- Dashboard с полной статистикой
- История сессий с фильтрами
- Редактор сессий

---

### Фаза 5: Gear System (Неделя 10-11)
**Цель:** Управление снаряжением и GPI система

**Задачи:**
- [ ] Gear Locker в профиле (CRUD операции)
- [ ] Добавление paddle setup при логировании
- [ ] API endpoints: POST/GET/PUT/DELETE /gear
- [ ] Базовая GPI система (без SAWI)
- [ ] Экран Gear Performance в профиле
- [ ] Логирование Gear Test сессий

**Deliverables:**
- Полная система управления снаряжением
- GPI расчет для paddle setups
- Gear Test логирование

---

### Фаза 6: Leaderboards (Неделя 12-13)
**Цель:** Конкурентные элементы

**Задачи:**
- [ ] Экран Leaderboard с двумя вкладками (Weekly, All-Time)
- [ ] API endpoints: GET /leaderboard/weekly, GET /leaderboard/all-time
- [ ] Session eligibility логика на backend
- [ ] Real-time обновление (polling или WebSocket)
- [ ] Профиль других пользователей (view-only)

**Deliverables:**
- Полностью функциональная leaderboard система
- Real-time обновления

---

### Фаза 7: Locations & Search (Неделя 14)
**Цель:** Открытие мест и поиск

**Задачи:**
- [ ] Экран Locations (список/карта)
- [ ] Location detail экран с отзывами
- [ ] Search функционал
- [ ] API endpoints: GET /locations, GET /locations/:id, POST /locations/:id/reviews
- [ ] Интеграция maps (Google Maps или similar)
- [ ] Rating система для локаций

**Deliverables:**
- Система управления локациями
- Search функционал
- Map integration

---

### Фаза 8: Polish & Testing (Неделя 15-16)
**Цель:** Bug fixes, performance, UX improvements

**Задачи:**
- [ ] Unit tests для core business logic
- [ ] Widget tests для UI
- [ ] E2E tests критических flows
- [ ] Performance optimization
- [ ] UX improvements на основе тестирования
- [ ] Подготовка к production release
- [ ] Theme toggle (Dark mode)
- [ ] Multi-language support (опционально)

**Deliverables:**
- Production-ready приложение
- Полное тестовое покрытие
- Документация для пользователей

---

## Архитектура приложения

### Navigation Structure

```
AppRoot
├── AuthFlow
│   ├── SignUp Screen
│   └── Login Screen
│
└── MainFlow (После аутентификации)
    ├── Dashboard (Home)
    ├── Log Entry
    │   ├── Quick Timer Tab
    │   └── Manual Entry Tab
    ├── History
    ├── Leaderboard
    │   ├── Weekly Tab
    │   └── All-Time Tab
    ├── Locations
    │   └── Location Detail
    ├── My Profile
    │   ├── Personal Info
    │   ├── Gear Locker
    │   └── Settings
    └── Search Results
        ├── Users Results
        └── Locations Results
```

---

## Описание экранов

### 1. SignUp Screen (Регистрация)

**Путь:** AuthFlow → SignUp  
**Назначение:** Регистрация нового пользователя

#### Элементы UI:
- Header: "Spin Track" логотип + "Создайте аккаунт"
- Форма с полями:
  - Name (текстовое поле, обязательное)
  - Email (email field, обязательное, с валидацией)
  - Password (secure field, обязательное, мин. 8 символов)
  - Password Confirm (secure field, обязательное, должна совпадать)
  - Country (dropdown, опционально)
- Кнопка "Создать аккаунт" (active/disabled)
- Текст "Уже есть аккаунт? Войти" (link на Login)
- Loading indicator при отправке
- Error message (если есть)
- Terms & Conditions чекбокс (опционально)

#### Функционал:
- Real-time валидация полей
- Password strength indicator
- Проверка email uniqueness на backend
- После успеха → redirect на Login или Dashboard
- Сохранение токена в secure storage
- Error handling (email already exists, validation errors)

#### API:
```
POST /auth/register
Body: { name, email, password, country }
Response: { token, user { id, name, email } }
```

---

### 2. Login Screen (Вход)

**Путь:** AuthFlow → Login  
**Назначение:** Вход в аккаунт

#### Элементы UI:
- Header: "Spin Track" логотип + "Добро пожаловать"
- Форма с полями:
  - Email (email field, обязательное)
  - Password (secure field, обязательное)
- Кнопка "Войти" (active/disabled)
- "Забыли пароль?" (link)
- Текст "Нет аккаунта? Создайте" (link на SignUp)
- Loading indicator при отправке
- Error message (неверные учетные данные, сервер недоступен)
- "Помнить меня" чекбокс (опционально)

#### Функционал:
- Remember email (optional)
- Сохранение токена в secure storage
- Redirect на Dashboard после успешного входа
- Biometric login (опционально, Phase 2)
- Token refresh логика

#### API:
```
POST /auth/login
Body: { email, password }
Response: { token, user { id, name, email, country } }
```

---

### 3. Dashboard Screen (Главная)

**Путь:** MainFlow → Dashboard (Default)  
**Назначение:** Обзор статистики и прогресса

#### Элементы UI:

**Header:**
- Left: Menu icon или app logo
- Center: "Spin Track"
- Right: Search icon, Theme toggle (sun/moon), User avatar

**Body (Scrollable):**

1. **Greeting Section:**
   - "Привет, {UserName}!" 
   - Date/time
   - Motivational quote (опционально)

2. **Lifetime Stats Cards (3 колонки на desktop, 1 на mobile):**
   - Card 1: "📊 Часы"
     - Значение: {totalHours} часов
     - Субтекст: "Всего тренировок"
   - Card 2: "✅ Сессии"
     - Значение: {totalSessions}
     - Субтекст: "Записано"
   - Card 3: "🏆 Win Rate"
     - Значение: {winRate}%
     - Субтекст: "Процент побед"

3. **Badges Section:**
   - "Ваши достижения"
   - Текущий badge с большой иконкой
   - Badge name и description
   - Progress bar: "10/1000 часов до следующего"
   - Next badge preview

4. **Performance Trend Chart:**
   - Заголовок: "График прогресса"
   - Line chart (средний рейтинг по неделям/месяцам)
   - X-axis: Дни/недели/месяцы
   - Y-axis: Средний рейтинг (1-10)
   - Legend и tooltip при наведении
   - Кнопка "Показать подробнее" → History

5. **GPI Display (if gear exists):**
   - "Ваше снаряжение"
   - Card с основным paddle setup
   - GPI score (0-100) визуально
   - Colored indicator (красный < 30, желтый 30-70, зеленый > 70)

6. **Recent Sessions:**
   - "Последние тренировки"
   - List из последних 3 сессий
   - Каждая сессия показывает:
     - Дату/время
     - Тип (Practice/Match)
     - Продолжительность
     - Локацию
     - Клик → Session detail

7. **Quick Actions Footer:**
   - Большая кнопка "➕ Новая тренировка" (sticky, всегда видна)
   - Leads to Log Entry

#### Функционал:
- Pull-to-refresh для обновления данных
- Lazy loading для графиков
- Сохранение scroll position
- Real-time обновление (если есть фоновая синхронизация)

#### API:
```
GET /stats
Response: { 
  totalHours, totalSessions, winRate, badges, 
  performanceTrend: [{date, avgRating}, ...],
  gpi: { paddleSetupId, score },
  recentSessions: [{id, type, duration, location, date}, ...]
}
```

---

### 4. Log Entry Screen (Логирование)

**Путь:** MainFlow → Log Entry  
**Назначение:** Две вкладки для логирования: Quick Timer и Manual Entry

#### Вкладка 1: Quick Timer

**Элементы UI:**
- Header: "Quick Timer"
- Location input field (с автозаполнением из истории)
- Большой Timer display (00:00:00 формат)
- Кнопка "Start Session" (когда timer не активен)
- Во время сессии:
  - Кнопка "Stop Session"
  - Pause/Resume кнопки
  - Показ как долго идет сессия
- Фоновое время работает при навигации в приложении

**При остановке:**
- Popup форма с полями:
  - Notes (текстовое поле, опционально)
  - Session type radio (Practice/Match) - по умолчанию Practice
  - (Если Match) Opponent name, score, opponent score, skill level
  - Paddle setup selector (dropdown)
  - Кнопка "Save Session"
  - Кнопка "Cancel"

#### Вкладка 2: Manual Entry

**Элементы UI:**
- Header: "Ввод вручную"
- Session type radio buttons (Practice, Match, Gear Test)
  
**Для Practice:**
- Location input (с history)
- Start date/time picker
- Duration input (часы/минуты или конец времени)
- Technical rating (1-10 slider)
- Tactical rating (1-10 slider)
- Mental rating (1-10 slider)
- Paddle setup selector (dropdown)
- Notes textarea
- Save button

**Для Match:**
- Location input (с history)
- Start date/time picker
- Duration input
- Your score input (number)
- Opponent name input
- Opponent score input (number)
- Opponent level dropdown (Higher/Similar/Lower)
- Paddle setup selector
- Notes textarea
- Save button

**Для Gear Test:**
- Location input
- Start date/time picker
- Duration input
- Paddle setup selector (REQUIRED)
- 5 KPI inputs (SGC, SPN, PWR, STB, SNS) - каждый 0-100 slider
- Notes textarea
- Save button

#### Функционал:
- Auto-save draft при переключении вкладок
- Validation перед сохранением
- Suggestion для location (история + popular locations)
- Date/time pickers с default текущего времени
- Offline поддержка (queue sessions если нет интернета)
- Loading indicator при сохранении
- Success message после сохранения
- Возможность добавить несколько сессий подряд

#### API:
```
POST /sessions
Body: {
  type, location, startTime, endTime, duration,
  // Practice specific
  technicalRating, tacticalRating, mentalRating,
  // Match specific
  playerScore, opponentName, opponentScore, opponentLevel,
  // Gear Test specific
  paddleSetupId, sgc, spn, pwr, stb, sns,
  // Common
  notes, paddleSetupId
}
Response: { id, ... full session object }
```

---

### 5. History Screen (История сессий)

**Путь:** MainFlow → History  
**Назначение:** Полная история всех сессий с фильтрацией и редактированием

#### Элементы UI:

**Header:**
- "История"
- Search/filter icon

**Filter Bar (Collapsible):**
- Session type filter (checkboxes: Practice, Match, Gear Test)
- Date range picker (from/to)
- Location filter (dropdown)
- Sort by (Date descending/ascending, Duration, Rating)

**Sessions List:**
- Для каждой сессии - card с информацией:
  - Тип (иконка + текст)
  - Дата и время
  - Продолжительность
  - Локация
  - Для Practice: Average rating (Technical/Tactical/Mental avg)
  - Для Match: Score (Your score - Opponent score), Opponent name
  - Для Gear Test: GPI score если пересчитан
- Long press → контекстное меню (Edit, Delete)
- Клик на сессию → Detail view

**Detail View (Bottom Sheet):**
- Вся информация о сессии
- Edit button
- Delete button (с подтверждением)
- Close button

**Edit Mode:**
- Все поля редактируемы
- Save и Cancel кнопки
- Delete button

#### Функционал:
- Infinite scroll или pagination
- Real-time фильтрация (debounced)
- Empty state если нет сессий
- Pull-to-refresh
- Local caching для fast loading
- Undo delete (опционально, Phase 2)

#### API:
```
GET /sessions?type=&dateFrom=&dateTo=&location=&sort=
Response: { sessions: [{...}, ...], total, page }

GET /sessions/:id
Response: { ...full session object }

PUT /sessions/:id
Body: { updated fields }
Response: { ...updated session }

DELETE /sessions/:id
Response: { success: true }
```

---

### 6. Leaderboard Screen (Лидерборд)

**Путь:** MainFlow → Leaderboard  
**Назначение:** Конкуренция и мотивация

#### Элементы UI:

**Вкладки:**
- Tab 1: "Неделя" (Weekly)
- Tab 2: "Всё время" (All-Time)

**Per Tab Content:**

**Header:**
- "Лидерборд"
- Refresh icon (manual refresh)
- Auto-refresh timer (обновляется каждые 5 минут)

**Your Position (Sticky Card):**
- "Вы находитесь на" card
- Ваш rank (например, #12)
- Ваше количество часов
- "↑" или "↓" с изменением позиции

**Ranking List:**
- Для каждого игрока:
  1. Rank/position (#1, #2, etc.) с медалью для top 3
  2. User avatar (или инициалы)
  3. User name (clicky → profile)
  4. Hours count (или weekly hours)
  5. Current badge иконка
  6. Difference from previous position (↑/↓ arrow)

**Bottom Section:**
- "Загрузить еще" button если есть еще игроки
- Или показать "You've reached the end"

#### Функционал:
- Auto-refresh каждые 5 минут
- Highlight собственного позиция
- Click на игрока → его profile (view-only)
- Loading indicator при загрузке
- Error state если backend недоступен
- Skeleton loading на первый раз

#### API:
```
GET /leaderboard/weekly?limit=50&offset=0
Response: { 
  rankings: [
    { rank, userId, userName, userAvatar, hours, badge, prevRank }, 
    ...
  ],
  yourRank, yourHours, yourPosition
}

GET /leaderboard/all-time?limit=50&offset=0
Response: { ...same structure }
```

---

### 7. Locations Screen (Места)

**Путь:** MainFlow → Locations  
**Назначение:** Открытие и обзор популярных площадок

#### Элементы UI:

**Header:**
- "Площадки для тренировок"
- Map icon (toggle view)
- Filter icon

**Toggle Views:**

**View 1: List**
- Список всех локаций
- Для каждой локации:
  - Локация name
  - Адрес (кратко)
  - Rating (stars) и количество отзывов
  - Количество игроков (e.g., "48 игроков")
  - Distance (если GPS доступен)
- Click → Location detail

**View 2: Map**
- Map с маркерами (Google Maps integration)
- Click на маркер → popup с name и rating
- Click popup → Location detail

**Фильтры (Collapsible):**
- Город/регион (dropdown)
- Рейтинг (rating threshold)
- Расстояние (distance radius, если GPS)
- Тип (if applicable - indoor/outdoor, etc.)

**Empty State:**
- Если нет локаций в регионе - "Будьте первым, кто добавит площадку!"

#### Функционал:
- Search по названию локации
- GPS location (если разрешено)
- Map loading animation
- Fallback на list если map API недоступна
- Кэширование локаций locally

#### API:
```
GET /locations?city=&rating=&distance=&limit=50
Response: { 
  locations: [
    { id, name, address, lat, lng, rating, reviewCount, playerCount }, 
    ...
  ]
}
```

---

### 8. Location Detail Screen (Деталь локации)

**Путь:** MainFlow → Locations → Location Detail  
**Назначение:** Информация о конкретной площадке

#### Элементы UI:

**Header:**
- Back button
- Share button
- "..." menu (report, block - опционально)

**Content:**
- Location name (большой)
- Rating (stars) + review count
- Address + clickable map preview
- Distance от вас (если GPS)
- Player count ("247 игроков тренировались здесь")

**Sections:**

1. **Информация:**
   - Адрес (full)
   - Телефон (если есть, clickable)
   - Часы работы (если есть)
   - Website link (если есть)

2. **Отзывы:**
   - Average rating (большой)
   - Distribution graph (5 stars - X%, 4 stars - Y%, etc.)
   - List последних отзывов:
     - User avatar/name
     - Rating (stars)
     - Date
     - Review text (truncated)
   - "See all reviews" button

3. **Action Buttons:**
   - "Добавить отзыв" button (если logged in)
   - "Добавить в тренировку" button (pre-fill при логировании)

#### Функционал:
- Smooth map integration
- Clickable address (open in maps)
- Review submission form (modal/bottom sheet)
- Average rating auto-calculate
- Caching location details

#### API:
```
GET /locations/:id
Response: {
  id, name, address, lat, lng, phone, website, hours,
  rating, reviewCount, playerCount,
  reviews: [{ id, userId, userName, rating, text, date }, ...]
}

POST /locations/:id/reviews
Body: { rating, text }
Response: { id, ... review object }
```

---

### 9. My Profile Screen (Мой профиль)

**Путь:** MainFlow → My Profile  
**Назначение:** Управление профилем, снаряжением и настройками

#### Элементы UI:

**Header:**
- "Мой профиль"
- Edit button (toggle edit mode)
- Settings icon

**Sections:**

1. **Профиль (Editable):**
   - Profile picture (tap to change)
   - Name (editable)
   - Email (read-only с copy button)
   - Country (editable dropdown)
   - Member since date
   - Edit/Save button

2. **Статистика:**
   - Total hours
   - Total sessions
   - Match win rate
   - Most used gear
   - Favorite location

3. **Gear Locker:**
   - Заголовок "Ваше снаряжение"
   - List всех paddle setups
   - Для каждого setup:
     - Setup name (e.g., "Main Competition")
     - Blade name
     - Rubbers names
     - GPI score (если есть)
     - Edit/Delete buttons
   - Кнопка "➕ Добавить снаряжение"

**Add/Edit Gear Modal:**
   - Name (editable)
   - Blade model (dropdown/search)
   - Rubber 1 (dropdown/search)
   - Rubber 2 (dropdown/search)
   - Description (textarea)
   - Save/Cancel buttons

4. **Настройки:**
   - Email notifications (toggle)
   - Session reminders (toggle)
   - Language (dropdown)
   - Theme (toggle dark/light)
   - Logout button
   - Delete account button (dangerous)

#### Функционал:
- Image picker для profile picture
- Upload на backend
- Inline editing
- Gear CRUD operations
- Validation перед сохранением
- Loading indicators
- Success notifications

#### API:
```
GET /user/profile
Response: { id, name, email, country, profilePicture, createdAt, stats, gear }

PUT /user/profile
Body: { name, country, profilePicture (file) }
Response: { ...updated user }

POST /user/gear
Body: { name, bladeName, rubber1, rubber2, description }
Response: { id, ...gear object }

PUT /user/gear/:id
Body: { ...updatable fields }
Response: { ...updated gear }

DELETE /user/gear/:id
Response: { success: true }
```

---

### 10. User Profile Screen (Other Players) - View Only

**Путь:** MainFlow → Leaderboard → Player Profile  
**Назначение:** Посмотреть профиль другого игрока

#### Элементы UI:

**Header:**
- Back button
- Player name
- More menu (report, block - опционально)

**Content:**
- Profile picture
- Name
- Country
- Member since
- Current badge

**Статистика (Read-only):**
- Total hours
- Total sessions
- Match win rate
- Favorite location
- Most used gear

**Recent Sessions:**
- List последних сессий (если публичные)

**Gear (Read-only):**
- List paddle setups (если публичные)
- GPI scores (если публичные)

#### Функционал:
- View-only
- No editing capabilities
- Block/report user (опционально)

#### API:
```
GET /users/:userId/profile
Response: { id, name, country, profilePicture, badge, stats, gear, recentSessions }
```

---

### 11. Search Results Screen (Поиск)

**Путь:** MainFlow → Search → Results  
**Назначение:** Результаты поиска пользователей и локаций

#### Элементы UI:

**Header:**
- Search input (with history)
- Cancel button

**Tabs:**
- "Игроки"
- "Площадки"

**Players Tab:**
- List результатов
- Для каждого:
  - Avatar
  - Name
  - Country
  - Current badge
  - Click → User profile

**Locations Tab:**
- List результатов
- Для каждого:
  - Location name
  - Address (кратко)
  - Rating
  - Click → Location detail

**Empty State:**
- "Ничего не найдено"

#### API:
```
GET /search?q=&type=users,locations&limit=20
Response: {
  users: [{ id, name, country, badge, avatar }, ...],
  locations: [{ id, name, address, rating }, ...]
}
```

---

### 12. Settings Screen (Опционально, может быть часть Profile)

**Путь:** MainFlow → My Profile → Settings  
**Назначение:** Приложение и учетные данные

#### Элементы UI:

**Notifications:**
- Email notifications (toggle)
- Push notifications (toggle)
- Session reminders (toggle)
- Leaderboard updates (toggle)

**Appearance:**
- Theme (toggle dark/light)
- Language selection
- Font size (small/normal/large)

**Account:**
- Change password button → modal
- Two-factor authentication (enable/disable) - опционально
- Connected accounts - опционально
- Logout button
- Delete account button (dangerous, requires confirmation)

**About:**
- App version
- Terms & Conditions link
- Privacy Policy link
- Contact support link

#### API:
```
PUT /user/settings
Body: { notifications, theme, language, ... }
Response: { ...updated settings }

POST /auth/change-password
Body: { oldPassword, newPassword }
Response: { success: true }

POST /auth/logout
Response: { success: true }
```

---

## User Flow

### Flow 1: Первый запуск (New User)
```
App Launch
  ↓
Is User Authenticated? → NO
  ↓
SignUp/Login Screen
  ↓
User choose SignUp
  ↓
SignUp Screen
  ├─ Fill name, email, password
  ├─ Validate
  └─ POST /auth/register
    ↓
    Success
    ↓
    Save token locally
    ↓
Dashboard Screen
    ↓
    "Get Started" screen (Tour - опционально)
```

### Flow 2: Логирование тренировки (Main Use Case)
```
Dashboard
  ↓
Click "➕ Новая тренировка"
  ↓
Log Entry Screen (Quick Timer Tab)
  ↓
User enter location
  ↓
Click "Start Session"
  ↓
Timer starts (background)
  ↓
User can navigate app
  ↓
Click "Stop Session"
  ↓
Modal: Add Notes, Select Type, etc.
  ↓
Click "Save"
  ↓
POST /sessions
  ↓
Success
  ↓
Refresh Dashboard (stats updated)
  ↓
Show notification "✅ Сессия сохранена!"
```

### Flow 3: Просмотр прогресса
```
Dashboard
  ↓
Scroll down
  ↓
See Performance Trend Chart
  ├─ Shows rating over time
  ├─ User can see if improving
  └─ Click "Показать подробнее"
    ↓
    History Screen
    ├─ All sessions visible
    ├─ Apply filters if needed
    └─ Click session for details
```

### Flow 4: Управление снаряжением
```
My Profile
  ↓
Scroll to "Gear Locker"
  ↓
Click "➕ Добавить снаряжение"
  ↓
Modal: Enter gear details
  ├─ Name
  ├─ Blade
  ├─ Rubber 1 & 2
  └─ Description
    ↓
    Click "Save"
    ↓
    POST /user/gear
    ↓
    Gear added to locker
    ↓
    Next session can use this gear
```

### Flow 5: Логирование Gear Test
```
Log Entry
  ↓
Manual Entry Tab
  ↓
Select "Gear Test" type
  ↓
Form shows 5 KPI inputs
  ├─ SGC (Short-Game Control)
  ├─ SPN (Spin Potential)
  ├─ PWR (Power)
  ├─ STB (Stability)
  └─ SNS (Spin Sensitivity)
    ↓
    User enters scores (0-100 each)
    ↓
    Select paddle setup
    ↓
    Click "Save"
    ↓
    POST /sessions (type: GearTest)
    ↓
    Backend calculates:
    ├─ GQS = avg(5 KPIs)
    └─ Combined with SAWI
      ↓
      GPI updated for that setup
      ↓
      Dashboard shows new GPI
```

### Flow 6: Проверка Leaderboard
```
Dashboard
  ↓
Click Leaderboard (bottom nav)
  ↓
Leaderboard Screen
  ├─ Weekly tab active
  ├─ Shows rankings
  ├─ Your position highlighted
  └─ Refresh auto every 5 min
    ↓
    Click on player
    ↓
    User Profile (view-only)
    ├─ See their stats
    └─ Motivate to compete
```

---

## API Endpoints

### Authentication
```
POST /auth/register
POST /auth/login
POST /auth/logout
POST /auth/refresh-token
POST /auth/change-password
```

### User Profile
```
GET /user/profile
PUT /user/profile
GET /users/:userId/profile (other user, public)
```

### Sessions
```
POST /sessions
GET /sessions (with filters)
GET /sessions/:id
PUT /sessions/:id
DELETE /sessions/:id
```

### Gear
```
POST /user/gear
GET /user/gear
GET /user/gear/:id
PUT /user/gear/:id
DELETE /user/gear/:id
```

### Stats
```
GET /stats (user's own stats)
GET /stats/performance-trend
GET /stats/badges
```

### Leaderboard
```
GET /leaderboard/weekly
GET /leaderboard/all-time
```

### Locations
```
GET /locations (search, filter)
GET /locations/:id
POST /locations/:id/reviews
GET /locations/:id/reviews
```

### Search
```
GET /search?q=&type=users,locations
```

---

## Фазовое развертывание MVP

### Phase 1 (2 недели) - Base:
- ✅ SignUp / Login
- ✅ Dashboard (базовая статистика)
- ✅ Log Entry (Quick Timer + Manual Practice/Match)
- ✅ History с фильтрацией
- ✅ My Profile (редактирование инфо)

### Phase 2 (2 недели) - Engagement:
- ✅ Badges система
- ✅ Performance Trend Chart
- ✅ Gear Locker (CRUD)
- ✅ Leaderboards (Weekly + All-Time)

### Phase 3 (2 недели) - Complete:
- ✅ GPI система (GQS + SAWI расчеты)
- ✅ Locations + Reviews
- ✅ Search
- ✅ Gear Test логирование
- ✅ Theme toggle
- ✅ Polish & Optimization

---

## Метрики успеха

1. **Retention:** 60%+ users возвращаются в неделю
2. **Engagement:** Average 5+ sessions logged в неделю на user
3. **Adoption:** 40%+ users используют Gear Test для GPI
4. **Social:** 30%+ users участвуют в leaderboards
5. **Quality:** < 2% crash rate, App Store rating 4.5+
