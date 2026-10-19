// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentBooking _$AppointmentBookingFromJson(Map<String, dynamic> json) =>
    AppointmentBooking(
      id: json['id'] as String,
      userId: json['userId'] as String,
      doctorId: json['doctorId'] as String,
      slotId: json['slotId'] as String,
      startsAt: readTimestamp(json['startsAt']),
      endsAt: readTimestamp(json['endsAt']),
      createdAt: readTimestamp(json['createdAt']),
      patient: PatientDetails.fromJson(json['patient'] as Map<String, dynamic>),
      status:
          $enumDecodeNullable(_$AppointmentStatusEnumMap, json['status']) ??
          AppointmentStatus.upcoming,
      cancelReason: json['cancelReason'] as String?,
      statusChangedAt: readNullableTimestamp(json['statusChangedAt']),
    );

Map<String, dynamic> _$AppointmentBookingToJson(AppointmentBooking instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'doctorId': instance.doctorId,
      'slotId': instance.slotId,
      'startsAt': writeTimestamp(instance.startsAt),
      'endsAt': writeTimestamp(instance.endsAt),
      'createdAt': writeTimestamp(instance.createdAt),
      'patient': instance.patient.toJson(),
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'cancelReason': instance.cancelReason,
      'statusChangedAt': ?writeNullableTimestamp(instance.statusChangedAt),
    };

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.upcoming: 'upcoming',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.cancelled: 'cancelled',
};
