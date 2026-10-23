import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';

import '../../domain/models/appointments/appointment_booking.dart';
import '../../domain/repositories/appointments_repository.dart';
import '../../domain/models/appointments/patient_details.dart';

class FirebaseAppointmentsRepository implements AppointmentsRepository {
  FirebaseAppointmentsRepository({FirebaseFirestore? firestore})
    : _db = firestore;
  final FirebaseFirestore? _db;
  FirebaseFirestore get db => _db ?? FirebaseFirestore.instance;

  @override
  Future<void> changeStatus({
    required String userId,
    required String appointmentId,
    required AppointmentStatus status,
  }) async {
    if (userId.isEmpty || status == AppointmentStatus.upcoming) {
      throw const BookingFailure('Invalid appointment status change.');
    }
    final ref = db.collection('appointments').doc(appointmentId);
    await db.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      if (!snapshot.exists || snapshot.data()?['userId'] != userId) {
        throw const BookingFailure('Appointment not found.');
      }
      final booking = AppointmentBooking.fromJson({
        ...snapshot.data()!,
        'id': snapshot.id,
      });
      // Repeated requests for the same status are safe to retry.
      if (booking.status == status) return;
      if (booking.status != AppointmentStatus.upcoming) {
        throw const BookingFailure('This appointment has already been closed.');
      }
      final lock = db
          .collection('doctors')
          .doc(booking.doctorId)
          .collection('bookings')
          .doc(booking.slotId);
      if (status == AppointmentStatus.cancelled) {
        // Release the slot in the same transaction as the status change.
        final held = await transaction.get(lock);
        if (held.exists && held.data()?['appointmentId'] != appointmentId) {
          throw const BookingFailure(
            'Appointment availability changed. Try again.',
          );
        }
        if (held.exists) transaction.delete(lock);
      }
      transaction.update(ref, {
        'status': status.name,
        'statusChangedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Stream<List<AppointmentBooking>> watchForUser(String userId) => db
      .collection('appointments')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
        final items = snapshot.docs
            .map(
              (doc) =>
                  AppointmentBooking.fromJson({...doc.data(), 'id': doc.id}),
            )
            .toList();
        items.sort((a, b) => a.startsAt.compareTo(b.startsAt));
        return items;
      });

  @override
  Stream<Set<DateTime>> watchBookedTimes(String doctorId) => db
      .collection('doctors')
      .doc(doctorId)
      .collection('bookings')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => (doc.data()['startsAt'] as Timestamp).toDate())
            .toSet(),
      );

  @override
  Future<String> book({
    required String userId,
    required String doctorId,
    required DateTime startsAt,
    required PatientDetails patient,
  }) async {
    if (userId.isEmpty || doctorId.isEmpty) {
      throw const BookingFailure('Log in to book an appointment.');
    }
    if (!startsAt.isAfter(DateTime.now())) {
      throw const BookingFailure('Choose a future appointment time.');
    }
    if (patient.fullName.trim().isEmpty ||
        patient.fullName.length > 200 ||
        patient.age < 0 ||
        patient.age > 120 ||
        patient.problem.length > 2000) {
      throw const BookingFailure(
        'Enter a name, age (0–120), and a problem of up to 2000 characters.',
      );
    }
    // A deterministic document ID makes competing requests share one slot lock.
    final slotId = startsAt.millisecondsSinceEpoch.toString();
    final appointment = db.collection('appointments').doc();
    final lock = db
        .collection('doctors')
        .doc(doctorId)
        .collection('bookings')
        .doc(slotId);
    await db.runTransaction((transaction) async {
      final existing = await transaction.get(lock);
      if (existing.exists) {
        throw const BookingFailure(
          'This time has just been booked. Choose another time.',
        );
      }
      final booking = AppointmentBooking(
        id: appointment.id,
        userId: userId,
        doctorId: doctorId,
        slotId: slotId,
        startsAt: startsAt,
        endsAt: startsAt.add(const Duration(minutes: 30)),
        createdAt: DateTime.now(),
        patient: patient,
      );
      transaction.set(appointment, {
        ...booking.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      transaction.set(lock, {
        'appointmentId': appointment.id,
        'startsAt': Timestamp.fromDate(startsAt),
      });
    });
    return appointment.id;
  }
}
