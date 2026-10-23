import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/domain/models/appointments/appointment_booking.dart';
import 'package:tsi_ind_pr_2/domain/repositories/appointments_repository.dart';
import 'package:tsi_ind_pr_2/domain/models/appointments/patient_details.dart';
import 'package:tsi_ind_pr_2/domain/models/users/app_user.dart';
import 'package:tsi_ind_pr_2/presentation/schedule/bloc/schedule_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/schedule/bloc/schedule_state.dart';

import '../../helpers/profile_auth.dart';

class BookingRepository extends AppointmentsRepository {
  int calls = 0;
  PatientDetails? patient;
  Completer<String>? pending;
  Object? error;

  @override
  Future<String> book({
    required String userId,
    required String doctorId,
    required DateTime startsAt,
    required PatientDetails patient,
  }) async {
    calls++;
    this.patient = patient;
    if (error != null) throw error!;
    return pending == null ? 'booking' : pending!.future;
  }

  @override
  Stream<List<AppointmentBooking>> watchForUser(String userId) =>
      const Stream.empty();
  @override
  Stream<Set<DateTime>> watchBookedTimes(String doctorId) =>
      const Stream.empty();
  @override
  Future<void> changeStatus({
    required String userId,
    required String appointmentId,
    required AppointmentStatus status,
  }) async {}
}

void main() {
  late BookingRepository repository;
  late ProfileAuth auth;
  late ScheduleCubit cubit;
  setUp(() {
    repository = BookingRepository();
    auth = ProfileAuth(
      const AppUser(id: 'user', fullName: 'User', email: 'u@example.com'),
    );
    cubit = ScheduleCubit(repository, auth, doctorId: 'doctor');
  });
  tearDown(() async {
    if (!cubit.isClosed) await cubit.close();
    await auth.changes.close();
  });

  void selectTimeAndGender() {
    cubit.selectTime(DateTime.now().add(const Duration(days: 1)));
    cubit.selectGender(Gender.other);
  }

  test('Prefills profile once and resets patient details when switching', () {
    final now = DateTime.now();
    final profile = AppUser(
      id: 'user',
      fullName: 'User',
      email: 'u@example.com',
      dateOfBirth: DateTime(now.year - 30, now.month, now.day),
      gender: Gender.female,
    );
    cubit.updateProfile(profile);
    expect(cubit.state.patientName, 'User');
    expect(cubit.state.patientAge, '30');
    final revision = cubit.state.formRevision;
    cubit.updateProfile(profile);
    expect(cubit.state.formRevision, revision);
    cubit.selectPatient(false);
    expect(cubit.state.patientName, isEmpty);
    expect(cubit.state.patientAge, isEmpty);
    expect(cubit.state.gender, isNull);
    cubit.selectPatient(true);
    expect(cubit.state.gender, Gender.female);
    expect(cubit.state.patientName, 'User');
  });

  test('Late profile does not overwrite another person', () {
    cubit.selectPatient(false);
    cubit.updateProfile(auth.currentUser);
    expect(cubit.state.patientName, isEmpty);
    cubit.selectPatient(true);
    expect(cubit.state.patientName, 'User');
  });

  test('Validation and cleared time prevent repository writes', () async {
    selectTimeAndGender();
    await cubit.confirm(name: ' ', age: '30', problem: '');
    expect(cubit.state.message, 'Enter the patient name');
    cubit.selectTime(null);
    await cubit.confirm(name: 'Patient', age: '30', problem: '');
    expect(cubit.state.status, ScheduleStatus.failure);
    expect(repository.calls, 0);
  });

  test('Submits trimmed details once while saving', () async {
    cubit.selectPatient(false);
    selectTimeAndGender();
    repository.pending = Completer<String>();
    final first = cubit.confirm(
      name: ' Patient ',
      age: ' 30 ',
      problem: ' Pain ',
    );
    expect(cubit.state.status, ScheduleStatus.saving);
    await cubit.confirm(name: 'Duplicate', age: '30', problem: '');
    expect(repository.calls, 1);
    expect(repository.patient!.fullName, 'Patient');
    expect(repository.patient!.problem, 'Pain');
    expect(repository.patient!.isAccountOwner, isFalse);
    repository.pending!.complete('booking');
    await first;
    expect(cubit.state.status, ScheduleStatus.success);
  });

  test('Booking errors allow retry', () async {
    selectTimeAndGender();
    repository.error = const BookingFailure('Time is taken');
    await cubit.confirm(name: 'Patient', age: '30', problem: '');
    expect(cubit.state.message, 'Time is taken');
    repository.error = null;
    await cubit.confirm(name: 'Patient', age: '30', problem: '');
    expect(cubit.state.status, ScheduleStatus.success);
  });

  test('Freezed copyWith preserves and explicitly clears nullable values', () {
    final time = DateTime(2030);
    final state = ScheduleState(
      gender: Gender.female,
      selectedTime: time,
      message: 'Error',
    );
    expect(state.copyWith(), state);
    final cleared = state.copyWith(
      gender: null,
      selectedTime: null,
      message: null,
    );
    expect(cleared.gender, isNull);
    expect(cleared.selectedTime, isNull);
    expect(cleared.message, isNull);
  });

  test('Repeated invalid submissions emit feedback each time', () async {
    final states = <ScheduleState>[];
    final subscription = cubit.stream.listen(states.add);
    await cubit.confirm(name: '', age: '', problem: '');
    await cubit.confirm(name: '', age: '', problem: '');
    await Future<void>.delayed(Duration.zero);
    expect(
      states.where((state) => state.status == ScheduleStatus.failure),
      hasLength(2),
    );
    await subscription.cancel();
  });
  test('Completing booking after closing does not emit', () async {
    selectTimeAndGender();
    repository.pending = Completer<String>();
    final submission = cubit.confirm(name: 'Patient', age: '30', problem: '');
    await cubit.close();
    repository.pending!.complete('booking');
    await expectLater(submission, completes);
  });
}
