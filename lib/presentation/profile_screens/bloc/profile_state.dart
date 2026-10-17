import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';

part 'profile_state.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.signedOut() = ProfileSignedOut;
  const factory ProfileState.loaded(AppUser user) = ProfileLoaded;
  const factory ProfileState.error(String message) = ProfileError;
}
