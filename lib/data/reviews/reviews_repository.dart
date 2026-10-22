import 'doctor_review.dart';

class ReviewFailure implements Exception {
  const ReviewFailure(this.message);
  final String message;
}

abstract class ReviewsRepository {
  Future<DoctorReview?> getForAppointment(String appointmentId);

  Future<void> add({
    required String appointmentId,
    required String userId,
    required String doctorId,
    required int rating,
    required String text,
  });
}
