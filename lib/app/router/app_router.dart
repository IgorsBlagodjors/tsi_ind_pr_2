import 'package:tsi_ind_pr_2/domain/filters/doctor_filters.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/pages/appointments_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';
import 'package:tsi_ind_pr_2/app/session/app_access.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/pages/appointment_details_page.dart';
import 'package:tsi_ind_pr_2/presentation/profile/widgets/profile_session.dart';
import 'package:tsi_ind_pr_2/domain/models/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/presentation/reviews/pages/review_page.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/create_account_page.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/log_in_page.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/set_password_page.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/pages/doctors_page.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/pages/doctor_details_page.dart';
import 'package:tsi_ind_pr_2/presentation/favorites/pages/favorite_doctors_page.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/pages/filters_page.dart';
import 'package:tsi_ind_pr_2/presentation/navigation/bottom_navigation.dart';
import 'package:tsi_ind_pr_2/presentation/home/pages/home_page.dart';
import 'package:tsi_ind_pr_2/presentation/profile/pages/edit_profile_page.dart';
import 'package:tsi_ind_pr_2/presentation/profile/pages/profile_page.dart';
import 'package:tsi_ind_pr_2/presentation/schedule/pages/schedule_page.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/pages/doctors_by_specialty_page.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/pages/specialties_page.dart';
import 'package:tsi_ind_pr_2/presentation/welcome/pages/welcome_page.dart';

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
              state.extra is DoctorType || state.extra is DocBySpecialtyArgs
              ? null
              : '/specialties',
          builder: (context, state) => DocBySpecialty(
            doctorType: state.extra is DocBySpecialtyArgs
                ? (state.extra as DocBySpecialtyArgs).type
                : state.extra as DoctorType,
            initialFilters: state.extra is DocBySpecialtyArgs
                ? (state.extra as DocBySpecialtyArgs).filters
                : null,
          ).withCubit(),
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
          builder: (context, state) => Filters(
            initialFilters: state.extra is DoctorFilters
                ? state.extra as DoctorFilters
                : null,
          ),
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
