import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';

abstract class DoctorsRepository {
  Stream<List<Doctor>> watchDoctors();
  Future<Doctor?> getDoctorById(String id);
  Stream<List<Doctor>> watchDoctorsByType(DoctorType type);
}
