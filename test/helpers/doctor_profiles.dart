import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/domain/models/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/domain/models/users/app_user.dart';
import 'package:tsi_ind_pr_2/domain/repositories/doctors_repository.dart';
import 'package:tsi_ind_pr_2/data/repositories/firebase_profile_repository.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_state.dart';

import 'profile_auth.dart';

class TestDoctorsRepository implements DoctorsRepository {
  final doctors = [
    const Doctor(
      id: 'a',
      name: 'Alice',
      gender: Gender.female,
      rating: 4.5,
      yearsOfExperience: 10,
      type: DoctorType.cardiology,
      specialization: 'Heart specialist',
      image: '',
    ),
    const Doctor(
      id: 'b',
      name: 'Bob',
      gender: Gender.male,
      rating: 3,
      yearsOfExperience: 5,
      type: DoctorType.gynecology,
      specialization: 'Gynecologist',
      image: '',
    ),
    const Doctor(
      id: 'c',
      name: 'Clara',
      gender: Gender.female,
      rating: 5,
      yearsOfExperience: 6,
      type: DoctorType.cardiology,
      specialization: 'Cardiologist',
      image: '',
    ),
  ];
  @override
  Stream<List<Doctor>> watchDoctors() => Stream.value(doctors);
  @override
  Stream<List<Doctor>> watchDoctorsByType(DoctorType type) =>
      Stream.value(doctors.where((doctor) => doctor.type == type).toList());
  @override
  Future<Doctor?> getDoctorById(String id) async => null;
}

class EditableProfile extends ProfileCubit {
  EditableProfile(ProfileAuth auth) : super(auth, FirebaseProfileRepository());
  void show(String id, Set<String> favorites, {String name = 'User'}) => emit(
    ProfileLoaded(
      AppUser(
        id: id,
        fullName: name,
        email: 'u@example.com',
        favoriteDoctorIds: favorites,
      ),
    ),
  );
}
