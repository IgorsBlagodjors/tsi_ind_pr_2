import 'package:freezed_annotation/freezed_annotation.dart';

import '../firestore_dates.dart';

part 'doctor_review.g.dart';

@JsonSerializable()
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

  @JsonKey(includeToJson: false)
  final String appointmentId;

  final String userId;
  final String doctorId;
  final int rating;
  final String text;

  @JsonKey(fromJson: readTimestamp, toJson: writeTimestamp)
  final DateTime createdAt;

  factory DoctorReview.fromJson(Map<String, dynamic> json) =>
      _$DoctorReviewFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorReviewToJson(this);
}
