import 'dart:async';

import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/data/users/biometric_auth.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/bloc/login_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/bloc/login_state.dart';

class ControlledAuthRepository implements AuthRepository {
  @override
  Future<RegistrationResult> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    DateTime? dateOfBirth,
  }) async => throw UnimplementedError();
  @override
  AppUser? currentUser;
  int refreshCalls = 0;
  bool refreshFails = false;
  @override
  Future<void> refreshSession() async {
    refreshCalls++;
    if (refreshFails) throw const AuthFailure('Session expired.');
  }

  @override
  Stream<AppUser?> authStateChanges() => const Stream.empty();
  @override
  Future<void> signOut() async {}
  Completer<void> request = Completer<void>();
  int calls = 0;
  String? email;
  String? password;

  @override
  Future<void> logIn({required String email, required String password}) {
    calls++;
    this.email = email;
    this.password = password;
    return request.future;
  }
}

class ControlledBiometrics extends BiometricAuth {
  final result = Completer<bool>();
  int calls = 0;
  bool canceled = false;

  @override
  Future<bool> authenticate() {
    calls++;
    return result.future;
  }

  @override
  Future<void> cancel() async {
    canceled = true;
  }
}

void main() {
  late ControlledAuthRepository repository;
  late LoginCubit cubit;

  setUp(() {
    repository = ControlledAuthRepository();
    cubit = LoginCubit(repository);
  });
  tearDown(() => cubit.close());

  group('Biometric login', () {
    late ControlledBiometrics biometrics;
    const user = AppUser(
      id: 'saved-user',
      fullName: 'User',
      email: 'user@example.com',
    );

    setUp(() async {
      await cubit.close();
      biometrics = ControlledBiometrics();
      cubit = LoginCubit(repository, biometrics: biometrics);
    });

    test('requires a saved session before requesting biometrics', () async {
      await cubit.logInWithBiometrics();
      expect(cubit.state, isA<ErrorState>());
      expect(biometrics.calls, 0);
    });

    test(
      'success refreshes the saved session and ignores duplicate requests',
      () async {
        repository.currentUser = user;
        final pending = cubit.logInWithBiometrics();
        await cubit.logInWithBiometrics();
        await cubit.logIn(email: 'other@example.com', password: 'password');
        expect(biometrics.calls, 1);
        expect(repository.calls, 0);
        expect(cubit.state, isA<Loading>());
        biometrics.result.complete(true);
        await pending;
        expect(repository.refreshCalls, 1);
        expect(cubit.state, isA<Loaded>());
      },
    );

    test(
      'cancel leaves the user on login without refreshing credentials',
      () async {
        repository.currentUser = user;
        final pending = cubit.logInWithBiometrics();
        biometrics.result.complete(false);
        await pending;
        expect(cubit.state, isA<Initial>());
        expect(repository.refreshCalls, 0);
      },
    );

    test(
      'signing out while the prompt is open cannot unlock the app',
      () async {
        repository.currentUser = user;
        final pending = cubit.logInWithBiometrics();
        repository.currentUser = null;
        biometrics.result.complete(true);
        await pending;
        expect(cubit.state, isA<ErrorState>());
        expect(repository.refreshCalls, 0);
      },
    );

    test(
      'expired session cannot unlock after a successful biometric check',
      () async {
        repository.currentUser = user;
        repository.refreshFails = true;
        final pending = cubit.logInWithBiometrics();
        biometrics.result.complete(true);
        await pending;
        expect(cubit.state, isA<ErrorState>());
      },
    );

    test('lockout is shown and password login remains available', () async {
      repository.currentUser = user;
      final pending = cubit.logInWithBiometrics();
      biometrics.result.completeError(
        const AuthFailure('Biometrics are locked.'),
      );
      await pending;
      expect((cubit.state as ErrorState).message, 'Biometrics are locked.');
      final passwordLogin = cubit.logIn(
        email: 'user@example.com',
        password: 'password',
      );
      repository.request.complete();
      await passwordLogin;
      expect(cubit.state, isA<Loaded>());
    });

    test(
      'leaving login cancels the prompt and ignores its late result',
      () async {
        repository.currentUser = user;
        final pending = cubit.logInWithBiometrics();
        await cubit.close();
        expect(biometrics.canceled, isTrue);
        biometrics.result.complete(true);
        await pending;
        expect(repository.refreshCalls, 0);
      },
    );
  });

  test(
    'Loading waits for authentication and ignores repeated submissions',
    () async {
      final request = cubit.logIn(
        email: ' user@example.com ',
        password: ' secret ',
      );
      expect(cubit.state, isA<Loading>());
      await cubit.logIn(email: 'other@example.com', password: 'other');
      expect(repository.calls, 1);
      expect(repository.email, 'user@example.com');
      expect(repository.password, ' secret ');
      repository.request.complete();
      await request;
      expect(cubit.state, isA<Loaded>());
    },
  );

  test(
    'Authentication failure can be followed by a successful retry',
    () async {
      final request = cubit.logIn(email: 'user@example.com', password: 'wrong');
      repository.request.completeError(
        const AuthFailure('Incorrect email or password.'),
      );
      await request;
      expect(
        (cubit.state as ErrorState).message,
        'Incorrect email or password.',
      );
      repository.request = Completer<void>();
      final retry = cubit.logIn(email: 'user@example.com', password: 'correct');
      repository.request.complete();
      await retry;
      expect(cubit.state, isA<Loaded>());
      expect(repository.calls, 2);
    },
  );

  test('Unknown errors produce a safe message', () async {
    final request = cubit.logIn(email: 'user@example.com', password: 'secret');
    repository.request.completeError(StateError('Internal details'));
    await request;
    expect(
      (cubit.state as ErrorState).message,
      'Unable to log in. Please try again.',
    );
  });

  test(
    'Leaving the screen before completion does not emit after close',
    () async {
      final request = cubit.logIn(
        email: 'user@example.com',
        password: 'secret',
      );
      await cubit.close();
      repository.request.complete();
      await expectLater(request, completes);
    },
  );
}
