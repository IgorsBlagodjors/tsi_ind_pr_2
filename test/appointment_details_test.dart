import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/appointments/patient_details.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/appointment_details.dart';

import 'helpers/profile_auth.dart';

void main() {
  testWidgets('Shows booked patient and cancels only after confirmation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final db = FakeFirebaseFirestore();
    final repository = AppointmentsRepository(firestore: db);
    final auth = ProfileAuth(
      const AppUser(id: 'user', fullName: 'Owner', email: 'owner@example.com'),
    );
    addTearDown(auth.changes.close);
    await repository.book(
      userId: 'user',
      doctorId: 'doctor',
      startsAt: DateTime.now().add(const Duration(days: 2)),
      patient: const PatientDetails(
        fullName: 'Patient With A Long Full Name',
        age: 42,
        gender: Gender.male,
        isAccountOwner: false,
        problem: 'Persistent headache',
      ),
    );
    final booking = (await repository.watchForUser('user').first).single;
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>.value(value: auth),
          RepositoryProvider<AppointmentsRepository>.value(value: repository),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) => MaterialApp(
            home: AppointmentDetails(
              doctor: const Doctor(
                id: 'doctor',
                name: 'Dr. Example',
                type: DoctorType.cardiology,
                specialization: 'Cardiology',
                image: '',
              ),
              booking: booking,
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text(booking.patient.fullName), findsOneWidget);
    expect(find.text('42'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Another person'), findsOneWidget);
    expect(find.text('Persistent headache'), findsOneWidget);
    expect(find.text('Payment'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.ensureVisible(find.text('Cancel'));
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('Keep appointment'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(
      (await repository.watchForUser('user').first).single.status,
      AppointmentStatus.upcoming,
    );

    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.widgetWithText(TextButton, 'Cancel appointment'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(
      (await repository.watchForUser('user').first).single.status,
      AppointmentStatus.cancelled,
    );
    expect(await repository.watchBookedTimes('doctor').first, isEmpty);
    expect(find.text('Appointment cancelled'), findsOneWidget);
    expect(find.text('Cancel'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
