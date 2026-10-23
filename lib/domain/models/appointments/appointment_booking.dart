import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/domain/models/appointments/patient_details.dart';
import 'package:tsi_ind_pr_2/core/serialization/firestore_dates.dart';

part 'appointment_booking.g.dart';

@JsonSerializable(explicitToJson: true)
class AppointmentBooking {
  const AppointmentBooking({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.slotId,
    required this.startsAt,
    required this.endsAt,
    required this.createdAt,
    required this.patient,
    this.status = AppointmentStatus.upcoming,
    this.cancelReason,
    this.statusChangedAt,
  });

  @JsonKey(includeToJson: false)
  final String id;

  final String userId;
  final String doctorId;
  final String slotId;

  @JsonKey(fromJson: readTimestamp, toJson: writeTimestamp)
  final DateTime startsAt;

  @JsonKey(fromJson: readTimestamp, toJson: writeTimestamp)
  final DateTime endsAt;

  @JsonKey(fromJson: readTimestamp, toJson: writeTimestamp)
  final DateTime createdAt;

  final PatientDetails patient;
  final AppointmentStatus status;
  final String? cancelReason;

  @JsonKey(
    fromJson: readNullableTimestamp,
    toJson: writeNullableTimestamp,
    includeIfNull: false,
  )
  final DateTime? statusChangedAt;

  factory AppointmentBooking.fromJson(Map<String, dynamic> json) =>
      _$AppointmentBookingFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentBookingToJson(this);
}
