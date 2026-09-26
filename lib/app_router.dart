import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/presentation/autent/log_in.dart';
import 'package:tsi_ind_pr_2/presentation/welcome_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LogIn(),
    ),
  ],
);
