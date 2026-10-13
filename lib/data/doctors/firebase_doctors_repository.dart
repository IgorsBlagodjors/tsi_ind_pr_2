import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';

class FirebaseDoctorsRepository implements DoctorsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Stream<List<Doctor>> watchDoctors() {
    return _firestore
        .collection('doctors')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Doctor.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  @override
  Future<Doctor?> getDoctorById(String id) async {
    final doc = await _firestore.collection('doctors').doc(id).get();
    final data = doc.data();

    if (data == null) return null;

    return Doctor.fromMap(doc.id, data);
  }

  @override
  Stream<List<Doctor>> watchDoctorsByType(type) {
    return _firestore
        .collection('doctors')
        .where('type', isEqualTo: type.name)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Doctor.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }
}
