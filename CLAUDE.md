# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Trusted App is a gaming marketplace Flutter application built with Clean Architecture principles. The app uses a feature-based structure with BLoC/Cubit state management and GoRouter for navigation.

## Common Commands

### Development
```bash
# Run the app (with DevicePreview enabled for testing different device sizes)
flutter run

# Run on specific device
flutter run -d <device_id>

# Hot reload while running
# Press 'r' in terminal for hot reload, 'R' for hot restart

# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade
```

### Code Quality
```bash
# Run static analysis
flutter analyze

# Format code
dart format .

# Run lints on specific feature
flutter analyze lib/features/<feature_name>

# Check for outdated dependencies
flutter pub outdated
```

### Testing
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/<test_file>.dart
```

### Build
```bash
# Build APK for Android
flutter build apk --release

# Build app bundle for Android
flutter build appbundle --release

# Build IPA for iOS
flutter build ios --release

# Build for Windows
flutter build windows --release
```

## Architecture

### High-Level Structure

The app follows **Clean Architecture** with a **feature-based folder structure**:

```
lib/
├── main.dart                    # Entry point
├── app.dart                     # Root app widget
├── core/                        # Shared infrastructure
│   ├── theme/                   # Design system (colors, typography, spacing)
│   ├── router/                  # Navigation (GoRouter configuration)
│   ├── utils/                   # Utilities (responsive helpers, etc.)
│   ├── widgets/                 # Shared widgets
│   └── providers/               # Dependency injection
└── features/                    # Feature modules
    ├── splash/
    ├── onboarding/
    ├── login/
    ├── signup/
    ├── forgot_password/
    ├── home/
    ├── chat/
    ├── notifications/
    ├── games/
    ├── profile/
    └── security_privacy/
```

### Feature Structure Pattern

Each feature follows this structure:

```
features/<feature_name>/
├── data/                        # Data layer (models, repositories, data sources)
│   ├── models/
│   ├── repositories/
│   └── datasources/
├── domain/                      # Domain layer (entities, use cases) - if needed
└── presentation/                # Presentation layer
    ├── screens/                 # Full-screen widgets
    ├── widgets/                 # Feature-specific widgets
    └── cubit/                   # State management (cubit, state)
```

**Note:** Simpler features may omit the `domain/` layer if business logic is minimal.

### State Management

- **Pattern**: BLoC/Cubit using `flutter_bloc` package
- **Cubit**: Handles business logic and state changes
- **State**: Immutable state classes using `equatable` for value equality
- **State Pattern**: Usually follows: `initial`, `loading`, `success`, `failure`
- **Provider Injection**: Use wrapper widgets when BlocProvider cannot be used in router

Example state management pattern:
```dart
// In screen's build method
BlocConsumer<FeatureCubit, FeatureState>(
  listener: (context, state) {
    // Handle side effects (navigation, snackbar, etc.)
  },
  builder: (context, state) {
    // Build UI based on state
  },
)
```

### Navigation

- **Router**: GoRouter (`go_router` package)
- **Configuration**: `lib/core/router/app_router.dart`
- **Usage**: Navigate using context methods:
  ```dart
  context.push('/route');           // Push new route
  context.go('/route');             // Replace current route
  context.goNamed('route-name');    // Navigate by name
  ```

**Important**: All routes must be registered in `AppRouter.createRouter()` before use.

### Design System

All design tokens are centralized in `lib/core/theme/`:

- **Colors**: `AppColors` class - Use constants instead of hardcoded colors
- **Typography**: `AppTextStyles` class - Named text styles (heading, body, caption, etc.)
- **Spacing**: `AppSpacing` class - Consistent spacing values
- **Border Radius**: `AppRadius` class - Standardized corner radius values
- **Shadows**: `AppShadows` class - Elevation shadows
- **Padding**: `AppPadding` class - Standard padding values

**Rule**: Never hardcode colors, sizes, or spacing. Always use design system constants.

### Naming Conventions

- **Files**: `snake_case.dart` (e.g., `home_screen.dart`, `profile_cubit.dart`)
- **Classes**: `PascalCase` (e.g., `HomeScreen`, `ProfileCubit`)
- **Variables/Methods**: `camelCase` (e.g., `userName`, `fetchData()`)
- **Constants**: `lowerCamelCase` for private, `UPPER_SNAKE_CASE` for public static consts
- **Private members**: Prefix with `_` (e.g., `_privateMethod()`)

### Key Dependencies

- **State Management**: `flutter_bloc: ^8.1.6`, `equatable: ^2.0.5`
- **Navigation**: `go_router: ^14.6.2`
- **UI**: `google_fonts: ^6.2.1`, `cached_network_image: ^3.4.1`, `shimmer: ^3.0.0`
- **Persistence**: `shared_preferences: ^2.3.2`
- **Device Preview**: `device_preview: ^1.3.1` (enabled in main.dart)

### Development Notes

- **Device Preview**: Enabled by default for testing on different device sizes
- **Theme Mode**: Currently uses dark theme (`ThemeMode.dark`)
- **Entry Point**: App starts at `/` route (SplashScreen)
- **Navigation Flow**: Splash → checks auth state → Onboarding/Login/Home
- **Error Handling**: 404 screen defined in `AppRouter` as `_ErrorScreen`

### Code Style

- **Lints**: Uses `flutter_lints` package
- **Analysis**: Run `flutter analyze` before committing
- **Formatter**: Use `dart format .` to format code
- **Imports**: Organize imports (dart → package → project)
- **Widget Composition**: Prefer smaller, reusable widgets
- **Const**: Use `const` constructors wherever possible

### Adding New Features

When adding a new feature:

1. Create feature directory under `lib/features/<feature_name>/`
2. Follow the feature structure pattern (data/presentation/cubit)
3. Create screen(s) in `presentation/screens/`
4. Create cubit and state in `presentation/cubit/` or `cubit/`
5. Add route to `lib/core/router/app_router.dart`
6. Use design system tokens for all styling
7. Run `flutter analyze` to check for issues
8. Test navigation to/from the new screen

### Testing Strategy

- Unit tests for cubits and business logic
- Widget tests for UI components
- Integration tests for user flows (not yet implemented)
- Test files should mirror the structure of `lib/` directory

### Platform-Specific

- **Android**: Configuration in `android/` directory
- **iOS**: Configuration in `ios/` directory
- **Windows**: Configuration in `windows/` directory
- Minimum SDK: Dart 3.11.1+

### Important Files

- `pubspec.yaml`: Dependencies and project metadata
- `analysis_options.yaml`: Linting rules
- `lib/main.dart`: App entry point with DevicePreview
- `lib/app.dart`: Root app widget with theme and router
- `lib/core/router/app_router.dart`: All route definitions
- `lib/core/theme/`: Design system tokens

### Common Patterns

**BlocListener for side effects:**
```dart
BlocListener<FeatureCubit, FeatureState>(
  listener: (context, state) {
    if (state is FeatureError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: /* UI */,
)
```

**Repository pattern:**
```dart
class FeatureRepository {
  final FeatureRemoteDataSource remoteDataSource;
  final FeatureLocalDataSource localDataSource;

  // Methods to fetch/manipulate data
  Future<DataModel> fetchData() async {
    // Implementation
  }
}
```

**Responsive design:**
Use `ResponsiveUtils` from `lib/core/utils/responsive_utils.dart` for adaptive layouts.
