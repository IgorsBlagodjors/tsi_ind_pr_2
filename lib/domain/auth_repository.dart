import 'package:tsi_ind_pr_2/data/users/app_user.dart';

abstract class AuthRepository {
  AppUser? get currentUser;
  Stream<AppUser?> authStateChanges();
  Future<void> signOut();
  Future<void> refreshSession();
  Future<void> logIn({required String email, required String password});
}

class AuthFailure implements Exception {
  const AuthFailure(this.message);
  final String message;
}
