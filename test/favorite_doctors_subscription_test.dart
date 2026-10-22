import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/data/users/firebase_profile_repository.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_state.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/favorite_doctor.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/a_z_filter.dart';

import 'helpers/profile_auth.dart';

class FavoriteQueries implements DoctorsRepository {
  int queries = 0;
  int cancelled = 0;
  @override
  Stream<List<Doctor>> watchDoctors() {
    queries++;
    late StreamController<List<Doctor>> controller;
    controller = StreamController<List<Doctor>>(
      onListen: () => controller.add([]),
      onCancel: () {
        cancelled++;
      },
    );
    return controller.stream;
  }

  @override
  Stream<List<Doctor>> watchFavoriteDoctors(List<String> ids) =>
      throw StateError('This screen uses watchDoctors');
  @override
  Stream<List<Doctor>> watchDoctorsByType(DoctorType type) =>
      throw UnimplementedError();
  @override
  Future<Doctor?> getDoctorById(String id) => throw UnimplementedError();
}

class EditableProfile extends ProfileCubit {
  EditableProfile(ProfileAuth auth) : super(auth, FirebaseProfileRepository());
  void show(String id, Set<String> favorites, {String name = 'User'}) => emit(
    ProfileLoaded(
      AppUser(
        id: id,
        fullName: name,
        email: 'u@example.com',
        favoriteDoctorIds: favorites,
      ),
    ),
  );
}

void main() {
  testWidgets(
    'Favorites keep one subscription across profile and sort changes',
    (tester) async {
      final auth = ProfileAuth(null);
      final profile = EditableProfile(auth)..show('user', {'a', 'b'});
      final repository = FavoriteQueries();
      addTearDown(profile.close);
      addTearDown(auth.changes.close);

      await tester.pumpWidget(
        RepositoryProvider<DoctorsRepository>.value(
          value: repository,
          child: BlocProvider<ProfileCubit>.value(
            value: profile,
            child: ScreenUtilInit(
              designSize: const Size(360, 800),
              builder: (_, child) => MaterialApp(home: const FavoriteDoctor()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(repository.queries, 1);
      tester.widget<AZFilter>(find.byType(AZFilter)).onPressed();
      profile.show('user', {'b', 'a'}, name: 'Edited');
      await tester.pumpAndSettle();
      expect(repository.queries, 1);
      profile.show('user', {'a'});
      await tester.pumpAndSettle();
      expect(repository.queries, 1);
      expect(repository.cancelled, 0);
      profile.show('other', {'a'});
      await tester.pumpAndSettle();
      expect(repository.queries, 1);
      profile.show('other', {});
      await tester.pumpAndSettle();
      expect(repository.queries, 1);
      expect(find.text('No favorite doctors yet.'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      expect(repository.cancelled, 1);
      expect(tester.takeException(), isNull);
    },
  );
}
