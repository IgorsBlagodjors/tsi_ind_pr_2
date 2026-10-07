import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/favorite_doctor.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final loader = FontLoader('League Spartan');
    for (final weight in ['Light', 'Regular', 'Medium', 'SemiBold']) {
      loader.addFont(
        rootBundle.load(
          'assets/fonts/league_spartan/LeagueSpartan-$weight.ttf',
        ),
      );
    }
    await loader.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });

  for (final size in [const Size(320, 568), const Size(360, 640)]) {
    for (final scale in [1.0, 1.5]) {
      testWidgets('FavoriteDoctor fits $size at text scale $scale', (
        tester,
      ) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        Doctor? selected;
        final router = GoRouter(
          initialLocation: '/favorite_doctor',
          routes: [
            GoRoute(
              path: '/favorite_doctor',
              builder: (context, state) => const BottomNavigation(
                location: '/favorite_doctor',
                child: FavoriteDoctor(),
              ),
            ),
            GoRoute(
              path: '/schedule',
              name: 'schedule',
              builder: (context, state) {
                selected = state.extra as Doctor;
                return const Scaffold(body: Text('Schedule destination'));
              },
            ),
          ],
        );
        addTearDown(router.dispose);
        final boundaryKey = GlobalKey();
        await tester.pumpWidget(
          ScreenUtilInit(
            designSize: const Size(360, 800),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => RepaintBoundary(
              key: boundaryKey,
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(fontFamily: 'League Spartan'),
                routerConfig: router,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(scale),
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                  ),
                  child: child!,
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.runAsync(() async {
          final context = tester.element(find.byType(FavoriteDoctor));
          await Future.wait(
            getFavDoctors().map(
              (doctor) => precacheImage(AssetImage(doctor.image), context),
            ),
          );
        });
        await tester.pumpAndSettle();
        await tester.runAsync(() async {
          final boundary =
              boundaryKey.currentContext!.findRenderObject()
                  as RenderRepaintBoundary;
          final image = await boundary.toImage(pixelRatio: 2);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          final file = File(
            'build/favorite_doctor_qa/${size.width.toInt()}_$scale.png',
          );
          await file.parent.create(recursive: true);
          await file.writeAsBytes(bytes!.buffer.asUint8List());
          image.dispose();
        });
        expect(tester.takeException(), isNull);
        expect(find.text('Favorite'), findsOneWidget);
        expect(find.text('Make Appointment'), findsWidgets);
        await tester.drag(find.byType(ListView), const Offset(0, -3000));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.text(getFavDoctors().last.name), findsOneWidget);
        await tester.drag(find.byType(ListView), const Offset(0, 3000));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Make Appointment').first);
        await tester.pumpAndSettle();
        expect(selected, same(getFavDoctors().first));
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
      });
    }
  }
}
