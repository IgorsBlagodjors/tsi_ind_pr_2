<div align="center">

<img src="assets/app_logo_splash/app_logo.svg" alt="Health Track logo" width="100" />

# Health Track

### A mobile healthcare application built with Flutter and Firebase

Discover specialists · Explore doctor profiles · Manage your account

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

**Health Track** brings doctor discovery and personal account management into one mobile interface. Users can browse medical specialties, view doctor information, manage their profile, and return to a saved account using device biometrics.

The project explores the path from a Figma design to a working mobile application: reusable UI components, navigation, state management, cloud data, authentication, and automated testing. Its visual identity combines turquoise gradients, rounded controls, medical icons, and League Spartan typography.

Appointment scheduling and review screens extend the prototype, with backend integration still in progress.

## Features

| Area | Current implementation |
| :--- | :--- |
| **Account access** | Email and password registration, login, and logout through Firebase Authentication. |
| **Biometric login** | Fingerprint or face verification to access an existing Firebase session on Android and iOS. |
| **Doctor discovery** | Firestore-backed doctor lists and queries by medical specialty. |
| **Doctor profiles** | Dedicated doctor details screens with navigation to the scheduling interface. |
| **Personal profile** | Profile creation, live updates, and editing of name, phone number, and date of birth. |
| **Favorites** | Account-specific favorite IDs stored in Firestore and a dedicated favorites list; some screens still have placeholder favorite actions. |
| **Scheduling interface** | Calendar and patient information form for demonstrating the booking flow. |
| **Shared design system** | Reusable buttons, inputs, icons, containers, colors, and text styles. |

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
| **Cloud Firestore** | Profiles, doctor data, and favorites |
| **Flutter Bloc / Cubit** | Authentication, doctor loading, and profile state |
| **GoRouter** | Navigation, route arguments, and access checks |
| **Freezed** | Generated state classes |
| **local_auth** | Native biometric verification |
| **flutter_screenutil** | Layout scaling based on the design dimensions |
| **flutter_svg** | SVG icons and branding |
| **cached_network_image** | Loading and caching remote images |
| **flutter_test & fake_cloud_firestore** | Unit and widget tests with simulated data |

## Project Structure

```text
lib/
├── app/router/          # Routes and access checks
├── data/                # Models, Firebase repositories, and demo data
│   ├── doctors/
│   ├── users/
│   ├── appointments/
│   ├── reviews/
│   └── schedule/
├── domain/              # Authentication contract and app access state
├── design_system/       # Shared components and theme
├── presentation/        # Screens, widgets, and Cubits
└── main.dart            # Firebase initialization and dependency providers

assets/                  # Icons, branding, and fonts
test/                    # Unit and widget tests
tool/                    # Doctor seed export and import utilities
firestore.rules          # Firestore access rules
```

Repositories handle Firebase operations, Cubits expose loading and result states, and widgets render those states using the shared design system.

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

**Firestore setup:** the checked-in `firestore.rules` currently permits access to each user's own profile and denies access to other collections. The doctor repository queries `doctors`, so the deployed rules must also allow the intended doctor reads before the directory can load. This repository does not confirm which rules are currently deployed.

Doctor seed files and import utilities are in `tool/`. With Node.js 18 or later, validate the seed without writing data:

```bash
node tool/import_doctors.mjs
```

The importer currently targets `tsiindproject2`; review its target before using it with your own project. Doctor image values must match the network image URLs expected by the current UI.

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for profile setup and import details. Some migration notes there describe earlier demo-only screens; the feature table above reflects the current application code.

### 3. Run the app

```bash
flutter devices
flutter run -d <device-id>
```

Create an account or sign in, then explore the directory and profile screens. After changing native plugins, stop and rebuild the app instead of relying on hot reload.

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
flutter test test/login_cubit_test.dart test/app_access_test.dart test/app_user_test.dart test/profile_repository_test.dart
```

Tests cover authentication state changes, repeated submissions, biometric cancellation, session changes, access checks, and profile persistence. Firebase test doubles allow these checks to run without creating live accounts. Native biometric prompts and deployed Firestore rules still require device and backend verification.

## Development Status

This is an evolving academic prototype. Work in progress includes:

- Persisting bookings and connecting appointment history to the backend; the appointments route is currently disabled.
- Submitting doctor reviews.
- Connecting the password reset screen to Firebase.
- Completing chat, call, service, and remaining favorite actions.
- Aligning the checked-in Firestore rules with doctor directory access.
- Completing iOS configuration and device testing.

## Design Credits

The interface is based on the Figma Community design supplied as the visual reference for this course project:

**[Medical App UI Kit — Health Mobile App Tracker & Appointment Mobile App](https://www.figma.com/design/QuKc7TsZzKGM1urdwhRY9z/Medical-App-UI-Kit-Health-Mobile-App-Tracker-Appointment-Mobile-App--Community-?node-id=2280-1627)**

Credit for the original UI design belongs to its respective creator(s). This repository contains the Flutter implementation and application logic developed for the course project.

---

<div align="center">

**Health Track · TSI Course Project**<br>
*From a visual concept to a working mobile application.*

</div>
