import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';

void main() {
  test('Age changes on the birthday, not at the start of the year', () {
    final user = AppUser(
      id: 'test-user',
      fullName: 'Jane Doe',
      email: 'jane@example.com',
      dateOfBirth: DateTime(2000, 10, 10),
    );
    expect(user.ageOn(DateTime(2026, 10, 9)), 25);
    expect(user.ageOn(DateTime(2026, 10, 10)), 26);
    expect(user.ageOn(DateTime(2026, 10, 11)), 26);
    expect(user.ageOn(DateTime(1999, 12, 31)), isNull);
  });

  test('Missing birth date does not imply age zero', () {
    const user = AppUser(
      id: 'test',
      fullName: 'Jane',
      email: 'jane@example.com',
    );
    expect(user.age, isNull);
    expect(user.favoriteDoctorIds, isEmpty);
  });

  test(
    'Leap-day birthday reaches the next age on March 1 in a normal year',
    () {
      final user = AppUser(
        id: 'test',
        fullName: 'Jane',
        email: 'jane@example.com',
        dateOfBirth: DateTime(2000, 2, 29),
      );
      expect(user.ageOn(DateTime(2025, 2, 28)), 24);
      expect(user.ageOn(DateTime(2025, 3, 1)), 25);
    },
  );
}
