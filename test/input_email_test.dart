import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';

void main() {
  for (final label in ['Email', 'Password', 'Phone', 'Name', 'Birth']) {
    final isPassword = label == 'Password';
    final isPhone = label == 'Phone';
    final error = {
      'Phone': 'Enter phone number',
      'Password': 'Enter password',
      'Email': 'Enter email',
      'Name': 'Enter name',
      'Birth': 'Select birth date',
    }[label]!;
    testWidgets('$label fill stays 45.h tall when validation shows an error', (
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
                  children: [
                    if (isPassword)
                      AppInputs.inputPassword(
                        controller: controller,
                        obscureText: true,
                        onEyePressed: () {},
                      )
                    else if (isPhone)
                      AppInputs.inputPhoneNumber(
                        controller: controller,
                        height: 45.h,
                      )
                    else if (label == 'Name')
                      AppInputs.inputName(controller: controller, height: 45.h)
                    else if (label == 'Birth')
                      AppInputs.inputBirth(
                        controller: controller,
                        context: context,
                        onDateSelected: (_) {},
                      )
                    else
                      AppInputs.inputEmail(controller: controller),
                  ],
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
        tester.getRect(find.text(error)).top,
        greaterThanOrEqualTo(filledArea().bottom),
      );

      if (isPhone) {
        await tester.enterText(find.byType(TextFormField), '1');
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pumpAndSettle();
        expect(filledArea().height, closeTo(45.h, 0.01));
        expect(
          tester.getRect(find.text('Enter a valid phone number')).top,
          greaterThanOrEqualTo(filledArea().bottom),
        );
      }
      if (label == 'Birth') {
        controller.text = '01 / 01 / 2000';
      } else {
        await tester.enterText(
          find.byType(TextFormField),
          isPhone ? '+371 20000000' : 'test@example.com',
        );
      }
      expect(formKey.currentState!.validate(), isTrue);
      await tester.pumpAndSettle();
      expect(find.text(error), findsNothing);
      expect(filledArea().height, closeTo(45.h, 0.01));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
