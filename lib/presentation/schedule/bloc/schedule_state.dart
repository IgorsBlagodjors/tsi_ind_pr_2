import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';

part 'schedule_state.freezed.dart';

@freezed
sealed class ScheduleState with _$ScheduleState {
  const factory ScheduleState({
    @Default(true) bool isAccountOwner,
    // Prefill values; text editing controllers belong to the view.
    @Default('') String patientName,
    @Default('') String patientAge,
    Gender? gender,
    DateTime? selectedTime,
    @Default(ScheduleStatus.initial) ScheduleStatus status,
    String? message,
    @Default(0) int formRevision,
  }) = _ScheduleState;
}
