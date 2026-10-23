<div align="center">

<img src="assets/app_logo_splash/app_logo.svg" alt="Health Track logo" width="100" />

# Health Track

### A mobile healthcare application built with Flutter and Firebase

Discover specialists · Book appointments · Share reviews

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Course Project](https://img.shields.io/badge/TSI-Course_Project-13CAD6?style=for-the-badge)

Developed as a university course project at the<br>
**[Transport and Telecommunication Institute (TSI)](https://tsi.lv/lv/)**<br>
*Transporta un sakaru institūts · Riga, Latvia*

[Overview](#overview) · [Features](#features) · [Getting Started](#getting-started) · [Design Credits](#design-credits)

</div>

---

## Overview

**Health Track** is a completed university course project built with Flutter and Firebase. Users can browse medical specialties, filter doctors, save favorites, book appointments, manage their visits, and leave reviews after marking an appointment as completed.

The project explores the path from a Figma design to a working mobile application: reusable UI components, navigation, state management, cloud data, authentication, and automated testing. Its visual identity combines turquoise gradients, rounded controls, medical icons, and League Spartan typography.

Authentication, profiles, favorites, appointments, and reviews are connected to Firebase. The project scope and the UI-only actions retained from the design are described below.

## Features

| Area | Current implementation |
| :--- | :--- |
| **Account access** | Email and password registration, login, and logout through Firebase Authentication. |
| **Biometric login** | Fingerprint or face verification to access an existing Firebase session on Android and iOS. |
| **Doctor discovery** | Firestore-backed doctor lists and queries by medical specialty. |
| **Filters and sorting** | Filter doctors by specialty, gender, rating, and experience, and sort lists alphabetically. |
| **Doctor profiles** | Dedicated doctor details screens with navigation to the scheduling interface. |
| **Personal profile** | Profile creation, live updates, and editing of name, phone number, and date of birth. |
| **Favorites** | Account-specific favorites stored in Firestore and displayed in a dedicated list. |
| **Appointment booking** | Calendar, available time slots, patient details, and transactional Firestore booking to prevent duplicate reservations of a slot. |
| **Appointment management** | Upcoming, completed, and cancelled visits, with appointment details and status changes. Cancelling a booking releases its slot. |
| **Reviews** | One rating and written review per completed appointment, saved in Firestore. |
| **Shared design system** | Reusable buttons, inputs, icons, containers, colors, and text styles. |
| **App branding** | Health Track launcher icons for Android and iOS, plus a branded launch screen. |

### Medical specialties

Cardiology · Dermatology · General Medicine · Gynecology · Odontology · Oncology · Ophthalmology · Orthopedics · Otolaryngology

### Biometric login

Sign in with an email address and password first. On a later app launch, the biometric button verifies your identity through the device and validates the saved Firebase session before opening the home screen.

After **Log Out**, a password is required again. The app receives the system's authentication result and does not read or store fingerprint or face data. Protected routes require an explicitly unlocked account during the current app run.

## Technology Stack

| Technology | Purpose |
| :--- | :--- |
| **Flutter & Dart** | Application UI and logic |
| **Firebase Authentication** | Registration and authentication |
| **Cloud Firestore** | Profiles, doctor data, favorites, appointments, and reviews |
| **Flutter Bloc / Cubit** | Authentication, doctor loading, profile, and scheduling state |
| **GoRouter** | Navigation, route arguments, and access checks |
| **Freezed** | Generated state classes |
| **json_serializable** | Model serialization |
| **local_auth** | Native biometric verification |
| **flutter_screenutil** | Layout scaling based on the design dimensions |
| **flutter_svg** | SVG icons and branding |
| **cached_network_image** | Loading and caching remote images |
| **flutter_test & fake_cloud_firestore** | Unit and widget tests with simulated data |

## Project Structure

```text
lib/
├── app/                 # App providers, router, and session access
├── core/                # Shared constants and serialization helpers
├── data/                # External services and repository implementations
│   ├── repositories/    # Firebase implementations
│   ├── services/        # Device biometric authentication
│   └── mappers/         # Firebase error messages
├── domain/              # Application models and contracts
│   ├── models/          # Appointments, doctors, reviews, schedule, users
│   ├── repositories/    # Repository interfaces
│   ├── enums/           # Shared domain enums
│   ├── filters/         # Doctor filtering rules
│   └── services/        # Availability calculations
├── design_system/       # Reusable components and theme
├── presentation/        # Organized by application section
│   ├── authentication/
│   ├── doctors/
│   ├── favorites/
│   ├── specialties/
│   ├── appointments/
│   ├── schedule/
│   ├── reviews/
│   ├── profile/
│   ├── home/
│   ├── welcome/
│   ├── navigation/
│   └── shared/          # Widgets and helpers used across sections
└── main.dart            # Firebase initialization and dependency providers

assets/                  # Icons, branding, and fonts
test/                    # Mirrors app, data, domain, design_system, presentation
tool/                    # Seed import and native image generation utilities
firestore.rules          # Firestore access rules
```

Repositories handle Firebase operations, Cubits expose loading and result states, and widgets render those states using the shared design system.

Each presentation section uses `pages/` for screens, `widgets/` for its UI parts,
`bloc/` for Cubits and states, and `controllers/` where needed. Add shared UI to
`presentation/shared/` or `design_system/` according to its purpose. Repository
interfaces live in `domain/repositories/`; Firebase implementations live in
`data/repositories/`. Generated `.g.dart` and `.freezed.dart` files stay beside
their source files. Shared test doubles belong in `test/helpers/`.

## Getting Started

### Prerequisites

- Flutter with a Dart SDK compatible with `^3.13.3`, as specified in `pubspec.yaml`.
- Android Studio and the Android SDK, with an emulator or physical device.
- A Firebase project with **Email/Password** authentication enabled and a **Cloud Firestore** database.
- An enrolled fingerprint or face credential for biometric testing.

Android is the verified build target. Other Flutter platform folders are included, but do not imply a tested release on every platform. iOS requires macOS, Xcode, and its own Firebase configuration.

### 1. Install dependencies

From the repository root:

```bash
flutter pub get
```

### 2. Configure Firebase

Register an Android app in your Firebase project using the application ID in `android/app/build.gradle.kts`, then place that project's configuration file at:

```text
android/app/google-services.json
```

The app initializes Firebase through the native platform configuration.

**Firestore setup:** publish the checked-in `firestore.rules` to your Firebase project. The rules cover user profiles, authenticated doctor reads, booking slots, appointments, and reviews. Keeping the file in the repository does not deploy it automatically.

Doctor seed files and import utilities are in `tool/`. With Node.js 18 or later, validate the seed without writing data:

```bash
node tool/import_doctors.mjs
```

The importer currently targets `tsiindproject2`; review its target before using it with your own project. Doctor image values must match the network image URLs expected by the current UI.

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for Firebase connection, rules deployment, and doctor import instructions. The feature table in this README describes the completed course-project scope.

### 3. Run the app

```bash
flutter devices
flutter run -d <device-id>
```

Create an account or sign in, browse doctors, and book a visit. Open the appointments section to cancel or mark a visit as completed, then submit a review. After changing native plugins or launcher icons, stop and rebuild the app instead of relying on hot reload.

### 4. Build an Android APK

```bash
flutter build apk --debug
```

Output: `build/app/outputs/flutter-apk/app-debug.apk`.

## Testing

Run static analysis and the test suite:

```bash
flutter analyze
flutter test
```

For focused authentication and profile checks:

```bash
flutter test test/presentation/authentication test/app/session test/data/repositories/registration_repository_test.dart
```

Tests cover authentication, biometrics, session access, registration, doctor filters, form layouts, calendar behavior, scheduling state, appointment status changes, and reviews. Firebase test doubles allow repository checks to run without creating live accounts. Native biometric prompts and deployed Firestore rules require device and backend verification.

## Project Scope

The course project is complete within its educational scope: authentication, doctor discovery, profiles, favorites, booking, appointment management, and reviews.

Scheduling uses a predefined weekly timetable. Users can mark an upcoming visit as completed to demonstrate the review flow; completion does not require the appointment time to have passed.

Some controls from the original UI kit remain presentation-only: password reset, chat and calls, profile photo upload, payments, settings, help, and selected secondary actions. These are outside the completed implementation scope. The password form validates input but does not change Firebase credentials.

Android is the primary target. The included iOS project and assets require separate Firebase configuration and verification on macOS and an iOS device.

## Design Credits

The interface is based on the Figma Community design supplied as the visual reference for this course project:

**[Medical App UI Kit — Health Mobile App Tracker & Appointment Mobile App](https://www.figma.com/design/QuKc7TsZzKGM1urdwhRY9z/Medical-App-UI-Kit-Health-Mobile-App-Tracker-Appointment-Mobile-App--Community-?node-id=2280-1627)**

Credit for the original UI design belongs to its respective creator(s). This repository contains the Flutter implementation and application logic developed for the course project.

---

<div align="center">

**Health Track · TSI Course Project**<br>
*From a visual concept to a working mobile application.*

</div>
