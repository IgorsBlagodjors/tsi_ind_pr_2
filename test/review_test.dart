import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/data/reviews/reviews_repository.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/review.dart';

import 'helpers/profile_auth.dart';

void main() {
  testWidgets('Submit rating and comment, then reopen saved review', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final db = FakeFirebaseFirestore();
    await db.collection('appointments').doc('visit').set({
      'userId': 'user',
      'doctorId': 'doctor',
      'status': 'completed',
    });
    final repository = ReviewsRepository(firestore: db);
    final auth = ProfileAuth(
      const AppUser(id: 'user', fullName: 'User', email: 'user@example.com'),
    );
    addTearDown(auth.changes.close);
    Widget screen() => MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: auth),
        RepositoryProvider<ReviewsRepository>.value(value: repository),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => const MaterialApp(
          home: Review(
            doctor: Doctor(
              id: 'doctor',
              name: 'Dr. Example',
              type: DoctorType.cardiology,
              specialization: 'Cardiology',
              image: '',
            ),
            appointmentId: 'visit',
          ),
        ),
      ),
    );
    await tester.pumpWidget(screen());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.star).at(2));
    await tester.enterText(find.byType(TextFormField), 'Helpful explanation');
    await tester.ensureVisible(find.text('Add Review'));
    await tester.tap(find.text('Add Review'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    final saved = await repository.getForAppointment('visit');
    expect(saved!.rating, 3);
    expect(saved.text, 'Helpful explanation');
    expect(find.text('Review added'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(screen());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Helpful explanation'), findsOneWidget);
    expect(find.text('Review added'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });
}
