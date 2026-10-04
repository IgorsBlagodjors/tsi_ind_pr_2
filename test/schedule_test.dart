import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors.dart';
import 'package:tsi_ind_pr_2/data/schedule/demo_availability.dart';
import 'package:tsi_ind_pr_2/presentation/schedule.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/appointment_calendar.dart';

void main() {
  const availability = DemoAvailability('daniel-rodriguez');

  test('Sundays are closed and past appointment times cannot be selected', () {
    final now = DateTime(2026, 10, 5, 10, 15);
    expect(availability.slotsFor(DateTime(2026, 10, 4), now: now), isEmpty);
    final slots = availability.slotsFor(now, now: now);
    expect(slots.length, 15);
    expect(slots.take(3).every((s) => s.status == SlotStatus.elapsed), isTrue);
    expect(slots.last.start, DateTime(2026, 10, 5, 16));
    expect(
      slots
          .where((s) => s.status == SlotStatus.available)
          .every((s) => s.start.isAfter(now)),
      isTrue,
    );
  });

  test('Demo schedule includes fully booked days and mixed availability', () {
    final now = DateTime(2026, 12, 25);
    final days = List.generate(
      20,
      (i) => availability.slotsFor(DateTime(2027, 1, i + 1), now: now),
    );
    expect(
      days.any(
        (slots) =>
            slots.isNotEmpty &&
            slots.every((s) => s.status == SlotStatus.booked),
      ),
      isTrue,
    );
    expect(
      days.any(
        (slots) =>
            slots.any((s) => s.status == SlotStatus.available) &&
            slots.any((s) => s.status == SlotStatus.booked),
      ),
      isTrue,
    );
  });

  testWidgets(
    'Time selection clears on date change; booked slots are disabled',
    (tester) async {
      DateTime? selection;
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: AppointmentCalendar(
                  doctorId: 'daniel-rodriguez',
                  onChanged: (value) => selection = value,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // Move into the future so this test is independent of today's opening hours.
      for (var attempt = 0; attempt < 10; attempt++) {
        await tester.tap(find.byTooltip('Next days'));
        await tester.pumpAndSettle();
        if (tester
            .widgetList<OutlinedButton>(find.byType(OutlinedButton))
            .any((button) => button.onPressed != null)) {
          break;
        }
      }
      final available = find.byWidgetPredicate(
        (widget) => widget is OutlinedButton && widget.onPressed != null,
      );
      final unavailable = find.byWidgetPredicate(
        (widget) => widget is OutlinedButton && widget.onPressed == null,
      );
      expect(available, findsWidgets);
      expect(unavailable, findsWidgets);
      await tester.ensureVisible(available.first);
      await tester.tap(available.first);
      await tester.pumpAndSettle();
      expect(selection, isNotNull);
      expect(find.textContaining('Selected:'), findsOneWidget);
      await tester.ensureVisible(find.byTooltip('Next days'));
      await tester.tap(find.byTooltip('Next days'));
      await tester.pumpAndSettle();
      expect(selection, isNull);
      expect(find.textContaining('Selected:'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('Schedule fits a narrow phone with a long doctor name', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => MaterialApp(
          home: Schedule(
            doctor: doctors.firstWhere(
              (doctor) => doctor.id == 'michael-davidson',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Upcoming Schedule'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
