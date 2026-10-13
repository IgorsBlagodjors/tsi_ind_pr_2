import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';

void main() {
  testWidgets('Email fill stays 45.h tall when validation shows an error', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(412, 915);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [AppInputs.inputEmail(controller: controller)],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    Rect filledArea() {
      final box = InputDecorator.containerOf(
        tester.element(find.byType(EditableText)),
      )!;
      return box.localToGlobal(Offset.zero) & box.size;
    }

    expect(filledArea().height, closeTo(45.h, 0.01));
    expect(formKey.currentState!.validate(), isFalse);
    await tester.pumpAndSettle();
    expect(filledArea().height, closeTo(45.h, 0.01));
    expect(
      tester.getRect(find.text('Enter email')).top,
      greaterThanOrEqualTo(filledArea().bottom),
    );

    await tester.enterText(find.byType(TextFormField), 'test@example.com');
    expect(formKey.currentState!.validate(), isTrue);
    await tester.pumpAndSettle();
    expect(find.text('Enter email'), findsNothing);
    expect(filledArea().height, closeTo(45.h, 0.01));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
