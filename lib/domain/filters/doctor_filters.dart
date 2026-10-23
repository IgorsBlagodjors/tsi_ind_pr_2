import '../enums/app_enums.dart';
import '../models/doctors/doctor.dart';

class DoctorFilters {
  DoctorFilters({
    this.gender,
    this.minimumRating = 0,
    this.experience,
    Set<DoctorType>? types,
  }) : types = Set.unmodifiable(types ?? DoctorType.values.toSet());
  final Gender? gender;
  final int minimumRating;
  final AgeSelector? experience;
  final Set<DoctorType> types;
  bool matches(Doctor doctor) {
    if (!types.contains(doctor.type)) return false;
    if (gender != null && doctor.gender != gender) return false;
    if (minimumRating > 0 &&
        (doctor.rating == null || doctor.rating! < minimumRating)) {
      return false;
    }
    final years = doctor.yearsOfExperience;
    return switch (experience) {
      null => true,
      AgeSelector.first => years != null && years >= 1 && years <= 5,
      AgeSelector.seccont => years != null && years >= 6 && years <= 9,
      AgeSelector.third => years != null && years >= 10,
    };
  }
}
