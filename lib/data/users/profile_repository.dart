import 'app_user.dart';

abstract class ProfileRepository {
  AppUser? get pendingRegistration;
  set pendingRegistration(AppUser? value);

  Future<void> ensureProfile(AppUser fallback);

  Future<void> toggleFavoriteDoctor(
    String userId,
    String doctorId,
    bool isFavorite,
  );

  Stream<AppUser?> watch(String uid);

  Future<void> saveDetails({
    required String uid,
    required String fullName,
    required String phoneNumber,
    required DateTime dateOfBirth,
  });

  Future<void> setFavoriteDoctor({
    required String uid,
    required String doctorId,
    required bool removeIfIsFav,
  });
}
