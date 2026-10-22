import 'dart:async';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/doctors/firebase_doctors_repository.dart';

void main() {
  test('Empty favorites return an empty list', () async {
    final repository = FirebaseDoctorsRepository(
      firestore: FakeFirebaseFirestore(),
    );
    expect(await repository.watchFavoriteDoctors([]).first, isEmpty);
  });

  test('Favorites query excludes other doctors and deduplicates IDs', () async {
    final db = FakeFirebaseFirestore();
    for (final id in ['a', 'b']) {
      await db.collection('doctors').doc(id).set({
        'name': id,
        'type': 'cardiology',
        'specialization': 'Heart',
        'image': '',
      });
    }
    final repository = FirebaseDoctorsRepository(firestore: db);
    final doctors = await repository.watchFavoriteDoctors([
      'a',
      'a',
      'missing',
    ]).first;
    expect(doctors.map((doctor) => doctor.id), ['a']);
  });

  test(
    'More than 30 favorites combine batches and receive live updates',
    () async {
      final db = FakeFirebaseFirestore();
      final ids = List.generate(31, (index) => 'doctor-$index');
      for (final id in ids) {
        await db.collection('doctors').doc(id).set({
          'name': id,
          'type': 'cardiology',
          'specialization': 'Heart',
          'image': '',
        });
      }
      final repository = FirebaseDoctorsRepository(firestore: db);
      final initial = Completer<void>();
      final updated = Completer<void>();
      final subscription = repository.watchFavoriteDoctors(ids).listen((
        doctors,
      ) {
        expect(doctors.length, 31);
        if (!initial.isCompleted) initial.complete();
        if (doctors.any((doctor) => doctor.name == 'Updated') &&
            !updated.isCompleted) {
          updated.complete();
        }
      });
      addTearDown(subscription.cancel);
      await initial.future.timeout(const Duration(seconds: 5));
      await db.collection('doctors').doc(ids.last).update({'name': 'Updated'});
      await updated.future.timeout(const Duration(seconds: 5));
    },
  );
}
