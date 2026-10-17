// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$DoctorTypeEnumMap, json['type']),
  specialization: json['specialization'] as String,
  image: json['image'] as String,
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  focus: json['focus'] as String?,
  profile: json['profile'] as String?,
  careerPath: json['careerPath'] as String?,
  highlights: json['highlights'] as String?,
  clinicName: json['clinicName'] as String?,
  clinicAddress: json['clinicAddress'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  email: json['email'] as String?,
  workingHoursDescription: json['workingHoursDescription'] as String?,
);

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
  'name': instance.name,
  'type': _$DoctorTypeEnumMap[instance.type]!,
  'specialization': instance.specialization,
  'image': instance.image,
  'gender': _$GenderEnumMap[instance.gender],
  'yearsOfExperience': instance.yearsOfExperience,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'focus': instance.focus,
  'profile': instance.profile,
  'careerPath': instance.careerPath,
  'highlights': instance.highlights,
  'clinicName': instance.clinicName,
  'clinicAddress': instance.clinicAddress,
  'phoneNumber': instance.phoneNumber,
  'email': instance.email,
  'workingHoursDescription': instance.workingHoursDescription,
};

const _$DoctorTypeEnumMap = {
  DoctorType.cardiology: 'cardiology',
  DoctorType.dermatology: 'dermatology',
  DoctorType.generalMedicine: 'generalMedicine',
  DoctorType.gynecology: 'gynecology',
  DoctorType.odontology: 'odontology',
  DoctorType.oncology: 'oncology',
  DoctorType.ophthalmology: 'ophthalmology',
  DoctorType.orthopedics: 'orthopedics',
  DoctorType.otolaryngology: 'otolaryngology',
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};
