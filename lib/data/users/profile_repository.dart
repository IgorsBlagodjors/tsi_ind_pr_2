import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_user.dart';
import '../firestore_dates.dart';

class ProfileRepository {
  ProfileRepository({this.firestore});

  final FirebaseFirestore? firestore;
  FirebaseFirestore get db => firestore ?? FirebaseFirestore.instance;

  // Keep registration fields available if the first write needs to be retried.
  AppUser? pendingRegistration;

  Future<void> ensureProfile(AppUser fallback) async {
    final profile = pendingRegistration?.id == fallback.id
        ? pendingRegistration!
        : fallback;
    final ref = db.collection('users').doc(profile.id);
    await db.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      if (!snapshot.exists) transaction.set(ref, profile.toJson());
    });
    if (pendingRegistration?.id == profile.id) pendingRegistration = null;
  }

  Future<void> toggleFavoriteDoctor(
    String userId,
    String doctorId,
    bool isFavorite,
  ) async {
    await db.collection('users').doc(userId).update({
      'favoriteDoctorIds': isFavorite
          ? FieldValue.arrayRemove([doctorId])
          : FieldValue.arrayUnion([doctorId]),
    });
  }

  Stream<AppUser?> watch(String uid) => db
      .collection('users')
      .doc(uid)
      .snapshots()
      .map(
        (snapshot) => snapshot.exists
            ? AppUser.fromJson({...snapshot.data()!, 'id': snapshot.id})
            : null,
      );

  Future<void> saveDetails({
    required String uid,
    required String fullName,
    required String phoneNumber,
    required DateTime dateOfBirth,
  }) async {
    // Only edit these fields; preserve favorites and other concurrent changes.
    await db.collection('users').doc(uid).update({
      'fullName': fullName.trim(),
      'phoneNumber': phoneNumber.trim(),
      'dateOfBirth': dateOnly(dateOfBirth),
    });
  }

  Future<void> setFavoriteDoctor({
    required String uid,
    required String doctorId,
    required bool removeIfIsFav,
  }) async {
    await db.collection('users').doc(uid).update({
      'favoriteDoctorIds': removeIfIsFav
          ? FieldValue.arrayRemove([doctorId])
          : FieldValue.arrayUnion([doctorId]),
    });
  }
}

String profileErrorMessage(Object? error) {
  if (error is FirebaseException && error.code == 'permission-denied') {
    return 'Profile access denied. Please publish the Firestore rules and retry.';
  }
  return 'Unable to load or save your profile. Check your connection and retry.';
}
