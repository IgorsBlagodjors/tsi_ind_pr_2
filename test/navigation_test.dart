// Firebase platform interfaces let these tests run without a real account.
// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/domain/app_access.dart';
import 'package:tsi_ind_pr_2/data/users/firebase_auth_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:tsi_ind_pr_2/data/users/profile_repository.dart';
import 'package:firebase_core_platform_interface/test.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

import 'helpers/fake_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/app/router/app_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/doctors_info.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/edit_profile.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/home/home_page.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/widgets/profile_menu_tile.dart';
import 'package:tsi_ind_pr_2/presentation/schedule.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/doc_by_specialty.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();
  final auth = FakeAuth();
  FirebaseAuthPlatform.instance = auth;
  late ProfileRepository profiles;
  setUp(() {
    auth.errorCode = null;
    auth.user = FakeUser(auth);
    AppAccess.instance.unlock('test-user');
    profiles = ProfileRepository(firestore: FakeFirebaseFirestore());
  });
  setUpAll(() async {
    await Firebase.initializeApp();
    final font = FontLoader('League Spartan');
    for (final weight in ['Light', 'Regular', 'Medium', 'SemiBold', 'Bold']) {
      font.addFont(
        rootBundle.load(
          'assets/fonts/league_spartan/LeagueSpartan-$weight.ttf',
        ),
      );
    }
    await font.load();
  });
  Future<void> openApp(WidgetTester tester, String route) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    appRouter.go(route);
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepository>(
              create: (_) =>
                  FirebaseAuthRepository(firebase_auth.FirebaseAuth.instance),
            ),
            RepositoryProvider<ProfileRepository>.value(value: profiles),
          ],
          child: MaterialApp.router(
            theme: ThemeData(fontFamily: 'League Spartan'),
            routerConfig: appRouter,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Saved Firebase session cannot bypass the login screen', (
    tester,
  ) async {
    AppAccess.instance.lock();
    await openApp(tester, '/home');
    expect(appRouter.routeInformationProvider.value.uri.path, '/login');
    expect(find.byType(HomePage), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Specialty, doctor and schedule preserve the selected doctor', (
    tester,
  ) async {
    await openApp(tester, '/specialties');
    await tester.tap(find.text('Cardiology'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<DocBySpecialty>(find.byType(DocBySpecialty)).doctorType,
      DoctorType.cardiology,
    );
    await tester.tap(find.text('Info').first);
    await tester.pumpAndSettle();
    final doctor = tester.widget<DoctorsInfo>(find.byType(DoctorsInfo)).doctor;
    expect(doctor.type, DoctorType.cardiology);
    await tester.tap(find.text('Schedule'));
    await tester.pumpAndSettle();
    expect(tester.widget<Schedule>(find.byType(Schedule)).doctor.id, doctor.id);
    expect(find.byType(BottomNavigation), findsOneWidget);
    appRouter.pop();
    await tester.pumpAndSettle();
    expect(find.byType(DoctorsInfo), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Profile arrow opens edit, tabs navigate, Chat stays on page', (
    tester,
  ) async {
    await openApp(tester, '/profile');
    final tile = find.widgetWithText(ProfileMenuTile, 'Profile');
    await tester.tap(
      find.descendant(of: tile, matching: find.byIcon(Icons.chevron_right)),
    );
    await tester.pumpAndSettle();
    expect(find.byType(EditProfile), findsOneWidget);
    expect(find.byTooltip('Home'), findsOneWidget);
    await tester.tap(find.byTooltip('Chat'));
    await tester.pumpAndSettle();
    expect(find.byType(EditProfile), findsOneWidget);
    expect(find.text('Chat is not available yet.'), findsOneWidget);
    await tester.tap(find.byTooltip('Appointments'));
    await tester.pumpAndSettle();
    expect(appRouter.routeInformationProvider.value.uri.path, '/apointment');
    expect(tester.takeException(), isNull);
  });

  testWidgets('Missing route arguments redirect instead of crashing', (
    tester,
  ) async {
    await openApp(tester, '/schedule');
    expect(appRouter.routeInformationProvider.value.uri.path, '/doctors');
    for (final entry in {
      '/doctors_info': '/doctors',
      '/doc_by_specialty': '/specialties',
      '/rewiev': '/apointment',
    }.entries) {
      appRouter.go(entry.key);
      await tester.pumpAndSettle();
      expect(appRouter.routeInformationProvider.value.uri.path, entry.value);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('Login opens home only after Firebase accepts credentials', (
    tester,
  ) async {
    await openApp(tester, '/login');
    await tester.ensureVisible(find.text('Log In'));
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();
    expect(appRouter.routeInformationProvider.value.uri.path, '/login');
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'demo@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    auth.errorCode = 'invalid-credential';
    await tester.ensureVisible(find.text('Log In'));
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();
    expect(appRouter.routeInformationProvider.value.uri.path, '/login');
    expect(find.text('Incorrect email or password.'), findsOneWidget);
    auth.errorCode = null;
    await tester.ensureVisible(find.text('Log In'));
    await tester.tap(find.text('Log In'));
    // Home contains network image spinners; wait for navigation, not all animations.
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(appRouter.routeInformationProvider.value.uri.path, '/home');
    expect(find.byTooltip('Appointments'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Sign up creates an account and handles an existing email', (
    tester,
  ) async {
    await openApp(tester, '/create_account');
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Test User');
    await tester.enterText(fields.at(1), 'Password123!');
    await tester.enterText(fields.at(2), 'new@example.com');
    await tester.enterText(fields.at(3), '29123456');
    tester.widget<TextFormField>(fields.at(4)).controller!.text = '01/01/2000';
    auth.errorCode = 'email-already-in-use';
    await tester.ensureVisible(find.text('Sign Up'));
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    expect(
      appRouter.routeInformationProvider.value.uri.path,
      '/create_account',
    );
    expect(
      find.text('This email is already registered. Please log in.'),
      findsOneWidget,
    );
    auth.errorCode = null;
    await tester.tap(find.text('Sign Up'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(appRouter.routeInformationProvider.value.uri.path, '/home');
    expect(auth.signUpCalls, 2);
    expect(auth.submittedEmail, 'new@example.com');
    expect(auth.savedName, 'Test User');
    expect(tester.takeException(), isNull);
  });

  testWidgets('Specialty search filters the visible destinations', (
    tester,
  ) async {
    await openApp(tester, '/specialties');
    await tester.enterText(find.byType(TextField), 'Cardiology');
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Cardiology'), findsWidgets);
    expect(find.text('Dermatology'), findsNothing);
    await tester.enterText(find.byType(TextField), 'no matching specialty');
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Cardiology'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Profile edits persist and update Home; email is read-only', (
    tester,
  ) async {
    final repository = profiles;
    await repository.db.collection('users').doc('test-user').set({
      'fullName': 'Original User',
      'email': 'demo@example.com',
      'phoneNumber': '29123456',
      'dateOfBirth': '1995-05-10',
      'gender': null,
      'photoUrl': null,
      'favoriteDoctorIds': ['doctor-1'],
    });
    await openApp(tester, '/edit_profile');
    final session = tester
        .element(find.byType(EditProfile))
        .read<ProfileCubit>();
    final fields = find.byType(TextFormField);
    expect(
      tester
          .widget<TextField>(
            find.descendant(of: fields.at(2), matching: find.byType(TextField)),
          )
          .readOnly,
      isTrue,
    );
    await tester.enterText(fields.first, 'Saved User');
    await tester.ensureVisible(find.text('Confirm'));
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    expect(find.text('Profile saved.'), findsOneWidget);
    expect(
      (await repository.db.collection('users').doc('test-user').get())
          .data()!['fullName'],
      'Saved User',
    );
    appRouter.go('/home');
    await tester.pumpAndSettle();
    expect(find.text('Saved User'), findsOneWidget);
    expect(
      tester.element(find.byType(HomePage)).read<ProfileCubit>(),
      same(session),
    );
    await repository.db.collection('users').doc('test-user').update({
      'fullName': 'Changed remotely',
    });
    await tester.pumpAndSettle();
    expect(find.text('Changed remotely'), findsOneWidget);
    appRouter.go('/profile');
    await tester.pumpAndSettle();
    expect(find.text('Changed remotely'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
