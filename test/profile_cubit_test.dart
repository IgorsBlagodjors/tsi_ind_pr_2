import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/data/users/profile_repository.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_state.dart';

import 'helpers/profile_auth.dart';

class ControlledProfiles extends ProfileRepository {
  final streams = <String, StreamController<AppUser?>>{};
  final pending = <String, Completer<void>>{};
  int watches = 0;
  Object? ensureError;

  StreamController<AppUser?> events(String uid) => streams.putIfAbsent(
    uid,
    () => StreamController<AppUser?>.broadcast(sync: true),
  );

  @override
  Future<void> ensureProfile(AppUser fallback) async {
    if (ensureError != null) throw ensureError!;
    await pending[fallback.id]?.future;
  }

  @override
  Stream<AppUser?> watch(String uid) {
    watches++;
    return events(uid).stream;
  }

  Future<void> dispose() async {
    for (final controller in streams.values) {
      await controller.close();
    }
  }
}

void main() {
  const first = AppUser(id: 'one', fullName: 'First', email: 'one@example.com');
  const second = AppUser(
    id: 'two',
    fullName: 'Second',
    email: 'two@example.com',
  );
  late ProfileAuth auth;
  late ControlledProfiles profiles;
  late ProfileCubit cubit;

  Future<void> flush() => Future<void>.delayed(Duration.zero);

  setUp(() {
    auth = ProfileAuth(first);
    profiles = ControlledProfiles();
    cubit = ProfileCubit(auth, profiles);
  });

  tearDown(() async {
    if (!cubit.isClosed) await cubit.close();
    await auth.changes.close();
    await profiles.dispose();
  });

  test(
    'One subscription receives live profile changes and signs out',
    () async {
      cubit.start();
      cubit.start();
      auth.setUser(first);
      await flush();
      expect(profiles.watches, 1);
      profiles.events(first.id).add(first);
      expect((cubit.state as ProfileLoaded).user.fullName, 'First');
      profiles
          .events(first.id)
          .add(
            const AppUser(
              id: 'one',
              fullName: 'Updated',
              email: 'one@example.com',
            ),
          );
      expect((cubit.state as ProfileLoaded).user.fullName, 'Updated');

      profiles.pendingRegistration = first;
      await cubit.signOut();
      expect(cubit.state, isA<ProfileSignedOut>());
      expect(profiles.events(first.id).hasListener, isFalse);
      expect(profiles.pendingRegistration, isNull);
    },
  );

  test('Switching account drops old profile and cancels its stream', () async {
    cubit.start();
    await flush();
    profiles.events(first.id).add(first);
    auth.setUser(second);
    expect(cubit.state, isA<ProfileLoading>());
    await flush();
    expect(profiles.events(first.id).hasListener, isFalse);
    profiles.events(first.id).add(first);
    profiles.events(second.id).add(second);
    expect((cubit.state as ProfileLoaded).user.id, second.id);
  });

  test('Slow preparation cannot restore the previous account', () async {
    final delayed = Completer<void>();
    profiles.pending[first.id] = delayed;
    cubit.start();
    await flush();
    auth.setUser(second);
    await flush();
    profiles.events(second.id).add(second);
    delayed.complete();
    await flush();
    expect(profiles.watches, 1);
    expect((cubit.state as ProfileLoaded).user.id, second.id);
  });

  test('Preparation and stream errors can be retried', () async {
    profiles.ensureError = StateError('offline');
    cubit.start();
    await flush();
    expect(cubit.state, isA<ProfileError>());
    profiles.ensureError = null;
    await cubit.retry();
    profiles.events(first.id).add(first);
    expect(cubit.state, isA<ProfileLoaded>());
    profiles.events(first.id).addError(StateError('connection lost'));
    expect(cubit.state, isA<ProfileError>());
    await cubit.retry();
    profiles.events(first.id).add(first);
    expect(cubit.state, isA<ProfileLoaded>());
    profiles.events(first.id).add(null);
    expect(cubit.state, isA<ProfileError>());
  });

  test('Close cancels both subscriptions', () async {
    cubit.start();
    await flush();
    await cubit.close();
    expect(auth.changes.hasListener, isFalse);
    expect(profiles.events(first.id).hasListener, isFalse);
  });

  test(
    'Close during preparation never starts a profile subscription',
    () async {
      final delayed = Completer<void>();
      profiles.pending[first.id] = delayed;
      cubit.start();
      await flush();
      await cubit.close();
      delayed.complete();
      await flush();
      expect(profiles.watches, 0);
    },
  );

  test('Signed-out session can receive a subsequent login', () async {
    auth.currentUser = null;
    cubit.start();
    expect(cubit.state, isA<ProfileSignedOut>());
    auth.setUser(first);
    await flush();
    profiles.events(first.id).add(first);
    expect(cubit.state, isA<ProfileLoaded>());
  });
}
