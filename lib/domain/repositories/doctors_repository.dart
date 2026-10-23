import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/domain/models/doctors/doctor.dart';

abstract class DoctorsRepository {
  Stream<List<Doctor>> watchDoctors();
  Future<Doctor?> getDoctorById(String id);
  Stream<List<Doctor>> watchDoctorsByType(DoctorType type);
}
