import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/data/services/biometric_auth.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LogInPageState> {
  LoginCubit(this._repository, {BiometricAuth? biometrics})
    : _biometrics = biometrics ?? BiometricAuth(),
      super(const LogInPageState.initial());
  final AuthRepository _repository;
  final BiometricAuth _biometrics;
  bool _biometricPending = false;

  Future<void> logInWithBiometrics() async {
    if (isClosed || state is Loading) return;
    final userId = _repository.currentUser?.id;
    if (userId == null) {
      emit(const ErrorState('Log in with your email and password first.'));
      return;
    }
    emit(const Loading());
    _biometricPending = true;
    try {
      final authenticated = await _biometrics.authenticate();
      if (isClosed) return;
      if (!authenticated) {
        emit(const Initial());
        return;
      }
      // The account may change while the native biometric prompt is open.
      if (_repository.currentUser?.id != userId) {
        throw const AuthFailure(
          'Your session has changed. Please log in again.',
        );
      }
      await _repository.refreshSession();
      if (isClosed) return;
      // Refreshing credentials is asynchronous, so check the account again.
      if (_repository.currentUser?.id != userId) {
        throw const AuthFailure(
          'Your session has changed. Please log in again.',
        );
      }
      emit(const Loaded());
    } on AuthFailure catch (error) {
      if (!isClosed) emit(ErrorState(error.message));
    } catch (_) {
      if (!isClosed) {
        emit(
          const ErrorState('Unable to verify biometrics. Use your password.'),
        );
      }
    } finally {
      _biometricPending = false;
    }
  }

  @override
  Future<void> close() async {
    final pending = _biometricPending;
    await super.close();
    if (pending) {
      try {
        await _biometrics.cancel();
      } catch (_) {
        // The platform may already have dismissed the prompt.
      }
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    if (isClosed || state is Loading) return;
    emit(const Loading());
    try {
      await _repository.logIn(email: email.trim(), password: password);
      if (!isClosed) emit(const Loaded());
    } on AuthFailure catch (error) {
      if (!isClosed) emit(ErrorState(error.message));
    } catch (_) {
      if (!isClosed) {
        emit(ErrorState('Unable to log in. Please try again.'));
      }
    }
  }
}
