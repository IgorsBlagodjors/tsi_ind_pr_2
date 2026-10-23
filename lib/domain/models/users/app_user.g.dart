// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String?,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  photoUrl: json['photoUrl'] as String?,
  favoriteDoctorIds:
      (json['favoriteDoctorIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet() ??
      {},
);

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'gender': _$GenderEnumMap[instance.gender],
  'photoUrl': instance.photoUrl,
  'favoriteDoctorIds': instance.favoriteDoctorIds.toList(),
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};
