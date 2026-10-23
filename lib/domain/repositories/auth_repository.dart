import 'package:tsi_ind_pr_2/domain/models/users/app_user.dart';

abstract class AuthRepository {
  AppUser? get currentUser;
  Stream<AppUser?> authStateChanges();
  Future<void> signOut();
  Future<void> refreshSession();
  Future<RegistrationResult> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    DateTime? dateOfBirth,
  });
  Future<void> logIn({required String email, required String password});
}

class AuthFailure implements Exception {
  const AuthFailure(this.message);
  final String message;
}

class RegistrationResult {
  const RegistrationResult(this.user, {this.warning});
  final AppUser user;
  final String? warning;
}
