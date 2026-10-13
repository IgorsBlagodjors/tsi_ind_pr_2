import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/review.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final font = FontLoader('League Spartan');
    for (final weight in ['Light', 'Regular', 'Medium', 'SemiBold']) {
      font.addFont(rootBundle.load('assets/fonts/league_spartan/LeagueSpartan-$weight.ttf'));
    }
    await font.load();
    await (FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });
  final longest = doctors.reduce((a, b) => a.name.length > b.name.length ? a : b);
  final longDoctor = Doctor(
    id: 'layout-test', name: 'Dr. Alexandra Elizabeth Montgomery-Williams, M.D.',
    type: doctors.first.type,
    specialization: 'Interventional Cardiology and Cardiovascular Medicine',
    image: doctors.first.image,
  );
  final cases = [
    for (final width in [320.0, 360.0])
      (label: 'normal_${width.toInt()}', size: Size(width, width == 320 ? 568 : 640), scale: 1.0, doctor: doctors.first, keyboard: false),
    (label: 'longest_320', size: const Size(320, 568), scale: 1.0, doctor: longest, keyboard: false),
    (label: 'long_text_320', size: const Size(320, 568), scale: 1.0, doctor: longDoctor, keyboard: false),
    for (final scale in [1.5, 2.0])
      (label: 'text_${scale}_320', size: const Size(320, 568), scale: scale, doctor: longest, keyboard: false),
    (label: 'keyboard_320', size: const Size(320, 568), scale: 1.0, doctor: doctors.first, keyboard: true),
  ];
  for (final sample in cases) {
    testWidgets('Review ${sample.label}', (tester) async {
      tester.view.physicalSize = sample.size;
      tester.view.devicePixelRatio = 1;
      tester.view.padding = const FakeViewPadding(top: 24, bottom: 16);
      addTearDown(tester.view.reset);
      final errors = <String>[];
      final notes = <String>[];
      final oldHandler = FlutterError.onError;
      FlutterError.onError = (details) => errors.add(details.exceptionAsString());
      final key = GlobalKey();
      Future<void> capture(String suffix) => tester.runAsync(() async {
        final image = await (key.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        final file = File('build/review_qa/${sample.label}_$suffix.png');
        await file.parent.create(recursive: true);
        await file.writeAsBytes(bytes!.buffer.asUint8List());
        image.dispose();
      });
      try {
        await tester.pumpWidget(ScreenUtilInit(
          designSize: const Size(360, 800), minTextAdapt: true, splitScreenMode: true,
          builder: (context, child) => RepaintBoundary(key: key, child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'League Spartan', scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF13CAD6), surface: Colors.white)),
            builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(sample.scale)), child: child!),
            home: BottomNavigation(location: '/rewiev', child: Review(doctor: sample.doctor)),
          )),
        ));
        await tester.pumpAndSettle();
        await tester.runAsync(() => precacheImage(AssetImage(sample.doctor.image), tester.element(find.byType(Review))));
        await tester.pumpAndSettle();
        for (final text in [sample.doctor.name, sample.doctor.specialization]) {
          final paragraph = tester.renderObject<RenderParagraph>(find.descendant(of: find.text(text), matching: find.byType(RichText)));
          if (paragraph.didExceedMaxLines) notes.add('Ellipsis: $text');
        }
        await capture('top');
        final field = find.byType(TextFormField);
        await tester.ensureVisible(field);
        await tester.pumpAndSettle();
        if (sample.keyboard) {
          await tester.tap(field);
          tester.view.viewInsets = const FakeViewPadding(bottom: 240);
          await tester.pumpAndSettle();
        }
        final comment = List.filled(20, 'The doctor explained the treatment clearly.').join('\n');
        await tester.enterText(field, comment);
        await tester.pumpAndSettle();
        if (tester.widget<TextFormField>(field).controller!.text != comment) errors.add('Comment text was lost');
        await tester.ensureVisible(find.text('Add Review'));
        await tester.pumpAndSettle();
        final buttonText = tester.getRect(find.text('Add Review'));
        final ink = find.ancestor(of: find.text('Add Review'), matching: find.byType(Ink)).first;
        final buttonRect = tester.getRect(ink);
        if (buttonText.height > buttonRect.height + 1) errors.add('Add Review text height ${buttonText.height} exceeds button height ${buttonRect.height}');
        final bottom = sample.size.height - (sample.keyboard ? 240 : 16);
        if (buttonRect.bottom > bottom + 1) errors.add('Add Review is below the visible viewport');
        await capture('bottom');
        await tester.runAsync(() => File('build/review_qa/${sample.label}.json').writeAsString(jsonEncode({'errors': errors, 'notes': notes})));
        await tester.pumpWidget(const SizedBox.shrink());
      } finally {
        FlutterError.onError = oldHandler;
      }
      expect(errors, isEmpty, reason: sample.label);
    });
  }
}
