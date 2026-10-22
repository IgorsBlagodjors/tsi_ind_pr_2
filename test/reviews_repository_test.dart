import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/reviews/reviews_repository.dart';
import 'package:tsi_ind_pr_2/data/reviews/firebase_reviews_repository.dart';

void main() {
  late FakeFirebaseFirestore db;
  late ReviewsRepository repository;
  setUp(() async {
    db = FakeFirebaseFirestore();
    repository = FirebaseReviewsRepository(firestore: db);
    await db.collection('appointments').doc('visit').set({
      'userId': 'user',
      'doctorId': 'doctor',
      'status': 'completed',
    });
  });

  Future<void> submit({
    String user = 'user',
    int rating = 4,
    String text = ' Helpful visit ',
  }) => repository.add(
    appointmentId: 'visit',
    userId: user,
    doctorId: 'doctor',
    rating: rating,
    text: text,
  );

  test('Saves and reloads one review per appointment', () async {
    expect(await repository.getForAppointment('visit'), isNull);
    await submit();
    final review = await repository.getForAppointment('visit');
    expect(review!.appointmentId, 'visit');
    expect(review.userId, 'user');
    expect(review.doctorId, 'doctor');
    expect(review.rating, 4);
    expect(review.text, 'Helpful visit');
    await expectLater(submit(), throwsA(isA<ReviewFailure>()));
    expect((await db.collection('reviews').get()).docs, hasLength(1));
  });

  test('Rejects another user and unfinished or cancelled visits', () async {
    await expectLater(submit(user: 'other'), throwsA(isA<ReviewFailure>()));
    for (final status in ['upcoming', 'cancelled']) {
      await db.collection('appointments').doc('visit').update({
        'status': status,
      });
      await expectLater(submit(), throwsA(isA<ReviewFailure>()));
    }
    expect((await db.collection('reviews').get()).docs, isEmpty);
  });

  test('Rejects invalid ratings and comments without saving', () async {
    for (final rating in [0, 6]) {
      await expectLater(submit(rating: rating), throwsA(isA<ReviewFailure>()));
    }
    for (final text in ['  ', 'a' * 2001]) {
      await expectLater(submit(text: text), throwsA(isA<ReviewFailure>()));
    }
    expect((await db.collection('reviews').get()).docs, isEmpty);
  });
}
