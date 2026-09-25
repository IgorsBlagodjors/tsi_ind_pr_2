import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/main.dart' as app;
import 'package:tsi_ind_pr_2/test_page.dart';
import 'package:tsi_ind_pr_2/design_system/app_tappable.dart';

void main() {
  testWidgets('App opens the button showcase without rendering errors', (
    WidgetTester tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    app.main();
    await tester.pumpAndSettle();

    expect(find.byType(TestPage), findsOneWidget);
    expect(find.text('Component Catalog'), findsOneWidget);
    await tester.tap(find.byType(AppTappable).first);
    await tester.pumpAndSettle();
    expect(find.text('Pressed: circleInkButton'), findsOneWidget);

    for (final tab in [
      'Selection',
      'Inputs',
      'Containers',
      'Icons',
      'Avatars',
    ]) {
      await tester.ensureVisible(find.text(tab));
      await tester.tap(find.text(tab));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: tab);
      if (tab == 'Selection') {
        await tester.tap(find.byType(AppTappable).first);
        await tester.pumpAndSettle();
        expect(find.text('Specialty: true'), findsOneWidget);
      }
      if (tab == 'Inputs') {
        await tester.ensureVisible(find.text('Validate form'));
        await tester.tap(find.text('Validate form'));
        await tester.pumpAndSettle();
        expect(find.text('Please check the form fields'), findsOneWidget);
      }
    }
    expect(find.byType(CircleAvatar), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
