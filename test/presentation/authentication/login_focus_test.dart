import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/log_in_page.dart';

import '../../helpers/profile_auth.dart';

void main() {
  testWidgets('Password retains focus after typing and validation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);
    final auth = ProfileAuth(null);
    addTearDown(auth.changes.close);
    await tester.pumpWidget(
      RepositoryProvider<AuthRepository>.value(
        value: auth,
        child: ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (_, child) => MaterialApp(home: LogIn.withCubit()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'test@example.com');
    await tester.pumpAndSettle();
    await tester.tap(fields.at(1));
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    tester.testTextInput.enterText('a');
    await tester.pumpAndSettle();
    final password = tester.widget<EditableText>(
      find.byType(EditableText).at(1),
    );
    expect(password.focusNode.hasFocus, isTrue);
    expect(tester.testTextInput.isVisible, isTrue);
    expect(password.controller.text, 'a');
    expect(tester.takeException(), isNull);
  });
}
