import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';

void main() {
  testWidgets('Age and Full Name have the same visible height on a phone', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(412, 915);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    addTearDown(nameController.dispose);
    addTearDown(ageController.dispose);
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppInputs.inputName(
                  controller: nameController,
                  isGradient: false,
                  height: 35.h,
                ),
                AppInputs.inputAge(controller: ageController, height: 35.h),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final fields = find.byType(EditableText);
    final nameFill = InputDecorator.containerOf(tester.element(fields.at(0)))!;
    final ageFill = InputDecorator.containerOf(tester.element(fields.at(1)))!;
    expect(ageFill.size.height, nameFill.size.height);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Age field keeps its height and centers hint and entered text', (
    tester,
  ) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    for (final height in [35.0, 48.0]) {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: Center(
                child: AppInputs.inputAge(
                  controller: controller,
                  height: height,
                ),
              ),
            ),
          ),
        ),
      );

      for (final value in ['', '30']) {
        controller.text = value;
        await tester.pumpAndSettle();
        final fill = InputDecorator.containerOf(
          tester.element(find.byType(EditableText)),
        )!;
        final field = fill.localToGlobal(Offset.zero) & fill.size;
        final text = tester.getRect(
          value.isEmpty ? find.text('30') : find.byType(EditableText),
        );
        expect(field.height, height);
        expect(text.center.dy, closeTo(field.center.dy, 1));
        expect(tester.takeException(), isNull);
      }
    }
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
