# StreetBite V1.0

StreetBite is a production-oriented Flutter food discovery and ordering app.
Users authenticate with Firebase, discover live meals from TheMealDB, cache the
menu locally, open meal details, save favourites, build a cart, place orders,
switch English/Arabic, and choose light/dark themes.

## Features

- Fade-in splash screen with Firebase authentication persistence.
- Email/password login and registration with friendly Firebase error mapping.
- Full English and Arabic runtime localization using Flutter Localizations and
  ARB resources.
- Responsive home screen using `MediaQuery`, featured `PageView`, hot offers,
  and a two-column live menu.
- Dio + Retrofit TheMealDB integration with SharedPreferences cache fallback.
- Meal details with category, origin, instructions, favourite, and cart actions.
- Firestore-backed favourites, orders, and singleton data service.
- Reactive cart count, quantity updates, removal, and order placement.
- Light/dark theme switching using persisted `ThemeCubit` state.
- Nearby vendor map bonus screen with five sample locations.

## Architecture

The project follows Clean Architecture:

```text
lib/
├── core/          # API, DI, preferences, theme, shared utilities
├── data/          # Retrofit sources, cache, Firestore service, models
├── domain/        # Entities, repository contracts, use cases
├── presentation/ # Cubits, screens, and reusable widgets
└── l10n/          # app_en.arb, app_ar.arb, generated localizations
```

Patterns used:

- **Builder:** `UserEntityBuilder` keeps authenticated profile construction
  explicit and extensible.
- **Factory:** `MealDataSourceFactory` applies network-first/cache-fallback
  source selection.
- **Singleton:** `FirestoreService.instance` provides one user-data gateway.
- **Dependency injection:** GetIt wires interfaces, data sources, repositories,
  use cases, and Cubits in one composition root.

## Setup

1. Install Flutter SDK compatible with Dart `^3.10.4`.
2. Configure Firebase for the Android/iOS/web targets and place the generated
   Firebase options in the project.
3. Enable Email/Password Authentication and Cloud Firestore.
4. Add a Google Maps API key for Android/iOS if the bonus map screen is used.
5. Run:

```bash
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

## Localization

Edit [lib/l10n/app_en.arb](lib/l10n/app_en.arb) and
[lib/l10n/app_ar.arb](lib/l10n/app_ar.arb). Flutter generates
`AppLocalizations` during `flutter pub get`; do not add hard-coded user-facing
strings to widgets.

## Permissions and services

- Android Internet permission is declared for API and Firebase access.
- Firebase Authentication persists the signed-in user across restarts.
- Firestore rules must restrict `users/{uid}` data to the authenticated owner.
- Google Maps requires platform API keys and billing configuration.
- Image selection, biometrics, and device details are optional bonus extensions
  and are isolated behind feature-specific services when enabled.

## Beta delivery

Build the Android release artifact:

```bash
flutter build apk --release
```

Upload `build/app/outputs/flutter-apk/app-release.apk` to Firebase App
Distribution, add at least two tester email addresses, and attach the dashboard
and tester invitation screenshots to the submission package. The repository is
ready for this external release step, which requires the team's Firebase
credentials and tester accounts.

## QA evidence

The recommended completion package includes:

- Manual test plan and execution results for Splash, Login, Sign Up, Home,
  Details, Favourites, Cart, Orders, Profile, and Map.
- Traceability matrix mapping functional requirements to test IDs.
- Jira links/screenshots for failed cases.
- Test closure summary with Pass, Fail, and Blocked counts.
- Optional Appium Java project with a shared `BaseTest` for login, scrolling,
  cart, and SnackBar scenarios.

## Delivery checklist

- [x] Clean Architecture folders and dependency injection
- [x] English/Arabic localization and runtime language toggle
- [x] Light/dark theme support
- [x] Live API and local cache fallback
- [x] Firebase auth, Firestore favourites, and orders
- [x] Responsive home, details, cart, profile, and order screens
- [x] Brown StreetBite branding and reusable widgets
- [x] `flutter analyze` passes
- [x] `flutter test` passes
- [ ] Firebase App Distribution upload and tester screenshots
- [ ] Manual QA/Jira/Appium evidence package
