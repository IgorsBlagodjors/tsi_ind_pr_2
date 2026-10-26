import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/domain/repositories/doctors_repository.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/pages/doctors_by_specialty_page.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/pages/doctors_page.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/widgets/specialties_header.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/widgets/specialties_filter.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/specialty_view.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_cubit.dart';

import '../../helpers/doctor_profiles.dart';
import '../../helpers/profile_auth.dart';

void main() {
  for (final specialty in [false, true]) {
    testWidgets(
      '${specialty ? 'specialty' : 'doctors'} header scrolls away with pinned filters and search preserved',
      (tester) async {
        tester.view.physicalSize = const Size(360, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        final auth = ProfileAuth(null);
        final profile = EditableProfile(auth)..show('user', {});
        addTearDown(profile.close);
        addTearDown(auth.changes.close);
        final repository = TestDoctorsRepository();
        final alice = repository.doctors.first;
        repository.doctors.addAll(List.generate(20, (_) => alice));
        await tester.pumpWidget(
          RepositoryProvider<DoctorsRepository>.value(
            value: repository,
            child: BlocProvider<ProfileCubit>.value(
              value: profile,
              child: ScreenUtilInit(
                designSize: const Size(360, 800),
                builder: (_, child) => MaterialApp(
                  home: specialty
                      ? const DocBySpecialty(doctorType: DoctorType.cardiology)
                            .withCubit()
                      : Doctors.withCubit(),
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
        final search = find.byType(TextFormField);
        await tester.enterText(search, 'Alice');
        await tester.pump(const Duration(seconds: 2));
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
        final header = find.byType(SpecialtiesHeader, skipOffstage: false);
        final initialTop = tester.getTopLeft(header).dy;
        await tester.drag(find.byType(CustomScrollView), const Offset(0, -550));
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
        expect(tester.getBottomLeft(header).dy, lessThanOrEqualTo(0));
        final filters = find.byType(SpecialtiesFilter);
        expect(filters.hitTestable(), findsOneWidget);
        if (!specialty) {
          expect(find.byType(SpecialityWiev).hitTestable(), findsOneWidget);
        }
        final pinnedTop = tester.getTopLeft(filters).dy;
        await tester.drag(find.byType(CustomScrollView), const Offset(0, -250));
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
        expect(tester.getTopLeft(filters).dy, closeTo(pinnedTop, 0.1));
        final previousOrder = tester
            .widget<SpecialtiesFilter>(filters)
            .sortOrder;
        await tester.tap(find.text('A'));
        await tester.pump();
        expect(
          tester.widget<SpecialtiesFilter>(filters).sortOrder,
          isNot(previousOrder),
        );
        expect(find.text('Alice').hitTestable(), findsWidgets);
        await tester.drag(find.byType(CustomScrollView), const Offset(0, 1200));
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
        expect(tester.getTopLeft(header).dy, closeTo(initialTop, 0.1));
        expect(
          tester
              .widget<EditableText>(find.byType(EditableText))
              .controller
              .text,
          'Alice',
        );
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
      },
    );
  }
}
