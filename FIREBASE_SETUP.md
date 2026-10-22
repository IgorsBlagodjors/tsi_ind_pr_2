# Firebase Setup for Health Track

This guide covers the current local version of the Flutter project. The primary setup uses Android, Firebase Authentication, and Cloud Firestore. Run the commands from the repository root in PowerShell.

## 1. Prerequisites

- Install Flutter with a Dart SDK compatible with `^3.13.3` in `pubspec.yaml`, along with the Android SDK.
- Prepare an Android device or emulator.
- Obtain access to the intended Firebase project or create your own.
- The importer requires Node.js 18 or later. For the current Firebase CLI, use a Node.js version supported by that CLI release.

```powershell
flutter doctor
flutter pub get
```

## 2. Connect the Android App

Open your project in the [Firebase Console](https://console.firebase.google.com/) and register an Android app with this package name:

```text
com.example.tsi_ind_pr_2
```

This is the `applicationId` in `android/app/build.gradle.kts`. Download your app's configuration and place it at `android/app/google-services.json`, replacing the existing file when switching projects. The package name in the configuration must match `applicationId`.

The Google Services Gradle plugin is already configured in `android/settings.gradle.kts` and `android/app/build.gradle.kts`. In `lib/main.dart`, `await Firebase.initializeApp()` runs without explicit options: Android loads the native configuration. This setup does not require `firebase_options.dart`. See the [official Android setup guide](https://firebase.google.com/docs/android/setup).

When using your own Firebase project, align these three independent settings:

| File | Setting to check |
| --- | --- |
| `android/app/google-services.json` | Android app configuration for the intended project |
| `.firebaserc` | `projects.default`, currently `tsiindproject2` |
| `tool/import_doctors.mjs` | `const project`, currently `tsiindproject2` |

Changing `.firebaserc` does not switch the app or the importer to another project.

## 3. Authentication

Open **Authentication → Sign-in method**, enable **Email/Password**, and save. The app uses email and password registration and sign-in. See the [Email/Password setup guide for Flutter](https://firebase.google.com/docs/auth/flutter/password-auth).

Do not store user passwords in Firestore. Biometrics unlock access to an existing Firebase session on the device and do not require a separate Firebase provider. Sign in with a password first. After signing out, sign in with a password again.

## 4. Firestore and Security Rules

Create a Cloud Firestore database with the ID `(default)` and choose an appropriate region. Both the app and the importer use this database. Start with rules that deny access, then publish the repository's `firestore.rules` file.

To deploy using the Firebase CLI:

```powershell
npm install -g firebase-tools
firebase login
firebase projects:list
$firebaseProject = 'tsiindproject2' # Replace this with your own project ID if needed.
firebase deploy --only firestore:rules --project $firebaseProject
```

The final command changes the rules of the selected cloud project. `firebase.json` already references `firestore.rules`, so running `firebase init` again is unnecessary. Alternatively, paste the entire file into **Firestore Database → Rules** and select **Publish**. See the [Firebase CLI reference](https://firebase.google.com/docs/cli).

The current local rules provide the following access:

| Path | Client access |
| --- | --- |
| `users/{uid}` | Read, create, and update the user's own profile with field validation; deletion is not allowed |
| `doctors/{doctorId}` | Read after signing in; writes from the app are not allowed |
| `doctors/{doctorId}/bookings/{slotId}` | Read after signing in; creation and deletion require checks against the associated appointment |
| `appointments/{id}` | Owner access with validation of creation and status changes |
| `reviews/{appointmentId}` | Retrieve an individual review as the appointment owner; create after the appointment is completed; listing, updates, and deletion are not allowed |

All other access is denied. Having the rules file in Git does not confirm that it has been deployed to Firebase. These rules belong to an academic prototype and do not by themselves establish readiness for real medical data.

## 5. User Profiles

Firestore profiles are stored at `users/{Firebase Auth UID}`. The app calls `ensureProfile` to create a missing document without overwriting an existing one.

The current rules accept this document structure:

```json
{
  "fullName": "Demo User",
  "email": "demo@example.com",
  "phoneNumber": null,
  "dateOfBirth": null,
  "gender": null,
  "photoUrl": null,
  "favoriteDoctorIds": []
}
```

All seven fields are required; additional fields are forbidden. On creation, the email must match the authenticated user's email. The date of birth must be `null` or a `YYYY-MM-DD` string. Gender must be `null`, `male`, `female`, or `other`. Favorites are stored in the profile as an array of doctor IDs.

**Known mismatch in the current code:** `AppUser.toJson()` in `lib/data/users/app_user.g.dart` includes an `id` field and serializes dates using `toIso8601String()`. `ensureProfile` sends this result to Firestore, but the rules reject `id` and full ISO date strings. Profile creation from the app may therefore fail with `permission-denied` even when Firebase is configured correctly. Before fully testing registration, align serialization with the rules: exclude `id` from written fields and store dates as `YYYY-MM-DD`. Make the fix in the model/converter and regenerate the code instead of manually editing `.g.dart`.

For a manual demo, you can create the document in the Console using the UID from Authentication and the format above. This is a demo workaround, not a registration fix.

## 6. Import Doctors

`tool/doctors.seed.json` contains 34 demo doctors. Each entry has an `id` and `data`; the ID becomes the document name in `doctors`.

Required model fields are `name`, `type`, `specialization`, and `image`. The `type` field must match a `DoctorType` enum value name:

```text
cardiology, dermatology, generalMedicine, gynecology, odontology,
oncology, ophthalmology, orthopedics, otolaryngology
```

Names are case-sensitive. Doctor documents must not contain an `isFavorite` field: favorites belong to individual users.

**Check images before importing:** the seed contains paths such as `assets/avatars/Dr. Daniel.png`, while the UI uses network images. Replace `image` values with accessible HTTPS URLs before the first import. Local validation checks for a nonempty string, but does not verify image availability.

First, validate without network requests or writes:

```powershell
node tool/import_doctors.mjs
```

Check the `Target` line: the importer hardcodes the project in `const project`. It does not support switching projects with a `--project` argument.

Writing requires a Google OAuth access token for an account with Firestore IAM access to the selected project. The Firebase API key from the Android configuration cannot be used for this purpose. With the Google Cloud CLI installed, run:

```powershell
gcloud auth login
$env:FIRESTORE_ACCESS_TOKEN = (gcloud auth print-access-token).Trim()
try {
    node tool/import_doctors.mjs --write
} finally {
    Remove-Item Env:FIRESTORE_ACCESS_TOKEN -ErrorAction SilentlyContinue
}
```

Do not save the token in the repository. `firebase login` authenticates the Firebase CLI and does not, by itself, provide a token to the importer.

The importer creates only missing documents, skips exact matches, and stops before writing if an existing document differs. After writing, it reads the data again to verify it. Changing the seed does not update existing doctors: apply those changes separately after reviewing the differences. Do not delete doctors to reimport them if other documents already reference their IDs.

## 7. Verify the App

```powershell
flutter devices
flutter run -d <device-id>
```

Replace `<device-id>` with your Android device's identifier. After changing `google-services.json`, fully stop and rebuild the app.

1. Register a test user and confirm that the user appears in Authentication.
2. Check the `users/{uid}` profile, accounting for the serialization mismatch in section 5.
3. Sign in and open the doctor directory and specialty filter.
4. Edit the profile and confirm that changes persist after signing in again.
5. Check favorites on screens connected to the repository.
6. To test biometrics, sign in normally first and enroll biometric credentials on the device.

The project includes appointment and review repository implementations. Their presence and deployed rules do not replace testing the full user flow separately.

## 8. Troubleshooting

| Symptom | What to check |
| --- | --- |
| `No matching client found for package name` | The package name in the JSON must match `applicationId` |
| Firebase initialization error | Location of `google-services.json`, Gradle plugin configuration, and a full rebuild |
| `operation-not-allowed` during registration | Whether Email/Password is enabled |
| `permission-denied` for a profile | UID, deployed rules, the extra `id` field, and date format |
| `permission-denied` when reading doctors | Whether the user is signed in and the rules are deployed to the same project |
| Empty doctor directory | Documents in `(default)/doctors` in the intended project |
| Doctor missing from a specialty | Exact `type` value, such as `generalMedicine` |
| Photo does not load | An HTTPS URL in `image` instead of a local asset path |
| HTTP 401/403 during import | OAuth token expiration and the account's IAM access |
| `Existing doctor ... differs` | Differences between the existing document and the seed; the importer deliberately avoids overwriting it |

## Other Platforms

This guide covers the existing Android configuration. The presence of iOS, macOS, Windows, and Web folders does not mean Firebase is configured for those platforms. To add platforms, follow the [official Firebase setup guide for Flutter](https://firebase.google.com/docs/flutter/setup), register the appropriate apps, and align initialization with the resulting configuration.
