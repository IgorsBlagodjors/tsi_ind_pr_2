import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/log_in.dart';

void main() {
  testWidgets('Password visibility toggles without clearing either field', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    tester.view.padding = const FakeViewPadding(top: 24, bottom: 24);
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) => const MaterialApp(home: LogIn()),
    ));
    await tester.pumpAndSettle();
    // The registration link must be visible before any scrolling.
    expect(tester.getRect(find.text('Sign Up')).bottom, lessThanOrEqualTo(776));
    expect(tester.takeException(), isNull);
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'test@example.com');
    await tester.enterText(fields.at(1), 'example-password');

    expect(tester.widget<TextField>(fields.at(1)).obscureText, isTrue);
    await tester.tap(find.byIcon(Icons.visibility_off_outlined));
    await tester.pump();
    expect(tester.widget<TextField>(fields.at(1)).obscureText, isFalse);
    expect(tester.widget<TextField>(fields.at(0)).controller!.text, 'test@example.com');
    expect(tester.widget<TextField>(fields.at(1)).controller!.text, 'example-password');

    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();
    expect(tester.widget<TextField>(fields.at(1)).obscureText, isTrue);
    expect(tester.widget<TextField>(fields.at(1)).controller!.text, 'example-password');
    expect(tester.takeException(), isNull);
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sign Up'));
    await tester.pumpAndSettle();
    final signUpRect = tester.getRect(find.text('Sign Up'));
    expect(signUpRect.bottom, lessThanOrEqualTo(500));
    expect(tester.takeException(), isNull);
  });
}
