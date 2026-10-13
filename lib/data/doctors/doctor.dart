import 'doctor_type.dart';
import '../gender.dart';

/// Doctor details. Availability and appointments are stored separately by doctorId.
class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.type,
    required this.specialization,
    required this.image,
    this.isFavorite = false,
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

  final String id;
  final String name;
  final DoctorType type;
  final String specialization;
  final String image;

  /// Initial demo state for the legacy favorites list.
  /// Use AppUser.favoriteDoctorIds for account-specific favorites.
  final bool isFavorite;

  final Gender? gender;
  final int? yearsOfExperience;

  /// Average rating from 0 to 5; null means there are no ratings yet.
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

  /// Display label, for example Mon–Sat / 9 AM–5 PM.
  /// Not used to determine appointment availability.
  final String? workingHoursDescription;

  factory Doctor.fromMap(String id, Map<String, dynamic> data) => Doctor(
    id: id,
    name: data['name'] as String,
    type: DoctorType.values.byName(data['type'] as String),
    specialization: data['specialization'] as String,
    image: data['image'] as String,
    gender: data['gender'] == null
        ? null
        : Gender.values.byName(data['gender'] as String),
    yearsOfExperience: (data['yearsOfExperience'] as num?)?.toInt(),
    rating: (data['rating'] as num?)?.toDouble(),
    reviewCount: (data['reviewCount'] as num?)?.toInt() ?? 0,
    focus: data['focus'] as String?,
    profile: data['profile'] as String?,
    careerPath: data['careerPath'] as String?,
    highlights: data['highlights'] as String?,
    clinicName: data['clinicName'] as String?,
    clinicAddress: data['clinicAddress'] as String?,
    phoneNumber: data['phoneNumber'] as String?,
    email: data['email'] as String?,
    workingHoursDescription: data['workingHoursDescription'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'name': name, 'type': type.name, 'specialization': specialization,
    'image': image,
    'gender': gender?.name,
    'yearsOfExperience': yearsOfExperience,
    'rating': rating, 'reviewCount': reviewCount,
    'focus': focus,
    'profile': profile,
    'careerPath': careerPath,
    'highlights': highlights,
    'clinicName': clinicName, 'clinicAddress': clinicAddress,
    'phoneNumber': phoneNumber, 'email': email,
    'workingHoursDescription': workingHoursDescription,
    // Exclude isFavorite: each user has their own favorites.
  };
}
