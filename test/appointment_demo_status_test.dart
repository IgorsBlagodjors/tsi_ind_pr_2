import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_booking.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/appointments/firebase_appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/appointments/patient_details.dart';
import 'package:tsi_ind_pr_2/data/reviews/reviews_repository.dart';
import 'package:tsi_ind_pr_2/data/reviews/firebase_reviews_repository.dart';

void main() {
  for (final future in [true, false]) {
    for (final status in [
      AppointmentStatus.completed,
      AppointmentStatus.cancelled,
    ]) {
      test(
        '${future ? "Future" : "Past"} visit can be ${status.name}',
        () async {
          final db = FakeFirebaseFirestore();
          final AppointmentsRepository repository =
              FirebaseAppointmentsRepository(firestore: db);
          final start = DateTime.now().add(Duration(days: future ? 3 : -3));
          final booking = AppointmentBooking(
            id: 'visit',
            userId: 'user',
            doctorId: 'doctor',
            slotId: 'slot',
            startsAt: start,
            endsAt: start.add(const Duration(minutes: 30)),
            createdAt: DateTime.now(),
            patient: const PatientDetails(
              fullName: 'Patient',
              age: 30,
              gender: Gender.other,
            ),
          );
          await db
              .collection('appointments')
              .doc('visit')
              .set(booking.toJson());
          final lock = db.doc('doctors/doctor/bookings/slot');
          await lock.set({'appointmentId': 'visit'});
          await expectLater(
            repository.changeStatus(
              userId: 'another-user',
              appointmentId: 'visit',
              status: status,
            ),
            throwsA(isA<BookingFailure>()),
          );
          await repository.changeStatus(
            userId: 'user',
            appointmentId: 'visit',
            status: status,
          );
          expect(
            (await repository.watchForUser('user').first).single.status,
            status,
          );
          expect(
            (await lock.get()).exists,
            status != AppointmentStatus.cancelled,
          );
          if (status == AppointmentStatus.completed) {
            final ReviewsRepository reviews = FirebaseReviewsRepository(
              firestore: db,
            );
            await reviews.add(
              appointmentId: 'visit',
              userId: 'user',
              doctorId: 'doctor',
              rating: 5,
              text: 'Demo review',
            );
            expect((await reviews.getForAppointment('visit'))!.rating, 5);
          }
          await expectLater(
            repository.changeStatus(
              userId: 'user',
              appointmentId: 'visit',
              status: status == AppointmentStatus.completed
                  ? AppointmentStatus.cancelled
                  : AppointmentStatus.completed,
            ),
            throwsA(isA<BookingFailure>()),
          );
        },
      );
    }
  }
}
