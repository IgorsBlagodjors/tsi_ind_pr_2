import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/data/appointments/firebase_appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/doctors/firebase_doctors_repository.dart';
import 'package:tsi_ind_pr_2/data/repositories.dart';
import 'package:tsi_ind_pr_2/data/reviews/firebase_reviews_repository.dart';
import 'package:tsi_ind_pr_2/data/users/firebase_auth_repository.dart';
import 'package:tsi_ind_pr_2/data/users/firebase_profile_repository.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
    providers: [
      RepositoryProvider<ProfileRepository>(
        create: (_) => FirebaseProfileRepository(),
      ),
      RepositoryProvider<AuthRepository>(
        create: (context) => FirebaseAuthRepository(
          FirebaseAuth.instance,
          context.read<ProfileRepository>(),
        ),
      ),
      RepositoryProvider<DoctorsRepository>(
        create: (_) => FirebaseDoctorsRepository(),
      ),
      RepositoryProvider<AppointmentsRepository>(
        create: (_) => FirebaseAppointmentsRepository(),
      ),
      RepositoryProvider<ReviewsRepository>(
        create: (_) => FirebaseReviewsRepository(),
      ),
    ],
    child: child,
  );
}
