import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsi_ind_pr_2/data/firestore_dates.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/data/users/profile_repository.dart';

class FirebaseProfileRepository implements ProfileRepository {
  FirebaseProfileRepository({this.firestore});

  final FirebaseFirestore? firestore;
  FirebaseFirestore get db => firestore ?? FirebaseFirestore.instance;

  @override
  AppUser? pendingRegistration;

  @override
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

  @override
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

  @override
  Stream<AppUser?> watch(String uid) => db
      .collection('users')
      .doc(uid)
      .snapshots()
      .map(
        (snapshot) => snapshot.exists
            ? AppUser.fromJson({...snapshot.data()!, 'id': snapshot.id})
            : null,
      );
  @override
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

  @override
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
