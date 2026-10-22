import 'dart:async';

import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';

class ProfileAuth implements AuthRepository {
  ProfileAuth(this.currentUser);
  @override
  Future<RegistrationResult> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    DateTime? dateOfBirth,
  }) async => throw UnimplementedError();
  @override
  AppUser? currentUser;
  final changes = StreamController<AppUser?>.broadcast(sync: true);

  void setUser(AppUser? user) {
    currentUser = user;
    changes.add(user);
  }

  @override
  Stream<AppUser?> authStateChanges() => changes.stream;

  @override
  Future<void> signOut() async => setUser(null);

  @override
  Future<void> refreshSession() async {}

  @override
  Future<void> logIn({required String email, required String password}) async {
    throw UnimplementedError();
  }
}
