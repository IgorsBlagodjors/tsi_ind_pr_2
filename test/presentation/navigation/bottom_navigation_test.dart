import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/app/router/app_router.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_tappable.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';
import 'package:tsi_ind_pr_2/presentation/home/home_page.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/log_in.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/set_password.dart';
import 'package:tsi_ind_pr_2/presentation/welcome/welcome_screen.dart';

void main() {
  testWidgets('tabs switch pages inside bottom navigation', (tester) async {
    final fonts = FontLoader('League Spartan')
      ..addFont(
        rootBundle.load(
          'assets/fonts/league_spartan/LeagueSpartan-Regular.ttf',
        ),
      );
    await fonts.load();
    await tester.binding.setSurfaceSize(const Size(360, 800));
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() => tester.binding.setSurfaceSize(null));
    appRouter.goNamed('bottom_navigation');
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => MaterialApp.router(
          theme: ThemeData(fontFamily: 'League Spartan'),
          routerConfig: appRouter,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    final today = DateTime.now();
    final monday = DateTime(
      today.year,
      today.month,
      today.day - today.weekday + 1,
    );
    const weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    void expectWeek(DateTime start) {
      for (var i = 0; i < 7; i++) {
        final dayColumn = find
            .ancestor(of: find.text(weekdays[i]), matching: find.byType(Column))
            .first;
        final date = DateTime(start.year, start.month, start.day + i);
        expect(
          find.descendant(of: dayColumn, matching: find.text('${date.day}')),
          findsOneWidget,
        );
      }
    }

    expectWeek(monday);
    final viewport = tester.getRect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SingleChildScrollView &&
            widget.scrollDirection == Axis.horizontal,
      ),
    );
    final todayRect = tester.getRect(find.text(weekdays[today.weekday - 1]));
    expect(viewport.contains(todayRect.topLeft), isTrue);
    expect(viewport.contains(todayRect.bottomRight), isTrue);
    final todayContainer = tester.widget<Container>(
      find
          .ancestor(
            of: find.text(weekdays[today.weekday - 1]),
            matching: find.byType(Container),
          )
          .first,
    );
    expect((todayContainer.decoration! as BoxDecoration).color, Colors.white);
    await tester.tap(find.byTooltip('Next week'));
    await tester.pumpAndSettle();
    expectWeek(DateTime(monday.year, monday.month, monday.day + 7));
    await tester.tap(find.byTooltip('Previous week'));
    await tester.pumpAndSettle();
    expectWeek(monday);

    Future<void> tapTab(int index, Type pageType) async {
      final scaffold = tester.widget<Scaffold>(
        find
            .descendant(
              of: find.byType(BottomNavigation),
              matching: find.byType(Scaffold),
            )
            .first,
      );
      await tester.tap(
        find
            .descendant(
              of: find.byWidget(scaffold.bottomNavigationBar!),
              matching: find.byType(AppTappable),
            )
            .at(index),
      );
      await tester.pumpAndSettle();
      expect(
        appRouter.routeInformationProvider.value.uri.path,
        '/bottom_navigation',
      );
      expect(find.byType(pageType), findsOneWidget);
      expect(find.byType(BottomNavigation), findsOneWidget);
      expect(tester.takeException(), isNull);
    }

    await tapTab(2, LogIn);
    await tapTab(3, SetPassword);
    await tapTab(1, WelcomeScreen);
    await tapTab(0, HomePage);
  });
}
