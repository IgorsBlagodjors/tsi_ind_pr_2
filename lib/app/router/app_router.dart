import 'package:tsi_ind_pr_2/presentation/appointments/appointment.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/domain/app_access.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/appointment_details.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/widgets/profile_session.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/review.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/create_account.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/log_in.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/set_password.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/doctors.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/doctors_info.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/favorite_doctor.dart';
import 'package:tsi_ind_pr_2/presentation/filters.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';
import 'package:tsi_ind_pr_2/presentation/home/home_page.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/edit_profile.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/profile.dart';
import 'package:tsi_ind_pr_2/presentation/schedule.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/doc_by_specialty.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/specialties.dart';
import 'package:tsi_ind_pr_2/presentation/welcome/welcome_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: AppAccess.instance,
  redirect: (context, state) {
    const publicPaths = {'/', '/login', '/create_account', '/set_password'};
    if (publicPaths.contains(state.uri.path)) return null;
    final user = context.read<AuthRepository>().currentUser;
    return AppAccess.instance.allows(user?.id) ? null : '/login';
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LogIn.withCubit(),
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
      builder: (context, state, child) => ProfileSession.withCubit(
        child: BottomNavigation(location: state.uri.path, child: child),
      ),
      routes: [
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const Profile(),
        ),
        GoRoute(
          path: '/edit_profile',
          name: 'edit_profile',
          builder: (context, state) => const EditProfile(),
        ),

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
          redirect: (context, state) =>
              state.extra is DoctorType ? null : '/specialties',
          builder: (context, state) =>
              DocBySpecialty(doctorType: state.extra as DoctorType).withCubit(),
        ),
        GoRoute(
          path: '/doctors',
          name: 'doctors',
          builder: (context, state) => Doctors.withCubit(),
        ),
        GoRoute(
          path: '/doctors_info',
          name: 'doctors_info',
          redirect: (context, state) =>
              state.extra is Doctor ? null : '/doctors',
          builder: (context, state) =>
              DoctorsInfo(doctor: state.extra as Doctor),
        ),
        GoRoute(
          path: '/schedule',
          name: 'schedule',
          redirect: (context, state) =>
              state.extra is Doctor ? null : '/doctors',
          builder: (context, state) => Schedule(doctor: state.extra as Doctor),
        ),
        GoRoute(
          path: '/apointment',
          name: 'apointment',
          builder: (context, state) => const Appointment(),
        ),
        GoRoute(
          path: '/favorite_doctor',
          name: 'favorite_doctor',
          builder: (context, state) => const FavoriteDoctor(),
        ),
        GoRoute(
          path: '/filters',
          name: 'filters',
          builder: (context, state) => const Filters(),
        ),
        GoRoute(
          path: '/rewiev',
          name: 'rewiev',
          redirect: (context, state) =>
              state.extra is ReviewArgs ? null : '/apointment',
          builder: (context, state) {
            final args = state.extra as ReviewArgs;
            return Review(
              doctor: args.doctor,
              appointmentId: args.appointmentId,
            );
          },
        ),
        GoRoute(
          path: '/appointment_details',
          name: 'appointment_details',
          redirect: (context, state) =>
              state.extra is AppointmentDetailsArgs ? null : '/apointment',
          builder: (context, state) {
            final args = state.extra as AppointmentDetailsArgs;
            return AppointmentDetails(
              doctor: args.doctor,
              booking: args.booking,
            );
          },
        ),
      ],
    ),
  ],
);
