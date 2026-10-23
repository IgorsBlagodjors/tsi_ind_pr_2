// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientDetails _$PatientDetailsFromJson(Map<String, dynamic> json) =>
    PatientDetails(
      fullName: json['fullName'] as String,
      age: (json['age'] as num).toInt(),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      isAccountOwner: json['isAccountOwner'] as bool? ?? true,
      problem: json['problem'] as String? ?? '',
    );

Map<String, dynamic> _$PatientDetailsToJson(PatientDetails instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'age': instance.age,
      'gender': _$GenderEnumMap[instance.gender]!,
      'isAccountOwner': instance.isAccountOwner,
      'problem': instance.problem,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};
