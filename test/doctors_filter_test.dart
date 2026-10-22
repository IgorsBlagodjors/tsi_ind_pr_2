import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_filters.dart';
import 'package:tsi_ind_pr_2/presentation/filters.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';
import 'package:tsi_ind_pr_2/data/users/firebase_profile_repository.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/doctors.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/doctors_lw.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/speciality_wiev.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/specialties_header.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/specialties_filter.dart';

import 'helpers/profile_auth.dart';

class TestDoctorsRepository implements DoctorsRepository {
  final doctors = [
    const Doctor(
      id: 'a',
      name: 'Alice',
      gender: Gender.female,
      rating: 4.5,
      yearsOfExperience: 10,
      type: DoctorType.cardiology,
      specialization: 'Heart specialist',
      image: '',
    ),
    const Doctor(
      id: 'b',
      name: 'Bob',
      gender: Gender.male,
      rating: 3,
      yearsOfExperience: 5,
      type: DoctorType.gynecology,
      specialization: 'Gynecologist',
      image: '',
    ),
    const Doctor(
      id: 'c',
      name: 'Clara',
      gender: Gender.female,
      rating: 5,
      yearsOfExperience: 6,
      type: DoctorType.cardiology,
      specialization: 'Cardiologist',
      image: '',
    ),
  ];
  @override
  Stream<List<Doctor>> watchDoctors() => Stream.value(doctors);
  @override
  Stream<List<Doctor>> watchFavoriteDoctors(List<String> favoriteIds) =>
      Stream.value(
        doctors.where((doctor) => favoriteIds.contains(doctor.id)).toList(),
      );
  @override
  Stream<List<Doctor>> watchDoctorsByType(DoctorType type) =>
      Stream.value(doctors.where((doctor) => doctor.type == type).toList());
  @override
  Future<Doctor?> getDoctorById(String id) async => null;
}

class TestProfileCubit extends ProfileCubit {
  TestProfileCubit(ProfileAuth auth)
    : super(auth, FirebaseProfileRepository()) {
    emit(
      const ProfileLoaded(
        AppUser(id: 'user', fullName: 'Test', email: 'test@example.com'),
      ),
    );
  }
}

void main() {
  for (final width in [360.0, 320.0]) {
    testWidgets('Doctors filters and layout at width $width', (tester) async {
      tester.view.physicalSize = Size(width, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final auth = ProfileAuth(null);
      addTearDown(auth.changes.close);
      final router = GoRouter(
        initialLocation: '/doctors',
        routes: [
          GoRoute(
            path: '/doctors',
            name: 'doctors',
            builder: (_, state) => Doctors.withCubit(),
          ),
          GoRoute(
            path: '/filters',
            name: 'filters',
            builder: (_, state) =>
                Filters(initialFilters: state.extra as DoctorFilters?),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        RepositoryProvider<DoctorsRepository>(
          create: (_) => TestDoctorsRepository(),
          child: BlocProvider<ProfileCubit>(
            create: (_) => TestProfileCubit(auth),
            child: ScreenUtilInit(
              designSize: const Size(360, 800),
              builder: (_, child) => MaterialApp.router(routerConfig: router),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      List<String> visibleIds() => tester
          .widget<DoctorsLw>(find.byType(DoctorsLw))
          .doctorList
          .map((doctor) => doctor.id)
          .toList();
      expect(visibleIds(), ['a', 'b', 'c']);
      tester
          .widget<SpecialtiesFilter>(find.byType(SpecialtiesFilter))
          .onFilterPressed!();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.text('Female'));
      await tester.tap(find.text('10+'));
      await tester.ensureVisible(find.text('Apply filters'));
      await tester.tap(find.text('Apply filters'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(visibleIds(), ['a']);
      tester
          .widget<SpecialtiesFilter>(find.byType(SpecialtiesFilter))
          .onFilterPressed!();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(
        tester.widget<Filters>(find.byType(Filters)).initialFilters!.gender,
        Gender.female,
      );
      await tester.tap(find.text('Reset'));
      await tester.ensureVisible(find.text('Apply filters'));
      await tester.tap(find.text('Apply filters'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(visibleIds(), ['a', 'b', 'c']);
      tester.widget<SpecialityWiev>(find.byType(SpecialityWiev)).onChanged({
        DoctorType.cardiology,
      });
      await tester.pump();
      expect(visibleIds(), ['a', 'c']);
      tester
          .widget<SpecialtiesFilter>(find.byType(SpecialtiesFilter))
          .onPressed();
      await tester.pump();
      expect(visibleIds(), ['c', 'a']);
      tester
          .widget<SpecialtiesHeader>(find.byType(SpecialtiesHeader))
          .onSearchChanged!('heart');
      await tester.pump();
      expect(visibleIds(), ['a']);
      tester.widget<SpecialityWiev>(find.byType(SpecialityWiev)).onChanged({});
      await tester.pump();
      expect(find.text('No doctors match your filters.'), findsOneWidget);
      expect(find.byType(DoctorsLw), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
}
