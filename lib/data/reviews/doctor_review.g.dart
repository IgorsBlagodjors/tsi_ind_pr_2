// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorReview _$DoctorReviewFromJson(Map<String, dynamic> json) => DoctorReview(
  appointmentId: json['appointmentId'] as String,
  userId: json['userId'] as String,
  doctorId: json['doctorId'] as String,
  rating: (json['rating'] as num).toInt(),
  text: json['text'] as String,
  createdAt: readTimestamp(json['createdAt']),
);

Map<String, dynamic> _$DoctorReviewToJson(DoctorReview instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'doctorId': instance.doctorId,
      'rating': instance.rating,
      'text': instance.text,
      'createdAt': writeTimestamp(instance.createdAt),
    };
