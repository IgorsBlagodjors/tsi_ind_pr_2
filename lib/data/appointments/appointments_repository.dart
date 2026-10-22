import 'package:tsi_ind_pr_2/data/app_enums.dart';

import 'appointment_booking.dart';
import 'patient_details.dart';

class BookingFailure implements Exception {
  const BookingFailure(this.message);
  final String message;
}

abstract class AppointmentsRepository {
  Future<void> changeStatus({
    required String userId,
    required String appointmentId,
    required AppointmentStatus status,
  });

  Stream<List<AppointmentBooking>> watchForUser(String userId);

  Stream<Set<DateTime>> watchBookedTimes(String doctorId);

  Future<String> book({
    required String userId,
    required String doctorId,
    required DateTime startsAt,
    required PatientDetails patient,
  });
}
