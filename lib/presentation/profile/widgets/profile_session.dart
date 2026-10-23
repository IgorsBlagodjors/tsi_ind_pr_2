import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/domain/repositories/profile_repository.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';

import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';
import '../../shared/helpers/action_message.dart';

class ProfileSession extends StatelessWidget {
  const ProfileSession({super.key, required this.child});
  final Widget child;

  static Widget withCubit({required Widget child}) => BlocProvider(
    create: (context) => ProfileCubit(
      context.read<AuthRepository>(),
      context.read<ProfileRepository>(),
    )..start(),
    child: ProfileSession(child: child),
  );

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileCubit, ProfileState>(
    builder: (context, state) => switch (state) {
      ProfileLoaded() => child,
      ProfileLoading() => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      ProfileSignedOut() => Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () => context.goNamed('login'),
            child: const Text('Log in to continue'),
          ),
        ),
      ),
      ProfileError(:final message) => _ProfileErrorView(message: message),
    },
  );
}

class _ProfileErrorView extends StatelessWidget {
  const _ProfileErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, textAlign: TextAlign.center),
              TextButton(
                onPressed: () => context.read<ProfileCubit>().retry(),
                child: const Text('Retry'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await context.read<ProfileCubit>().signOut();
                    if (context.mounted) context.goNamed('login');
                  } catch (_) {
                    if (context.mounted) {
                      showActionMessage(
                        context,
                        'Unable to log out. Please try again.',
                      );
                    }
                  }
                },
                child: const Text('Log out'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
