import 'package:freezed_annotation/freezed_annotation.dart';

import 'doctor_type.dart';
import '../app_enums.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.type,
    required this.specialization,
    required this.image,
    this.gender,
    this.yearsOfExperience,
    this.rating,
    this.reviewCount = 0,
    this.focus,
    this.profile,
    this.careerPath,
    this.highlights,
    this.clinicName,
    this.clinicAddress,
    this.phoneNumber,
    this.email,
    this.workingHoursDescription,
  });

  @JsonKey(includeToJson: false)
  final String id;

  final String name;
  final DoctorType type;
  final String specialization;
  final String image;
  final Gender? gender;
  final int? yearsOfExperience;
  final double? rating;
  final int reviewCount;
  final String? focus;
  final String? profile;
  final String? careerPath;
  final String? highlights;
  final String? clinicName;
  final String? clinicAddress;
  final String? phoneNumber;
  final String? email;
  final String? workingHoursDescription;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
