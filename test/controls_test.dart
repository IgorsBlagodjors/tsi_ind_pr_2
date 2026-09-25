import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/design_system/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/app_selectors.dart';

Widget harness(Widget child) => ScreenUtilInit(
  designSize: const Size(360, 800),
  builder: (context, _) => MaterialApp(
    home: Scaffold(body: Center(child: child)),
  ),
);

void main() {
  testWidgets('Gradient button supports touch and keyboard activation', (
    tester,
  ) async {
    var presses = 0;
    // Initialize ScreenUtil before building the controls.
    await tester.pumpWidget(harness(const SizedBox()));
    await tester.pumpWidget(
      harness(
        AppButtons.smallSquareBTN(
          onPressed: () => presses++,
          contWidth: 60,
          contHeight: 60,
          radius: 12,
          icon: const Icon(Icons.add),
        ),
      ),
    );
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();
    expect(presses, 1);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(presses, 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Selector, radio and switch update their states on tap', (
    tester,
  ) async {
    await tester.pumpWidget(harness(const SizedBox()));
    var selected = false;
    var checked = false;
    var toggled = false;
    await tester.pumpWidget(
      harness(
        StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSelectors.specialitySelector(
                text: 'Cardiology',
                icon: const Icon(Icons.favorite),
                isClicked: selected,
                onPressed: () => setState(() => selected = !selected),
              ),
              AppButtons.customRadioBTN(
                selected: checked,
                onTap: () => setState(() => checked = true),
              ),
              AppButtons.switchBTN(
                value: toggled,
                onTap: () => setState(() => toggled = !toggled),
              ),
            ],
          ),
        ),
      ),
    );
    expect(selected, false);
    expect(checked, false);
    expect(toggled, false);
    for (var index = 0; index < 3; index++) {
      await tester.tap(find.byType(InkWell).at(index));
      await tester.pumpAndSettle();
    }
    expect(selected, true);
    expect(checked, true);
    expect(toggled, true);
    expect(tester.takeException(), isNull);
  });
}
