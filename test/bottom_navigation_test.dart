import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/bottom_navigation_example.dart';

void main() {
  testWidgets('All four destinations work and retain page state', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(const MaterialApp(home: BottomNavigationExample()));

    await tester.enterText(find.byType(TextField), 'Remember my question');
    await tester.tap(find.text('View appointments'));
    await tester.pumpAndSettle();
    expect(find.text('Your appointments'), findsOneWidget);
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      1,
    );

    await tester.tap(find.byType(NavigationDestination).at(2));
    await tester.pumpAndSettle();
    expect(find.text('Stay connected'), findsOneWidget);

    await tester.tap(find.byType(NavigationDestination).at(3));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(find.byType(Switch)).value, false);

    await tester.tap(find.byType(NavigationDestination).first);
    await tester.pumpAndSettle();
    expect(find.text('Remember my question'), findsOneWidget);
    await tester.tap(find.byType(NavigationDestination).at(3));
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(find.byType(Switch)).value, false);
    expect(tester.takeException(), isNull);
  });
}
