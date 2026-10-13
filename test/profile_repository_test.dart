import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/data/users/profile_repository.dart';

void main() {
  late FakeFirebaseFirestore db;
  late ProfileRepository repository;
  const user = AppUser(
    id: 'one',
    fullName: 'First User',
    email: 'one@example.com',
  );

  setUp(() {
    db = FakeFirebaseFirestore();
    repository = ProfileRepository(firestore: db);
  });

  test(
    'Existing auth account gets one profile without resetting saved data',
    () async {
      await repository.ensureProfile(user);
      await repository.saveDetails(
        uid: user.id,
        fullName: 'Updated Name',
        phoneNumber: '29123456',
        dateOfBirth: DateTime(1997, 4, 12),
      );
      await repository.ensureProfile(user);
      final loaded = await repository.watch(user.id).first;
      expect(loaded!.fullName, 'Updated Name');
      expect(loaded.dateOfBirth, DateTime(1997, 4, 12));
      expect((await db.collection('users').get()).docs, hasLength(1));
    },
  );

  test('Registration fields are saved with UID and no password', () async {
    repository.pendingRegistration = AppUser(
      id: user.id,
      fullName: 'New User',
      email: user.email,
      phoneNumber: '29123456',
      dateOfBirth: DateTime(2000, 1, 2),
    );
    await repository.ensureProfile(user);
    final data = (await db.collection('users').doc(user.id).get()).data()!;
    expect(data['dateOfBirth'], '2000-01-02');
    expect(data['phoneNumber'], '29123456');
    expect(data['fullName'], 'New User');
    expect(data['favoriteDoctorIds'], isEmpty);
    expect(data.containsKey('password'), isFalse);
    expect(repository.pendingRegistration, isNull);
  });

  test('Editing details preserves favorites, email and other users', () async {
    await repository.ensureProfile(user);
    const other = AppUser(
      id: 'two',
      fullName: 'Other User',
      email: 'two@example.com',
    );
    await repository.ensureProfile(other);
    await db.collection('users').doc(user.id).update({
      'favoriteDoctorIds': ['doctor-1'],
    });
    await repository.saveDetails(
      uid: user.id,
      fullName: '  Edited  ',
      phoneNumber: '29123456',
      dateOfBirth: DateTime(1990, 7, 8),
    );
    final loaded = await repository.watch(user.id).first;
    expect(loaded!.favoriteDoctorIds, ['doctor-1']);
    expect(loaded.email, user.email);
    expect(loaded.fullName, 'Edited');
    expect((await repository.watch(other.id).first)!.fullName, 'Other User');
  });
}
