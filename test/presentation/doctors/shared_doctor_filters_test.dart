import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/domain/filters/doctor_filters.dart';
import 'package:tsi_ind_pr_2/domain/repositories/doctors_repository.dart';
import 'package:tsi_ind_pr_2/presentation/favorites/pages/favorite_doctors_page.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/pages/doctors_by_specialty_page.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/pages/specialties_page.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/widgets/specialties_filter.dart';

import '../../helpers/doctor_profiles.dart';
import '../../helpers/profile_auth.dart';

void main() {
  for (final page in ['favorites', 'specialty', 'specialties']) {
    testWidgets('$page applies, restores and cancels filters', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final auth = ProfileAuth(null);
      final profile = EditableProfile(auth)..show('user', {'a', 'b'});
      addTearDown(profile.close);
      addTearDown(auth.changes.close);
      DoctorFilters? opened;
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, state) => switch (page) {
              'favorites' => const FavoriteDoctor(),
              'specialty' => const DocBySpecialty(
                doctorType: DoctorType.cardiology,
              ).withCubit(),
              _ => const Specialties(),
            },
          ),
          GoRoute(
            path: '/filters',
            name: 'filters',
            builder: (context, state) {
              opened = state.extra as DoctorFilters;
              return Scaffold(
                body: Column(
                  children: [
                    TextButton(
                      onPressed: () =>
                          context.pop(DoctorFilters(minimumRating: 5)),
                      child: const Text('Five'),
                    ),
                    TextButton(
                      onPressed: () => context.pop(DoctorFilters()),
                      child: const Text('Reset'),
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              );
            },
          ),
          GoRoute(
            path: '/category',
            name: 'doc_by_specialty',
            builder: (_, state) {
              final args = state.extra as DocBySpecialtyArgs;
              return DocBySpecialty(
                doctorType: args.type,
                initialFilters: args.filters,
              ).withCubit();
            },
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        RepositoryProvider<DoctorsRepository>(
          create: (_) => TestDoctorsRepository(),
          child: BlocProvider<ProfileCubit>.value(
            value: profile,
            child: ScreenUtilInit(
              designSize: const Size(360, 800),
              builder: (_, child) => MaterialApp.router(routerConfig: router),
            ),
          ),
        ),
      );
      Future<void> settle() async {
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
      }

      Future<void> open() async {
        tester
            .widget<SpecialtiesFilter>(find.byType(SpecialtiesFilter))
            .onFilterPressed();
        await settle();
      }

      await settle();
      await open();
      await tester.tap(find.text('Five'));
      await settle();
      if (page == 'favorites') {
        expect(find.text('No doctors match your filters.'), findsOneWidget);
        expect(
          find.text('Clara'),
          findsNothing,
        ); // Non-favorite never leaks in.
      } else if (page == 'specialty') {
        expect(find.text('Clara'), findsOneWidget);
        expect(find.text('Alice'), findsNothing);
      } else {
        expect(find.text('Cardiology'), findsOneWidget);
        expect(find.text('Gynecology'), findsNothing);
        await tester.tap(find.text('Cardiology'));
        await settle();
        expect(find.text('Clara'), findsOneWidget);
        expect(find.text('Alice'), findsNothing);
        router.pop();
        await settle();
      }
      await open();
      expect(opened!.minimumRating, 5);
      await tester.tap(find.text('Cancel'));
      await settle();
      await open();
      expect(opened!.minimumRating, 5);
      await tester.tap(find.text('Reset'));
      await settle();
      if (page == 'specialties') {
        expect(find.text('Gynecology'), findsWidgets);
      } else {
        expect(find.text('Alice'), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
