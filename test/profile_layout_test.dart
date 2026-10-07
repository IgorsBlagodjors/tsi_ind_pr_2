import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/edit_profile.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/profile.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final fonts = FontLoader('League Spartan');
    for (final weight in ['Light', 'Regular', 'Medium', 'SemiBold']) {
      fonts.addFont(
        rootBundle.load(
          'assets/fonts/league_spartan/LeagueSpartan-$weight.ttf',
        ),
      );
    }
    await fonts.load();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });

  final cases = [
    for (final size in [const Size(320, 568), const Size(360, 640)])
      for (final page in ['profile', 'edit_profile'])
        (size: size, page: page, scale: 1.0, keyboard: false),
    for (final page in ['profile', 'edit_profile'])
      (size: const Size(320, 568), page: page, scale: 1.5, keyboard: false),
    (
      size: const Size(320, 568),
      page: 'edit_profile',
      scale: 1.0,
      keyboard: true,
    ),
  ];

  for (final sample in cases) {
    final label =
        '${sample.page}_${sample.size.width.toInt()}x'
        '${sample.size.height.toInt()}_${sample.scale}'
        '${sample.keyboard ? '_keyboard' : ''}';
    testWidgets(label, (tester) async {
      tester.view.physicalSize = sample.size;
      tester.view.devicePixelRatio = 1;
      tester.view.padding = const FakeViewPadding(top: 24, bottom: 16);
      addTearDown(tester.view.reset);
      final errors = <String>[];
      final previousErrorHandler = FlutterError.onError;
      FlutterError.onError = (details) =>
          errors.add(details.exceptionAsString());
      final router = GoRouter(
        initialLocation: '/${sample.page}',
        routes: [
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (_, _) => const Profile(),
          ),
          GoRoute(
            path: '/edit_profile',
            name: 'edit_profile',
            builder: (_, _) => const EditProfile(),
          ),
        ],
      );
      addTearDown(router.dispose);
      final key = GlobalKey();
      try {
        await tester.pumpWidget(
          ScreenUtilInit(
            designSize: const Size(360, 800),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => RepaintBoundary(
              key: key,
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: 'League Spartan',
                  scaffoldBackgroundColor: Colors.white,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF13CAD6),
                    surface: Colors.white,
                  ),
                ),
                routerConfig: router,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.linear(sample.scale)),
                  child: child!,
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.runAsync(
          () => precacheImage(
            const AssetImage('assets/avatars/Perfil.png'),
            tester.element(
              find.byType(sample.page == 'profile' ? Profile : EditProfile),
            ),
          ),
        );
        await tester.pumpAndSettle();
        if (sample.keyboard) {
          await tester.tap(find.byType(TextFormField).first);
          tester.view.viewInsets = const FakeViewPadding(bottom: 240);
          await tester.pumpAndSettle();
        }
        await tester.runAsync(() async {
          final image =
              await (key.currentContext!.findRenderObject()
                      as RenderRepaintBoundary)
                  .toImage(pixelRatio: 1);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          final directory = Directory('build/profile_qa_recheck');
          await directory.create(recursive: true);
          await File('${directory.path}/$label.png')
              .writeAsBytes(bytes!.buffer.asUint8List());
          await File('${directory.path}/$label.json')
              .writeAsString(jsonEncode(errors));
          image.dispose();
        });
        if (sample.page == 'edit_profile') {
          final birthField = find.byType(TextFormField).last;
          await tester.ensureVisible(birthField);
          await tester.pumpAndSettle();
          final visibleBottom =
              sample.size.height - (sample.keyboard ? 240 : 16);
          final fieldRect = tester.getRect(birthField);
          if (fieldRect.bottom > visibleBottom + 1 || fieldRect.top < 24) {
            errors.add(
              'Date of birth is outside the visible area after scrolling: $fieldRect',
            );
          }
          await tester.runAsync(() async {
            final image =
                await (key.currentContext!.findRenderObject()
                        as RenderRepaintBoundary)
                    .toImage(pixelRatio: 1);
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            await File('build/profile_qa_recheck/${label}_scrolled.png')
                .writeAsBytes(bytes!.buffer.asUint8List());
            image.dispose();
          });
        }
        await tester.pumpWidget(const SizedBox.shrink());
      } finally {
        FlutterError.onError = previousErrorHandler;
      }
      expect(errors, isEmpty, reason: label);
    });
  }
}
