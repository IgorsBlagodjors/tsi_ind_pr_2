import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/presentation/home/home_page.dart';
import 'package:tsi_ind_pr_2/presentation/home/widgets/section_header.dart';

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
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) => MaterialApp(
            theme: ThemeData(fontFamily: 'League Spartan'),
            home: const HomePage(),
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
        (3, 'All specialties'),
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
    });
  }
}
