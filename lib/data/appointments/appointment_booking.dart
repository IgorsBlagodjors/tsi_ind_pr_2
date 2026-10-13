import 'package:cloud_firestore/cloud_firestore.dart';

import '../firestore_dates.dart';
import 'appointment_status.dart';
import 'patient_details.dart';

/// Document at appointments/{id}. Named to avoid a conflict with the Appointment screen.
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
  });

  final String id;
  final String userId;
  final String doctorId;
  final String slotId;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime createdAt;
  final PatientDetails patient;
  final AppointmentStatus status;
  final String? cancelReason;

  factory AppointmentBooking.fromMap(String id, Map<String, dynamic> data) =>
      AppointmentBooking(
        id: id,
        userId: data['userId'] as String,
        doctorId: data['doctorId'] as String,
        slotId: data['slotId'] as String,
        startsAt: readTimestamp(data['startsAt']),
        endsAt: readTimestamp(data['endsAt']),
        createdAt: readTimestamp(data['createdAt']),
        patient: PatientDetails.fromMap(
          Map<String, dynamic>.from(data['patient'] as Map),
        ),
        status: AppointmentStatus.values.byName(data['status'] as String),
        cancelReason: data['cancelReason'] as String?,
      );

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'doctorId': doctorId,
    'slotId': slotId,
    'startsAt': Timestamp.fromDate(startsAt),
    'endsAt': Timestamp.fromDate(endsAt),
    'createdAt': Timestamp.fromDate(createdAt),
    'patient': patient.toMap(),
    'status': status.name,
    'cancelReason': cancelReason,
  };
}
