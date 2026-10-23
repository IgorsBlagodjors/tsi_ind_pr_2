import '../../domain/repositories/profile_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';

import '../mappers/auth_error_message.dart';
import '../../domain/models/users/app_user.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth, this._profiles);
  final ProfileRepository _profiles;
  final FirebaseAuth _auth;

  AppUser? _profile(User? user) => user == null
      ? null
      : AppUser(
          id: user.uid,
          fullName: user.displayName ?? '',
          email: user.email ?? '',
          phoneNumber: user.phoneNumber,
        );

  @override
  AppUser? get currentUser => _profile(_auth.currentUser);

  @override
  Stream<AppUser?> authStateChanges() => _auth.authStateChanges().map(_profile);

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> refreshSession() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthFailure('Log in with your email and password first.');
    }
    try {
      await user.reload();
      await user.getIdToken(true);
      if (_auth.currentUser?.uid != user.uid) {
        throw const AuthFailure(
          'Your session has changed. Please log in again.',
        );
      }
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(authErrorMessage(error));
    }
  }

  @override
  Future<RegistrationResult> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user!;
      final profile = AppUser(
        id: user.uid,
        fullName: fullName.trim(),
        email: user.email ?? email.trim(),
        phoneNumber: phoneNumber.trim(),
        dateOfBirth: dateOfBirth,
      );
      _profiles.pendingRegistration = profile;
      String? warning;
      try {
        await user.updateDisplayName(profile.fullName);
      } on FirebaseAuthException {
        warning = 'Account created, but the name could not be saved.';
      }
      return RegistrationResult(profile, warning: warning);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(authErrorMessage(error));
    }
  }

  @override
  Future<void> logIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(authErrorMessage(error));
    }
  }
}
