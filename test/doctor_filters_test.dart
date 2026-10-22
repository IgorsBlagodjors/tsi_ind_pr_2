import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_filters.dart';

void main() {
  Doctor doctor({int? years, double? rating, Gender? gender}) => Doctor(
    id: '1',
    name: 'Test',
    type: DoctorType.cardiology,
    specialization: '',
    image: '',
    yearsOfExperience: years,
    rating: rating,
    gender: gender,
  );
  test('Defaults include doctors with missing optional data', () {
    expect(DoctorFilters().matches(doctor()), isTrue);
    expect(DoctorFilters(minimumRating: 4).matches(doctor()), isFalse);
    expect(DoctorFilters(gender: Gender.female).matches(doctor()), isFalse);
    expect(
      DoctorFilters(experience: AgeSelector.first).matches(doctor()),
      isFalse,
    );
    expect(DoctorFilters(types: {}).matches(doctor()), isFalse);
  });
  test('Experience ranges include their boundaries', () {
    for (final years in [0, 1, 5, 6, 9, 10, 30]) {
      expect(
        DoctorFilters(experience: AgeSelector.first)
            .matches(doctor(years: years)),
        years >= 1 && years <= 5,
      );
      expect(
        DoctorFilters(experience: AgeSelector.seccont)
            .matches(doctor(years: years)),
        years >= 6 && years <= 9,
      );
      expect(
        DoctorFilters(experience: AgeSelector.third)
            .matches(doctor(years: years)),
        years >= 10,
      );
    }
  });
  test('Minimum rating and gender combine', () {
    final filters = DoctorFilters(minimumRating: 4, gender: Gender.female);
    expect(filters.matches(doctor(rating: 4, gender: Gender.female)), isTrue);
    expect(
      filters.matches(doctor(rating: 3.9, gender: Gender.female)),
      isFalse,
    );
    expect(filters.matches(doctor(rating: 5, gender: Gender.male)), isFalse);
  });
}
