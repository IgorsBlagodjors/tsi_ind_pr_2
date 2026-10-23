import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:tsi_ind_pr_2/data/repositories/firebase_auth_repository.dart';
import 'package:tsi_ind_pr_2/data/repositories/firebase_profile_repository.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';

class TestUser implements User {
  bool failName = false;
  String? savedName;
  @override
  String get uid => 'new-user';
  @override
  String? get email => 'user@example.com';
  @override
  Future<void> updateDisplayName(String? name) async {
    if (failName) throw FirebaseAuthException(code: 'network-request-failed');
    savedName = name;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class Credential implements UserCredential {
  Credential(this.user);
  @override
  final User? user;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestAuth implements FirebaseAuth {
  final user = TestUser();
  bool fail = false;
  String? receivedEmail;
  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    receivedEmail = email;
    if (fail) throw FirebaseAuthException(code: 'email-already-in-use');
    return Credential(user);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  for (final nameFails in [false, true]) {
    test(
      'Registration prepares profile; display-name failure=$nameFails',
      () async {
        final auth = TestAuth()..user.failName = nameFails;
        final profiles = FirebaseProfileRepository(
          firestore: FakeFirebaseFirestore(),
        );
        final repository = FirebaseAuthRepository(auth, profiles);
        final birthday = DateTime(2000, 1, 2);
        final result = await repository.register(
          email: ' user@example.com ',
          password: 'password',
          fullName: ' Test User ',
          phoneNumber: ' 123 ',
          dateOfBirth: birthday,
        );
        expect(auth.receivedEmail, 'user@example.com');
        expect(result.user.fullName, 'Test User');
        expect(profiles.pendingRegistration?.phoneNumber, '123');
        expect(profiles.pendingRegistration?.dateOfBirth, birthday);
        expect(result.warning, nameFails ? isNotNull : isNull);
        await profiles.ensureProfile(result.user);
        expect(
          (await profiles
                  .watch(result.user.id)
                  .firstWhere((user) => user != null)
                  .timeout(const Duration(seconds: 2)))
              ?.fullName,
          'Test User',
        );
      },
    );
  }
  test(
    'Registration translates Firebase errors without preparing a profile',
    () async {
      final auth = TestAuth()..fail = true;
      final profiles = FirebaseProfileRepository(
        firestore: FakeFirebaseFirestore(),
      );
      await expectLater(
        FirebaseAuthRepository(
          auth,
          profiles,
        ).register(email: 'a', password: 'b', fullName: 'c', phoneNumber: 'd'),
        throwsA(isA<AuthFailure>()),
      );
      expect(profiles.pendingRegistration, isNull);
    },
  );
}
