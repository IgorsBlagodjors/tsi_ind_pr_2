import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_booking.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_status.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/appointments/patient_details.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/data/users/profile_repository.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/appointment.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/schedule.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/appointment_calendar.dart';

import 'helpers/profile_auth.dart';

class _Profiles extends ProfileRepository {
  _Profiles(this.user);
  final AppUser user;
  @override
  Future<void> ensureProfile(AppUser fallback) async {}
  @override
  Stream<AppUser?> watch(String uid) => Stream.value(user);
}

class _Bookings extends AppointmentsRepository {
  PatientDetails? saved;
  @override
  Stream<Set<DateTime>> watchBookedTimes(String doctorId) => Stream.value({});
  @override
  Future<String> book({
    required String userId,
    required String doctorId,
    required DateTime startsAt,
    required PatientDetails patient,
  }) async {
    saved = patient;
    // Keep the form visible so the test can inspect the submitted patient.
    throw const BookingFailure('Test submission captured');
  }
}

void main() {
  final now = DateTime(2030, 5, 10, 12);
  AppointmentBooking booking(
    String id,
    DateTime time, {
    AppointmentStatus status = AppointmentStatus.upcoming,
  }) => AppointmentBooking(
    id: id,
    userId: 'u',
    doctorId: id,
    slotId: id,
    startsAt: time,
    endsAt: time.add(const Duration(minutes: 30)),
    createdAt: now,
    status: status,
    patient: const PatientDetails(
      fullName: 'Patient',
      age: 30,
      gender: Gender.other,
    ),
  );
  test('Home defaults to two nearest future upcoming visits, sorted', () {
    final items = [
      booking('third', now.add(const Duration(days: 3))),
      booking('past', now.subtract(const Duration(hours: 1))),
      booking('second', now.add(const Duration(days: 2))),
      booking(
        'cancelled',
        now.add(const Duration(minutes: 10)),
        status: AppointmentStatus.cancelled,
      ),
      booking('first', now.add(const Duration(days: 1))),
    ];
    expect(homeAppointments(items, now: now).map((item) => item.id), [
      'first',
      'second',
    ]);
  });
  test(
    'Selected day includes all visits on that day, and empty days stay empty',
    () {
      final items = List.generate(
        3,
        (i) => booking('$i', DateTime(2030, 5, 11, 9 + i)),
      );
      expect(
        homeAppointments(items, now: now, date: DateTime(2030, 5, 11)),
        hasLength(3),
      );
      expect(
        homeAppointments(items, now: now, date: DateTime(2030, 5, 12)),
        isEmpty,
      );
    },
  );
  testWidgets(
    'Yourself fills editable fields and restores the compact selector',
    (tester) async {
      final today = DateTime.now();
      final user = AppUser(
        id: 'u',
        fullName: 'Profile Patient',
        email: 'p@example.com',
        dateOfBirth: DateTime(today.year - 30, today.month, today.day),
        gender: Gender.female,
      );
      final auth = ProfileAuth(user);
      final cubit = ProfileCubit(auth, _Profiles(user))..start();
      final bookings = _Bookings();
      addTearDown(() async {
        await cubit.close();
        await auth.changes.close();
      });
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepository>.value(value: auth),
            RepositoryProvider<AppointmentsRepository>.value(value: bookings),
          ],
          child: BlocProvider.value(
            value: cubit,
            child: ScreenUtilInit(
              designSize: const Size(360, 800),
              builder: (context, child) => const MaterialApp(
                home: Schedule(
                  doctor: Doctor(
                    id: 'd',
                    name: 'Doctor',
                    type: DoctorType.cardiology,
                    specialization: 'Cardiology',
                    image: '',
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final name = find.byWidgetPredicate(
        (w) => w is TextField && w.decoration?.hintText == 'Full name',
      );
      expect(name, findsOneWidget);
      expect(
        tester.widget<TextField>(name).controller!.text,
        'Profile Patient',
      );
      expect(
        find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.hintText == 'Age',
        ),
        findsOneWidget,
      );
      tester
          .widget<AppointmentCalendar>(find.byType(AppointmentCalendar))
          .onChanged!(today.add(const Duration(days: 1)));
      await tester.ensureVisible(find.text('Confirm'));
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(bookings.saved?.fullName, 'Profile Patient');
      expect(bookings.saved?.age, 30);
      expect(bookings.saved?.gender, Gender.female);
      await tester.ensureVisible(find.text('Another Person'));
      await tester.tap(find.text('Another Person'));
      await tester.pumpAndSettle();
      expect(tester.widget<TextField>(name).controller!.text, isEmpty);
      expect(
        find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.hintText == 'Age',
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Yourself'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(name).controller!.text,
        'Profile Patient',
      );
      expect(
        tester
            .widget<TextField>(
              find.byWidgetPredicate(
                (w) => w is TextField && w.decoration?.hintText == 'Age',
              ),
            )
            .controller!
            .text,
        '30',
      );
      expect(
        tester.getCenter(find.text('Yourself')).dy,
        closeTo(tester.getCenter(find.text('Another Person')).dy, 0.01),
      );
      await tester.pumpWidget(const SizedBox());
    },
  );
}

