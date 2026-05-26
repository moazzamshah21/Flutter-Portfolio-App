# Premium Developer Portfolio

A cross-platform Flutter mobile application that showcases a developer's professional profile, projects, work experience, and contact information. Built with a premium dark UI, smooth animations, and a clean MVVM architecture using sealed state classes.

## Features

### Screens & Navigation

| Tab | Content |
|-----|---------|
| **Home** | Profile photo, name, role, bio, Work/CV buttons, stats (years, projects, likes), core tech pills |
| **Work** | Featured project cards with images, tags, tap-to-open detail modal |
| **Timeline** | Vertical experience timeline with active/inactive indicators |
| **Profile** | About section, skill proficiency bars, contact grid (Email, LinkedIn, GitHub, Twitter), like button |

### Interactions

- Animated splash screen with spinning rings
- Tab transitions with fade + slide via `AnimatedSwitcher`
- Project detail modal slides up from bottom
- Native share sheet via `share_plus`
- External URL launching (LinkedIn, GitHub, Twitter) via `url_launcher`
- Clipboard copy for email
- Like portfolio with counter
- Toast notifications for user feedback
- Haptic feedback on interactions
- Error state with retry button

### UI/UX Design

- Dark theme (`#020617` background)
- Glassmorphism cards with blur effect
- Blue accent palette with gradient profile ring
- Google Fonts (Inter)
- Material 3
- Responsive layout with safe areas

## Tech Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter 3.x |
| Language | Dart 3.10+ |
| Architecture | MVVM |
| State Management | ChangeNotifier + sealed states |
| Fonts | google_fonts (Inter) |
| Sharing | share_plus |
| URL Launching | url_launcher |
| Linting | flutter_lints |
| Testing | flutter_test |

## Architecture — MVVM

The app follows **Model–View–ViewModel (MVVM)** architecture with a clear separation of concerns:

| Layer | Responsibility | Location |
|-------|----------------|----------|
| **Model** | Data structures & domain entities | `lib/models/` |
| **View** | UI rendering, user input, animations | `lib/views/`, `lib/core/widgets/` |
| **ViewModel** | Business logic, state management | `lib/viewmodels/` |
| **Repository** | Data fetching & data source abstraction | `lib/data/repositories/` |

### Why MVVM?

- **Testability** — ViewModel can be unit tested without widgets
- **Separation of concerns** — Views are "dumb"; logic lives in ViewModel
- **Scalability** — Easy to swap mock data for a real API later
- **Maintainability** — Each layer has a single responsibility

## Project Structure

```
lib/
├── main.dart                          # App entry point, theme setup
├── core/
│   ├── state/
│   │   ├── async_state.dart           # Generic sealed async state wrapper
│   │   └── portfolio_ui_state.dart    # Screen-level sealed UI states
│   ├── theme/
│   │   └── app_colors.dart            # Design tokens / color palette
│   └── widgets/
│       ├── glass_container.dart       # Reusable glassmorphism component
│       ├── portfolio_bottom_nav.dart  # Bottom navigation bar
│       ├── project_detail_modal.dart  # Project detail overlay
│       ├── splash_screen.dart         # Animated splash screen
│       └── toast_overlay.dart         # Toast notification system
├── data/
│   └── repositories/
│       └── portfolio_repository.dart  # Data source (mock → API-ready)
├── models/
│   └── portfolio_models.dart          # Domain models (PortfolioData, Project, Experience)
├── viewmodels/
│   └── portfolio_view_model.dart      # Business logic & state orchestration
└── views/
    ├── portfolio_view.dart            # Root screen (state-driven rendering)
    └── tabs/
        ├── home_tab.dart              # Profile hero, stats, skills preview
        ├── projects_tab.dart          # Featured work grid
        ├── experience_tab.dart        # Career timeline
        └── profile_tab.dart           # About, skills, contact, like
```

## State Management

The app uses a **two-tier sealed state system** — a pattern that makes UI states explicit, type-safe, and exhaustive.

### `AsyncState<T>` — Generic Async Operations

Handles any asynchronous operation (loading data, sharing, etc.):

```dart
sealed class AsyncState<T> {}
final class AsyncInitial<T>  extends AsyncState<T> {}   // Not started
final class AsyncLoading<T>  extends AsyncState<T> {}   // In progress
final class AsyncSuccess<T>  extends AsyncState<T> {}   // Completed with data
final class AsyncError<T>    extends AsyncState<T> {}   // Failed with message
```

**Used for:**

- Portfolio data fetch (`AsyncState<PortfolioData>`)
- Share action (`AsyncState<void>`)

### `PortfolioUiState` — Screen-Level UI States

Represents what the user sees at any moment:

```dart
sealed class PortfolioUiState {}
final class PortfolioUiSplash   // Animated splash screen
final class PortfolioUiLoading  // Loading spinner
final class PortfolioUiError    // Error screen with retry
final class PortfolioUiContent  // Main app (tabs, modal, interactions)
```

The ViewModel exposes a single `uiState` getter that **derives** the correct UI state from internal async states and interaction flags. The View uses an exhaustive `switch` to render the correct screen — the compiler ensures all cases are handled.

### ViewModel — `ChangeNotifier`

- Uses Flutter's built-in `ChangeNotifier` (no third-party state management library)
- View listens via `ListenableBuilder`
- ViewModel is **injectable** — `PortfolioRepository` can be mocked for testing

## Data Flow

```
User Action (tap, swipe)
        │
        ▼
   PortfolioView          ← handles haptics, toasts, animations only
        │
        ▼
 PortfolioViewModel       ← business logic, state mutations
        │
        ▼
 PortfolioRepository     ← data fetching (currently mock, API-ready)
        │
        ▼
   PortfolioData          ← immutable domain model
        │
        ▼
 notifyListeners()         ← triggers UI rebuild
        │
        ▼
 ListenableBuilder        ← rebuilds View from uiState
        │
        ▼
 switch (uiState)          ← renders Splash / Loading / Error / Content
```

**Example — Loading portfolio on startup:**

1. `PortfolioView` creates `PortfolioViewModel` and calls `initialize()`
2. ViewModel sets `_portfolioState = AsyncLoading()` → `notifyListeners()`
3. `uiState` returns `PortfolioUiSplash` (splash plays while loading)
4. Repository returns mock data after 400ms delay
5. ViewModel sets `_portfolioState = AsyncSuccess(data)`
6. Splash completes → `onSplashComplete()` → `PortfolioUiContent` with fade-in

## Design Patterns

| Pattern | Where | Why |
|---------|-------|-----|
| **MVVM** | Overall architecture | Separation of UI and logic |
| **Repository** | `PortfolioRepository` | Abstracts data source; swap mock → API easily |
| **Sealed Classes** | `AsyncState`, `PortfolioUiState` | Type-safe, exhaustive state handling |
| **Dependency Injection** | ViewModel constructor | Repository is injectable for testing |
| **Observer** | `ChangeNotifier` + `ListenableBuilder` | Reactive UI updates |
| **Composition** | Reusable widgets (`GlassContainer`, tabs) | DRY, modular UI |
| **Immutable Models** | `PortfolioData`, `Project`, `Experience` | Predictable state, const constructors |

## Getting Started

### Prerequisites

- Flutter SDK 3.x
- Dart 3.10+

### Run the app

```bash
git clone <your-repo-url>
cd mockapp
flutter pub get
flutter run
```

**Supported targets:** `flutter run -d android`, `-d ios`, `-d chrome`, etc.

## Future Improvements

The architecture is designed to grow:

1. **API integration** — Replace mock data in `PortfolioRepository` with REST calls; ViewModel and Views unchanged
2. **Dependency injection** — Add `get_it` or `riverpod` for service locator / DI container
3. **Unit tests** — ViewModel is fully testable; mock repository returns controlled data
4. **Widget tests** — Each tab is a pure widget receiving props
5. **Localization** — Strings can be extracted to ARB files
6. **Analytics** — Track tab views, project taps, share events in ViewModel
7. **Offline support** — Cache portfolio data locally with `shared_preferences` or `hive`
8. **Deep linking** — Open specific project/tab via URL scheme

## License

This project is for portfolio and demonstration purposes.
