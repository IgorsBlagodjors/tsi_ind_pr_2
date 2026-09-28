import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/presentation/home/widgets/schedule_section.dart';

void main() {
  for (final width in [280.0, 320.0]) {
    testWidgets('calendar scrolls on a $width wide screen', (tester) async {
      final fonts = FontLoader('League Spartan')
        ..addFont(
          rootBundle.load(
            'assets/fonts/league_spartan/LeagueSpartan-Regular.ttf',
          ),
        );
      await fonts.load();
      tester.view.physicalSize = Size(width, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) => MaterialApp(
            theme: ThemeData(fontFamily: 'League Spartan'),
            home: const Scaffold(body: ScheduleSection()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
      final viewport = tester.getRect(find.byType(SingleChildScrollView));
      final today = tester.getRect(find.text(days[DateTime.now().weekday - 1]));
      expect(viewport.contains(today.topLeft), isTrue);
      expect(viewport.contains(today.bottomRight), isTrue);
      final position = tester
          .state<ScrollableState>(find.byType(Scrollable))
          .position;
      expect(position.maxScrollExtent, greaterThan(0));
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(-500, 0),
      );
      await tester.pumpAndSettle();
      expect(viewport.contains(tester.getCenter(find.text('SUN'))), isTrue);
      await tester.tap(find.text('SUN'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
