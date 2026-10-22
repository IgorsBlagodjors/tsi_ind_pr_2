import 'package:cloud_firestore/cloud_firestore.dart';

import 'doctor_review.dart';
import 'reviews_repository.dart';

class FirebaseReviewsRepository implements ReviewsRepository {
  FirebaseReviewsRepository({FirebaseFirestore? firestore}) : _db = firestore;
  final FirebaseFirestore? _db;
  FirebaseFirestore get db => _db ?? FirebaseFirestore.instance;

  @override
  Future<DoctorReview?> getForAppointment(String appointmentId) async {
    final snapshot = await db.collection('reviews').doc(appointmentId).get();
    if (!snapshot.exists) return null;
    return DoctorReview.fromJson({
      ...snapshot.data()!,
      'appointmentId': snapshot.id,
    });
  }

  @override
  Future<void> add({
    required String appointmentId,
    required String userId,
    required String doctorId,
    required int rating,
    required String text,
  }) async {
    final comment = text.trim();
    if (userId.isEmpty) {
      throw const ReviewFailure('Log in to leave a review.');
    }
    if (rating < 1 || rating > 5 || comment.isEmpty || comment.length > 2000) {
      throw const ReviewFailure(
        'Choose 1–5 stars and enter a comment of up to 2000 characters.',
      );
    }
    final reviewRef = db.collection('reviews').doc(appointmentId);
    await db.runTransaction((transaction) async {
      final appointment = await transaction.get(
        db.collection('appointments').doc(appointmentId),
      );
      final data = appointment.data();
      if (data == null ||
          data['userId'] != userId ||
          data['doctorId'] != doctorId ||
          data['status'] != 'completed') {
        throw const ReviewFailure(
          'You can review only your completed appointments.',
        );
      }
      final existing = await transaction.get(reviewRef);
      if (existing.exists) {
        throw const ReviewFailure(
          'You have already reviewed this appointment.',
        );
      }
      final review = DoctorReview(
        appointmentId: appointmentId,
        userId: userId,
        doctorId: doctorId,
        rating: rating,
        text: comment,
        createdAt: DateTime.now(),
      );
      transaction.set(reviewRef, {
        ...review.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }
}
