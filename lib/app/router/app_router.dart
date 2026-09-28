import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/create_account.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/log_in.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/set_password.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';

import 'package:tsi_ind_pr_2/presentation/welcome/welcome_screen.dart';

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
    GoRoute(
      path: '/create_account',
      name: 'create_account',
      builder: (context, state) => const CreateAccount(),
    ),
    GoRoute(
      path: '/set_password',
      name: 'set_password',
      builder: (context, state) => const SetPassword(),
    ),
    GoRoute(
      path: '/bottom_navigation',
      name: 'bottom_navigation',
      builder: (context, state) => const BottomNavigation(),
    ),
  ],
);
