import 'package:cloud_firestore/cloud_firestore.dart';

import '../firestore_dates.dart';

/// reviews/{appointmentId}: one review per completed appointment.
class DoctorReview {
  const DoctorReview({
    required this.appointmentId,
    required this.userId,
    required this.doctorId,
    required this.rating,
    required this.text,
    required this.createdAt,
  });

  String get id => appointmentId;
  final String appointmentId;
  final String userId;
  final String doctorId;
  final int rating;
  final String text;
  final DateTime createdAt;

  factory DoctorReview.fromMap(String id, Map<String, dynamic> data) =>
      DoctorReview(
        appointmentId: id,
        userId: data['userId'] as String,
        doctorId: data['doctorId'] as String,
        rating: (data['rating'] as num).toInt(),
        text: data['text'] as String,
        createdAt: readTimestamp(data['createdAt']),
      );

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'doctorId': doctorId,
    'rating': rating,
    'text': text,
    'createdAt': Timestamp.fromDate(createdAt),
  };
}
