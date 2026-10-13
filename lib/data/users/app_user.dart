import '../gender.dart';
import '../firestore_dates.dart';

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

  final Set<String> favoriteDoctorIds;

  factory AppUser.fromMap(String id, Map<String, dynamic> data) => AppUser(
    id: id,
    fullName: data['fullName'] as String,
    email: data['email'] as String,
    phoneNumber: data['phoneNumber'] as String?,
    dateOfBirth: data['dateOfBirth'] == null
        ? null
        : DateTime.parse(data['dateOfBirth'] as String),
    gender: data['gender'] == null
        ? null
        : Gender.values.byName(data['gender'] as String),
    photoUrl: data['photoUrl'] as String?,
    favoriteDoctorIds: Set<String>.from(
      data['favoriteDoctorIds'] as List? ?? const [],
    ),
  );

  Map<String, dynamic> toMap() => {
    'fullName': fullName,
    'email': email,
    'phoneNumber': phoneNumber,
    'dateOfBirth': dateOfBirth == null ? null : dateOnly(dateOfBirth!),
    'gender': gender?.name,
    'photoUrl': photoUrl,
    'favoriteDoctorIds': favoriteDoctorIds.toList(),
  };

  int? get age => ageOn(DateTime.now());
  int? ageOn(DateTime date) {
    final birth = dateOfBirth;
    if (birth == null) return null;
    var years = date.year - birth.year;
    if (date.month < birth.month ||
        (date.month == birth.month && date.day < birth.day)) {
      years--;
    }
    return years < 0 ? null : years;
  }
}
