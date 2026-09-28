import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/header.dart';

void main() {
  testWidgets('Search waits for a three-second pause and cancels on disposal', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final queries = <String>[];
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: Header(title: 'Specialties', onSearchChanged: queries.add),
          ),
        ),
      ),
    );
    final search = find.byType(TextFormField);
    await tester.enterText(search, 'car');
    await tester.pump(const Duration(seconds: 2));
    expect(queries, isEmpty);
    await tester.enterText(search, 'cardiology');
    await tester.pump(const Duration(milliseconds: 2999));
    expect(queries, isEmpty);
    await tester.pump(const Duration(milliseconds: 1));
    expect(queries, ['cardiology']);
    await tester.pump(const Duration(seconds: 3));
    expect(queries, ['cardiology']);

    await tester.enterText(search, '');
    await tester.pump(const Duration(seconds: 3));
    expect(queries, ['cardiology', '']);

    await tester.enterText(search, 'pending');
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 3));
    expect(queries, ['cardiology', '']);
    expect(tester.takeException(), isNull);
  });
}
