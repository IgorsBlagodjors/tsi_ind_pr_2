import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.photoUrl,
    this.favoriteDoctorIds = const {},
  });

  final String id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final Gender? gender;
  final String? photoUrl;

  @JsonKey(defaultValue: <String>{})
  final Set<String> favoriteDoctorIds;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
