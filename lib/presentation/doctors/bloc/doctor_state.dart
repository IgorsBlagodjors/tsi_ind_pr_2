import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsi_ind_pr_2/domain/models/doctors/doctor.dart';

part 'doctor_state.freezed.dart';

@freezed
sealed class DoctorsState with _$DoctorsState {
  const factory DoctorsState.loading() = Loading;
  const factory DoctorsState.empty() = EmptyState;
  const factory DoctorsState.loaded(List<Doctor> doctors) = Loaded;
  const factory DoctorsState.error(String message) = ErrorState;
}
