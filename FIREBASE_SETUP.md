# User profiles

Publish the contents of `firestore.rules` in Firebase Console for project
`tsiindproject2`: Firestore > Rules > Publish. The file on disk does not deploy
automatically. Alternatively, with an authenticated Firebase CLI, run:

```sh
firebase deploy --only firestore:rules --project tsiindproject2
```

The rules allow each signed-in user to read and write only their own
`users/{uid}` profile. Other collections remain denied. Never use public
read/write rules for this application.

After publishing, restart the app and log in. An existing account gets a
profile from its Firebase Auth name and email if no document exists. Fill in
the missing phone and birth date in Profile > Profile > Confirm.

New registrations also pass phone and birth date to profile creation. If the
write fails, the profile screen offers Retry; it does not register the account
again. These pending registration fields are held in memory until saved, so
after a full restart missing fields may need to be entered in Edit Profile.

Home and Profile listen to the user's document. Confirm updates name, phone
and birth date while preserving favorites and other fields. Email is read-only;
changing the authentication email needs a separate verification flow.

Doctors, appointment lists and the calendar still use demo data. Avatar upload
and changing favorite doctors are not connected to Firestore yet.

Tests use fake Firestore and Firebase Auth. They do not create live accounts
or replace testing published security rules in the Firebase emulator/console.

## Import the existing demo doctors

The prepared seed contains 34 fictional doctors from `lib/data/doctors/doctors.dart`.
Regenerate it with `dart run tool/export_doctors.dart`. Validate locally with
`node tool/import_doctors.mjs` (no network access or writes).

To import into project `tsiindproject2`, database `(default)`, sign in to Google
Cloud Shell with an account that has Firestore IAM write access. Upload both
`tool/import_doctors.mjs` and `tool/doctors.seed.json` into the same directory,
then run `node import_doctors.mjs --write` from that directory. The script uses
`gcloud auth print-access-token`; no token needs to be pasted into chat or source.
Locally, it can also read a Google OAuth access token from FIRESTORE_ACCESS_TOKEN.

The importer reads the target documents first, skips exact matches, and stops
before writing if an existing document differs. Missing doctors are created
atomically with an `exists: false` precondition, then all 34 documents are read
back and compared. A successful run prints `Verified 34 doctors in Firestore`.
Preparation and dry-run validation alone do not mean the live import completed.

Images remain bundled asset paths; this import does not upload image binaries.
Account-specific favorites are excluded. Firestore rules and app data sources
are unchanged: client reads for doctors must be enabled when wiring the doctors
repository, while client writes should remain denied.
