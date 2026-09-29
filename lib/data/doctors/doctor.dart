import 'doctor_type.dart';

/// A doctor in the local demo directory.
class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.type,
    required this.specialization,
    required this.image,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final DoctorType type;
  final String specialization;
  final String image;
  final bool isFavorite;
}
