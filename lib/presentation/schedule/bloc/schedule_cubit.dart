import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/domain/repositories/appointments_repository.dart';
import 'package:tsi_ind_pr_2/domain/models/appointments/patient_details.dart';
import 'package:tsi_ind_pr_2/domain/models/users/app_user.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';

import 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this._appointments, this._auth, {required this.doctorId})
    : super(const ScheduleState());

  final AppointmentsRepository _appointments;
  final AuthRepository _auth;
  final String doctorId;
  AppUser? _profile;
  bool _profileFilled = false;

  void updateProfile(AppUser? profile) {
    _profile = profile;
    // Later profile snapshots must not overwrite patient details being edited.
    if (profile != null && !_profileFilled && state.isAccountOwner) {
      _fillPatient(true);
    }
  }

  void selectPatient(bool yourself) {
    if (state.status == ScheduleStatus.saving) return;
    _fillPatient(yourself);
  }

  void _fillPatient(bool yourself) {
    final profile = yourself ? _profile : null;
    if (profile != null) _profileFilled = true;
    final birth = profile?.dateOfBirth;
    int? age;
    if (birth != null) {
      final now = DateTime.now();
      age = now.year - birth.year;
      if (now.month < birth.month ||
          (now.month == birth.month && now.day < birth.day)) {
        age--;
      }
      if (age < 0 || age > 120) age = null;
    }
    emit(
      state.copyWith(
        isAccountOwner: yourself,
        patientName: profile?.fullName ?? '',
        patientAge: age?.toString() ?? '',
        gender: profile?.gender,
        message: null,
        formRevision: state.formRevision + 1,
      ),
    );
  }

  void selectGender(Gender gender) {
    if (state.status == ScheduleStatus.saving) return;
    emit(state.copyWith(gender: gender, message: null));
  }

  void selectTime(DateTime? time) {
    emit(state.copyWith(selectedTime: time, message: null));
  }

  Future<void> confirm({
    required String name,
    required String age,
    required String problem,
  }) async {
    if (isClosed ||
        state.status == ScheduleStatus.saving ||
        state.status == ScheduleStatus.success) {
      return;
    }
    // Reset feedback so repeated invalid submissions still notify the view.
    emit(state.copyWith(status: ScheduleStatus.initial, message: null));
    final user = _auth.currentUser;
    final time = state.selectedTime;
    final patientAge = int.tryParse(age.trim());
    final gender = state.gender;
    final patientName = name.trim();
    String? error;
    if (user == null || time == null) {
      error = 'Choose a time and enter the patient name, age and gender';
    } else if (patientAge == null) {
      error = 'Enter the patient age';
    } else if (gender == null) {
      error = 'Select the patient gender';
    } else if (patientName.isEmpty) {
      error = 'Enter the patient name';
    }
    if (error != null) {
      emit(state.copyWith(status: ScheduleStatus.failure, message: error));
      return;
    }
    final patient = PatientDetails(
      fullName: patientName,
      age: patientAge!,
      gender: gender!,
      isAccountOwner: state.isAccountOwner,
      problem: problem.trim(),
    );
    emit(state.copyWith(status: ScheduleStatus.saving, message: null));
    try {
      await _appointments.book(
        userId: user!.id,
        doctorId: doctorId,
        startsAt: time!,
        patient: patient,
      );
      if (!isClosed) {
        emit(state.copyWith(status: ScheduleStatus.success, message: null));
      }
    } on BookingFailure catch (error) {
      if (!isClosed) {
        emit(
          state.copyWith(
            status: ScheduleStatus.failure,
            message: error.message,
          ),
        );
      }
    } catch (_) {
      if (!isClosed) {
        emit(
          state.copyWith(
            status: ScheduleStatus.failure,
            message: 'Could not save. Check your connection and try again.',
          ),
        );
      }
    }
  }
}
