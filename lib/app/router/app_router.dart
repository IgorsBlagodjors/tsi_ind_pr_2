import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/appointment.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/create_account.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/log_in.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/set_password.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/doctors.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/doctors_info.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';
import 'package:tsi_ind_pr_2/presentation/home/home_page.dart';
import 'package:tsi_ind_pr_2/presentation/schedule.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/doc_by_specialty.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/specialties.dart';
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
    ShellRoute(
      builder: (context, state, child) =>
          BottomNavigation(location: state.uri.path, child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/specialties',
          name: 'specialties',
          builder: (context, state) => const Specialties(),
        ),
        GoRoute(
          path: '/doc_by_specialty',
          name: 'doc_by_specialty',
          builder: (context, state) =>
              DocBySpecialty(doctorType: state.extra as DoctorType),
        ),
        GoRoute(
          path: '/doctors',
          name: 'doctors',
          builder: (context, state) => Doctors(),
        ),
        GoRoute(
          path: '/doctors_info',
          name: 'doctors_info',
          builder: (context, state) =>
              DoctorsInfo(doctor: state.extra as Doctor),
        ),
        GoRoute(
          path: '/schedule',
          name: 'schedule',
          builder: (context, state) => Schedule(doctor: state.extra as Doctor),
        ),
        GoRoute(
          path: '/apointment',
          name: 'apointment',
          builder: (context, state) => Appointment(),
        ),
      ],
    ),
  ],
);
