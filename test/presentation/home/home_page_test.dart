import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/app/router/app_router.dart';
import 'package:tsi_ind_pr_2/presentation/home/widgets/section_header.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/specialties.dart';

void main() {
  for (final width in [320.0, 360.0, 430.0]) {
    testWidgets('Home actions work at width $width', (tester) async {
      final fonts = FontLoader('League Spartan')
        ..addFont(
          rootBundle.load(
            'assets/fonts/league_spartan/LeagueSpartan-Regular.ttf',
          ),
        );
      await fonts.load();
      tester.view.physicalSize = Size(width, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final router = GoRouter(
        initialLocation: '/bottom_navigation',
        routes: appRouter.configuration.routes,
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) => MaterialApp.router(
            theme: ThemeData(fontFamily: 'League Spartan'),
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      Future<void> checkAction(Finder button, String message) async {
        await tester.ensureVisible(button);
        await tester.pumpAndSettle();
        await tester.tap(button);
        await tester.pumpAndSettle();
        expect(
          find.descendant(
            of: find.byType(SnackBar),
            matching: find.text(message),
          ),
          findsOneWidget,
        );
        tester
            .state<ScaffoldMessengerState>(find.byType(ScaffoldMessenger))
            .removeCurrentSnackBar();
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }

      final headers = find.byType(SectionHeader);
      for (final entry in [
        (0, 'All categories'),
        (2, 'All appointments'),
      ]) {
        await checkAction(
          find.descendant(
            of: headers.at(entry.$1),
            matching: find.text('See all'),
          ),
          entry.$2,
        );
      }
      for (final label in [
        'Cardiology',
        'Dermatology',
        'General medicine',
        'Gynecology',
        'Odontology',
        'Oncology',
      ]) {
        await checkAction(find.text(label), label);
      }
      for (final label in ['Favorite', 'Doctors', 'Pharmacy', 'Record']) {
        await checkAction(find.text(label), label);
      }
      final seeAllSpecialties = find.descendant(
        of: headers.at(3),
        matching: find.text('See all'),
      );
      await tester.ensureVisible(seeAllSpecialties);
      await tester.pumpAndSettle();
      await tester.tap(seeAllSpecialties);
      await tester.pumpAndSettle();
      expect(find.byType(Specialties), findsOneWidget);
      expect(router.canPop(), isTrue);
      router.pop();
      await tester.pumpAndSettle();
      expect(find.byType(SectionHeader), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  }
}
