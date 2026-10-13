import 'package:tsi_ind_pr_2/data/users/app_user.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileSignedOut extends ProfileState {
  const ProfileSignedOut();
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.user);
  final AppUser user;
}

final class ProfileError extends ProfileState {
  const ProfileError(this.message);
  final String message;
}
