// These interfaces are supplied by the Firebase plugins under test.
// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:async';

class FakeAuth extends FirebaseAuthPlatform {
  String? errorCode;
  int signUpCalls = 0;
  int signInCalls = 0;
  String? submittedEmail;
  String? savedName;
  UserPlatform? user;
  final changes = StreamController<UserPlatform?>.broadcast();

  @override
  UserPlatform? get currentUser => user;

  @override
  Stream<UserPlatform?> authStateChanges() async* {
    yield user;
    yield* changes.stream;
  }

  @override
  Future<void> signOut() async {
    user = null;
    changes.add(null);
  }

  @override
  FirebaseAuthPlatform delegateFor({
    required FirebaseApp app,
    Persistence? persistence,
  }) => this;

  @override
  FirebaseAuthPlatform setInitialValues({
    InternalUserDetails? currentUser,
    String? languageCode,
  }) => this;

  Future<UserCredentialPlatform> result(String email) async {
    submittedEmail = email;
    if (errorCode != null) throw FirebaseAuthException(code: errorCode!);
    user = FakeUser(this);
    changes.add(user);
    return FakeCredential(auth: this, user: user);
  }

  @override
  Future<UserCredentialPlatform> signInWithEmailAndPassword(
    String email,
    String password,
  ) {
    signInCalls++;
    return result(email);
  }

  @override
  Future<UserCredentialPlatform> createUserWithEmailAndPassword(
    String email,
    String password,
  ) {
    signUpCalls++;
    return result(email);
  }
}

class FakeCredential extends UserCredentialPlatform {
  FakeCredential({required super.auth, required super.user});
}

class FakeMultiFactor extends MultiFactorPlatform {
  FakeMultiFactor(super.auth);
}

class FakeUser extends UserPlatform {
  FakeUser(FakeAuth auth)
    : super(
        auth,
        FakeMultiFactor(auth),
        InternalUserDetails(
          userInfo: InternalUserInfo(
            uid: 'test-user',
            email: auth.submittedEmail ?? 'demo@example.com',
            displayName: auth.savedName ?? 'Test User',
            isAnonymous: false,
            isEmailVerified: false,
          ),
          providerData: [],
        ),
      );

  @override
  Future<void> updateProfile(Map<String, String?> profile) async {
    (auth as FakeAuth).savedName = profile['displayName'];
  }
}
