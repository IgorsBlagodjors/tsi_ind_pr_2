import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_booking.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_status.dart';
import 'package:tsi_ind_pr_2/data/appointments/patient_details.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/appointment.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';

import 'helpers/profile_auth.dart';

class _Bookings extends AppointmentsRepository {
  final events = StreamController<List<AppointmentBooking>>.broadcast();
  @override
  Stream<List<AppointmentBooking>> watchForUser(String userId) => events.stream;
}

class _Doctors implements DoctorsRepository {
  static const doctor = Doctor(
    id: 'd',
    name: 'Doctor Test',
    type: DoctorType.cardiology,
    specialization: 'Cardiology',
    image: '',
  );
  @override
  Stream<List<Doctor>> watchDoctors() => Stream.value([doctor]);
  @override
  Stream<List<Doctor>> watchDoctorsByType(DoctorType type) => watchDoctors();
  @override
  Future<Doctor?> getDoctorById(String id) async => doctor;
}

AppointmentBooking booking(
  String id,
  AppointmentStatus status, {
  String doctorId = 'd',
}) {
  final now = DateTime.now();
  return AppointmentBooking(
    id: id,
    userId: 'u',
    doctorId: doctorId,
    slotId: id,
    startsAt: now.add(const Duration(days: 1)),
    endsAt: now.add(const Duration(days: 1, minutes: 30)),
    createdAt: now,
    status: status,
    patient: PatientDetails(fullName: id, age: 30, gender: Gender.other),
  );
}

void main() {
  testWidgets(
    'Booking navigation opens status tabs and live updates keep visits separate',
    (tester) async {
      final auth = ProfileAuth(
        const AppUser(id: 'u', fullName: 'User', email: 'u@example.com'),
      );
      final bookings = _Bookings();
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, state) =>
                const BottomNavigation(location: '/', child: SizedBox()),
          ),
          GoRoute(
            path: '/apointment',
            name: 'apointment',
            builder: (_, state) => const BottomNavigation(
              location: '/apointment',
              child: Appointment(),
            ),
          ),
        ],
      );
      addTearDown(() async {
        router.dispose();
        await auth.changes.close();
        await bookings.events.close();
      });
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepository>.value(value: auth),
            RepositoryProvider<AppointmentsRepository>.value(value: bookings),
            RepositoryProvider<DoctorsRepository>(create: (_) => _Doctors()),
          ],
          child: ScreenUtilInit(
            designSize: const Size(360, 800),
            builder: (_, child) => MaterialApp.router(routerConfig: router),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Appointments'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      final items = [
        booking('visit-one', AppointmentStatus.upcoming),
        booking('visit-two', AppointmentStatus.upcoming),
        booking('finished', AppointmentStatus.completed),
        booking('cancelled', AppointmentStatus.cancelled, doctorId: 'missing'),
      ];
      bookings.events.add(items);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('visit-one')), findsOneWidget);
      expect(find.text('All Appointment'), findsOneWidget);
      expect(find.byType(TabBar), findsNothing);
      expect(find.text('Book a doctor'), findsNothing);
      expect(find.byIcon(Icons.check), findsNWidgets(2));
      expect(find.byIcon(Icons.close), findsNWidgets(2));
      expect(find.byKey(const ValueKey('visit-two')), findsOneWidget);
      expect(find.text('finished'), findsNothing);
      await tester.tap(find.text('Complete'));
      await tester.pumpAndSettle();
      expect(find.text('Doctor Test'), findsOneWidget);
      expect(find.text('Re-Book'), findsOneWidget);
      expect(find.text('Add Review'), findsOneWidget);
      await tester.tap(find.text('Cancelled'));
      await tester.pumpAndSettle();
      expect(find.text('Re-Book'), findsNothing);
      expect(find.text('Doctor unavailable'), findsOneWidget);
      expect(find.text('Add Review'), findsOneWidget);
      bookings.events.add([]);
      await tester.pumpAndSettle();
      expect(find.text('No cancelled appointments.'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
