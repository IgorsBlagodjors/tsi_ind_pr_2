import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/appointment.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';

void main() {
  for (final size in [const Size(320, 568), const Size(360, 800),
    const Size(390, 844), const Size(430, 932)]) {
    testWidgets('Appointment tabs and cards fit $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => MaterialApp(
          theme: ThemeData(fontFamily: 'League Spartan'),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(size.width == 320 ? 1.5 : 1)),
            child: child!,
          ),
          home: const BottomNavigation(location: '/apointment', child: Appointment()),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Re-Book'), findsWidgets);
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Upcoming'));
      await tester.pumpAndSettle();
      expect(find.text('Details'), findsWidgets);
      expect(find.text('Re-Book'), findsNothing);
      expect(tester.takeException(), isNull);
      // Reaching the end must not read beyond the doctor list.
      await tester.drag(find.byType(ListView), const Offset(0, -20000));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byTooltip('Home'), findsOneWidget);
      await tester.tap(find.text('Cancelled'));
      await tester.pumpAndSettle();
      expect(find.text('No cancelled appointments'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
