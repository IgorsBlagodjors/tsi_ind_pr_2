import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/presentation/filters.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final font = FontLoader('League Spartan');
    for (final weight in ['Light', 'Regular', 'Medium', 'SemiBold']) {
      font.addFont(rootBundle.load('assets/fonts/league_spartan/LeagueSpartan-$weight.ttf'));
    }
    await font.load();
    await (FontLoader('MaterialIcons')
          ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf')))
        .load();
  });

  for (final size in [const Size(320, 568), const Size(360, 800)]) {
    testWidgets('Age slider can select the full range on $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final key = GlobalKey();
      await tester.pumpWidget(ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => RepaintBoundary(
          key: key,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'League Spartan', scaffoldBackgroundColor: Colors.white),
            home: const Filters(),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      final slider = find.byType(Slider);
      await tester.ensureVisible(slider);
      await tester.pumpAndSettle();
      expect(tester.widget<Slider>(slider).value, 40);
      expect(tester.takeException(), isNull);
      await tester.runAsync(() async {
        final image = await (key.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        final file = File('build/filters_qa/age_${size.width.toInt()}.png');
        await file.parent.create(recursive: true);
        await file.writeAsBytes(bytes!.buffer.asUint8List());
        image.dispose();
      });
      final rect = tester.getRect(slider);
      await tester.tapAt(Offset(rect.left + 1, rect.center.dy));
      await tester.pumpAndSettle();
      expect(tester.widget<Slider>(slider).value, 20);
      await tester.dragFrom(Offset(rect.left + 1, rect.center.dy), Offset(rect.width - 2, 0));
      await tester.pumpAndSettle();
      expect(tester.widget<Slider>(slider).value, 80);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
