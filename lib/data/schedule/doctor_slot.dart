import 'package:cloud_firestore/cloud_firestore.dart';

import '../firestore_dates.dart';

enum DoctorSlotStatus { available, booked, blocked }

class DoctorSlot {
  const DoctorSlot({
    required this.id,
    required this.doctorId,
    required this.startsAt,
    required this.endsAt,
    this.status = DoctorSlotStatus.available,
  });

  final String id;
  final String doctorId;
  final DateTime startsAt;
  final DateTime endsAt;
  final DoctorSlotStatus status;

  bool isAvailableAt(DateTime now) =>
      status == DoctorSlotStatus.available && startsAt.isAfter(now);

  factory DoctorSlot.fromMap(String id, Map<String, dynamic> data) =>
      DoctorSlot(
        id: id,
        doctorId: data['doctorId'] as String,
        startsAt: readTimestamp(data['startsAt']),
        endsAt: readTimestamp(data['endsAt']),
        status: DoctorSlotStatus.values.byName(data['status'] as String),
      );

  Map<String, dynamic> toMap() => {
    'doctorId': doctorId,
    'startsAt': Timestamp.fromDate(startsAt),
    'endsAt': Timestamp.fromDate(endsAt),
    'status': status.name,
  };
}
