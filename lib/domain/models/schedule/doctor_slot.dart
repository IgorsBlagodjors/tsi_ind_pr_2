import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/core/serialization/firestore_dates.dart';

part 'doctor_slot.g.dart';

@JsonSerializable()
class DoctorSlot {
  const DoctorSlot({
    required this.id,
    required this.doctorId,
    required this.startsAt,
    required this.endsAt,
    this.status = DoctorSlotStatus.available,
  });

  @JsonKey(includeToJson: false)
  final String id;

  final String doctorId;

  @JsonKey(fromJson: readTimestamp, toJson: writeTimestamp)
  final DateTime startsAt;

  @JsonKey(fromJson: readTimestamp, toJson: writeTimestamp)
  final DateTime endsAt;

  final DoctorSlotStatus status;

  bool isAvailableAt(DateTime now) =>
      status == DoctorSlotStatus.available && startsAt.isAfter(now);

  factory DoctorSlot.fromJson(Map<String, dynamic> json) =>
      _$DoctorSlotFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorSlotToJson(this);
}
