import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_status.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/appointments/patient_details.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';

void main() {
  late FakeFirebaseFirestore db;
  late AppointmentsRepository repository;
  final time = DateTime.now().add(const Duration(days: 2));
  const patient = PatientDetails(
    fullName: 'Test Patient',
    age: 30,
    gender: Gender.other,
  );
  setUp(() {
    db = FakeFirebaseFirestore();
    repository = AppointmentsRepository(firestore: db);
  });
  test(
    'keeps separate bookings for multiple doctors and isolates user list',
    () async {
      await repository.book(
        userId: 'one',
        doctorId: 'a',
        startsAt: time,
        patient: patient,
      );
      await repository.book(
        userId: 'one',
        doctorId: 'b',
        startsAt: time.add(const Duration(hours: 1)),
        patient: patient,
      );
      await repository.book(
        userId: 'two',
        doctorId: 'c',
        startsAt: time,
        patient: patient,
      );
      final items = await repository.watchForUser('one').first;
      expect(items.length, 2);
      expect(items.map((item) => item.doctorId), ['a', 'b']);
      expect(items.first.patient.fullName, patient.fullName);
      expect(await repository.watchBookedTimes('a').first, {time});
    },
  );
  test(
    'rejects an occupied slot without creating another appointment',
    () async {
      await repository.book(
        userId: 'one',
        doctorId: 'a',
        startsAt: time,
        patient: patient,
      );
      await expectLater(
        repository.book(
          userId: 'two',
          doctorId: 'a',
          startsAt: time,
          patient: patient,
        ),
        throwsA(isA<BookingFailure>()),
      );
      expect((await db.collection('appointments').get()).docs.length, 1);
    },
  );
  test('rejects past time and invalid patient without writing', () async {
    await expectLater(
      repository.book(
        userId: 'one',
        doctorId: 'a',
        startsAt: DateTime(2020),
        patient: patient,
      ),
      throwsA(isA<BookingFailure>()),
    );
    await expectLater(
      repository.book(
        userId: 'one',
        doctorId: 'a',
        startsAt: time,
        patient: const PatientDetails(
          fullName: '',
          age: -1,
          gender: Gender.male,
        ),
      ),
      throwsA(isA<BookingFailure>()),
    );
    expect((await db.collection('appointments').get()).docs, isEmpty);
  });

  test(
    'cancellation preserves history, releases slot, and supports rebooking',
    () async {
      final id = await repository.book(
        userId: 'one',
        doctorId: 'a',
        startsAt: time,
        patient: patient,
      );
      await repository.changeStatus(
        userId: 'one',
        appointmentId: id,
        status: AppointmentStatus.cancelled,
      );
      await repository.changeStatus(
        userId: 'one',
        appointmentId: id,
        status: AppointmentStatus.cancelled,
      );
      final saved = (await repository.watchForUser('one').first).single;
      expect(saved.status, AppointmentStatus.cancelled);
      expect(saved.statusChangedAt, isNotNull);
      expect(saved.patient.fullName, patient.fullName);
      expect(await repository.watchBookedTimes('a').first, isEmpty);
      await repository.book(
        userId: 'two',
        doctorId: 'a',
        startsAt: time,
        patient: patient,
      );
      expect((await db.collection('appointments').get()).docs.length, 2);
      await expectLater(
        repository.changeStatus(
          userId: 'one',
          appointmentId: id,
          status: AppointmentStatus.completed,
        ),
        throwsA(isA<BookingFailure>()),
      );
    },
  );
  test(
    'completion is persisted only after the visit ends and owner is checked',
    () async {
      final id = await repository.book(
        userId: 'one',
        doctorId: 'a',
        startsAt: time,
        patient: patient,
      );
      await expectLater(
        repository.changeStatus(
          userId: 'two',
          appointmentId: id,
          status: AppointmentStatus.cancelled,
        ),
        throwsA(isA<BookingFailure>()),
      );
      await expectLater(
        repository.changeStatus(
          userId: 'one',
          appointmentId: id,
          status: AppointmentStatus.completed,
        ),
        throwsA(isA<BookingFailure>()),
      );
      await db.collection('appointments').doc(id).update({
        'startsAt': Timestamp.fromDate(
          DateTime.now().subtract(const Duration(hours: 2)),
        ),
        'endsAt': Timestamp.fromDate(
          DateTime.now().subtract(const Duration(hours: 1)),
        ),
      });
      await expectLater(
        repository.changeStatus(
          userId: 'one',
          appointmentId: id,
          status: AppointmentStatus.cancelled,
        ),
        throwsA(isA<BookingFailure>()),
      );
      await repository.changeStatus(
        userId: 'one',
        appointmentId: id,
        status: AppointmentStatus.completed,
      );
      final history = await AppointmentsRepository(firestore: db)
          .watchForUser('one')
          .first;
      expect(history.single.status, AppointmentStatus.completed);
      expect(history.single.statusChangedAt, isNotNull);
    },
  );
}
