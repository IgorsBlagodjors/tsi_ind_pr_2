// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorSlot _$DoctorSlotFromJson(Map<String, dynamic> json) => DoctorSlot(
  id: json['id'] as String,
  doctorId: json['doctorId'] as String,
  startsAt: readTimestamp(json['startsAt']),
  endsAt: readTimestamp(json['endsAt']),
  status:
      $enumDecodeNullable(_$DoctorSlotStatusEnumMap, json['status']) ??
      DoctorSlotStatus.available,
);

Map<String, dynamic> _$DoctorSlotToJson(DoctorSlot instance) =>
    <String, dynamic>{
      'doctorId': instance.doctorId,
      'startsAt': writeTimestamp(instance.startsAt),
      'endsAt': writeTimestamp(instance.endsAt),
      'status': _$DoctorSlotStatusEnumMap[instance.status]!,
    };

const _$DoctorSlotStatusEnumMap = {
  DoctorSlotStatus.available: 'available',
  DoctorSlotStatus.booked: 'booked',
  DoctorSlotStatus.blocked: 'blocked',
};
