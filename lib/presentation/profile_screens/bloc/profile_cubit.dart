import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/data/users/profile_repository.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._auth, this._profiles) : super(const ProfileLoading());

  final AuthRepository _auth;
  final ProfileRepository _profiles;
  StreamSubscription<AppUser?>? _authSubscription;
  StreamSubscription<AppUser?>? _profileSubscription;
  AppUser? _account;
  bool _started = false;
  int _generation = 0;

  void start() {
    if (_started || isClosed) return;
    _started = true;
    unawaited(_load(_auth.currentUser));
    _authSubscription = _auth.authStateChanges().listen(
      (account) {
        if (account?.id != _account?.id) unawaited(_load(account));
      },
      onError: (Object error) {
        unawaited(_authFailed(error));
      },
    );
  }

  bool _isCurrent(int generation) => !isClosed && generation == _generation;

  Future<void> _authFailed(Object error) async {
    ++_generation;
    final subscription = _profileSubscription;
    _profileSubscription = null;
    if (!isClosed) emit(ProfileError(profileErrorMessage(error)));
    await subscription?.cancel();
  }

  Future<void> _load(AppUser? account) async {
    if (isClosed) return;
    final generation = ++_generation;
    _account = account;
    final subscription = _profileSubscription;
    _profileSubscription = null;
    emit(account == null ? const ProfileSignedOut() : const ProfileLoading());
    await subscription?.cancel();
    if (!_isCurrent(generation) || account == null) return;

    try {
      await _profiles.ensureProfile(account);
      if (!_isCurrent(generation)) return;
      _profileSubscription = _profiles
          .watch(account.id)
          .listen(
            (user) {
              if (!_isCurrent(generation)) return;
              emit(
                user == null
                    ? ProfileError(profileErrorMessage(null))
                    : ProfileLoaded(user),
              );
            },
            onError: (Object error) {
              if (_isCurrent(generation)) {
                emit(ProfileError(profileErrorMessage(error)));
              }
            },
          );
    } catch (error) {
      if (_isCurrent(generation)) {
        emit(ProfileError(profileErrorMessage(error)));
      }
    }
  }

  Future<void> retry() => _load(_auth.currentUser);

  Future<void> signOut() async {
    await _auth.signOut();
    _profiles.pendingRegistration = null;
    await _load(null);
  }

  Future<void> toggleFavoriteDoctor(String doctorId) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;
    final user = currentState.user;
    await _profiles.toggleFavoriteDoctor(
      user.id,
      doctorId,
      user.favoriteDoctorIds.contains(doctorId),
    );
  }

  @override
  Future<void> close() async {
    ++_generation;
    final authSubscription = _authSubscription;
    final profileSubscription = _profileSubscription;
    _authSubscription = null;
    _profileSubscription = null;
    await super.close();
    await authSubscription?.cancel();
    await profileSubscription?.cancel();
  }
}
