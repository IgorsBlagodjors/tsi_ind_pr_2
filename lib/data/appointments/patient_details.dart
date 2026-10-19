import 'package:freezed_annotation/freezed_annotation.dart';

import '../app_enums.dart';

part 'patient_details.g.dart';

@JsonSerializable()
class PatientDetails {
  const PatientDetails({
    required this.fullName,
    required this.age,
    required this.gender,
    this.isAccountOwner = true,
    this.problem = '',
  });

  final String fullName;
  final int age;
  final Gender gender;
  final bool isAccountOwner;
  final String problem;

  factory PatientDetails.fromJson(Map<String, dynamic> json) =>
      _$PatientDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDetailsToJson(this);
}
