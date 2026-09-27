import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/log_in.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/create_account.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/set_password.dart';

Future<void> showScreen(
  WidgetTester tester,
  Widget screen, {
  double scale = 1,
}) async {
  await tester.binding.setSurfaceSize(const Size(320, 640));
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        theme: ThemeData(fontFamily: 'League Spartan'),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
        home: screen,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('login accepts phone and long passwords; rejects empty form', (
    tester,
  ) async {
    await showScreen(tester, const LogIn());
    final form = tester.state<FormState>(find.byType(Form));
    expect(form.validate(), isFalse);
    await tester.pump();
    expect(find.text('Enter email or mobile number'), findsOneWidget);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '+371 20000000');
    await tester.enterText(fields.at(1), 'a-password-longer-than-fifteen');
    expect(form.validate(), isTrue);
    expect(
      tester.widget<TextFormField>(fields.at(1)).controller!.text,
      'a-password-longer-than-fifteen',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('reset validates confirmation and keeps shared visibility', (
    tester,
  ) async {
    await showScreen(tester, const SetPassword(), scale: 1.5);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'new-password');
    await tester.enterText(fields.at(1), 'different-password');
    final form = tester.state<FormState>(find.byType(Form));
    expect(form.validate(), isFalse);
    await tester.pump();
    expect(find.text('Passwords do not match'), findsOneWidget);
    final eye = find
        .widgetWithIcon(IconButton, Icons.visibility_off_outlined)
        .first;
    await tester.ensureVisible(eye);
    await tester.pumpAndSettle();
    await tester.tap(eye);
    await tester.pump();
    for (final field in tester.widgetList<TextField>(find.byType(TextField))) {
      expect(field.obscureText, isFalse);
    }
    await tester.enterText(fields.at(1), 'new-password');
    expect(form.validate(), isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'registration errors fit with large text and long names remain intact',
    (tester) async {
      await showScreen(tester, const CreateAccount(), scale: 1.5);
      final form = tester.state<FormState>(find.byType(Form));
      expect(form.validate(), isFalse);
      await tester.pump();
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'Alexandra Maria Johnson');
      expect(
        tester.widget<TextFormField>(fields.first).controller!.text,
        'Alexandra Maria Johnson',
      );
      final terms = find.text('Terms of Use');
      await tester.ensureVisible(terms);
      await tester.tap(terms);
      await tester.pumpAndSettle();
      expect(
        find.text('This document has not been published yet.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
