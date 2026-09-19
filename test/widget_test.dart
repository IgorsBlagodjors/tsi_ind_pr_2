import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/main.dart' as app;
import 'package:tsi_ind_pr_2/test_page.dart';

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
    expect(find.text('Log In'), findsNWidgets(2));
    expect(find.text('Sign Up'), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });
}
