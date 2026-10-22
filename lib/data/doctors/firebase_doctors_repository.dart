import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';

class FirebaseDoctorsRepository implements DoctorsRepository {
  FirebaseDoctorsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  @override
  Stream<List<Doctor>> watchDoctors() {
    return _firestore
        .collection('doctors')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Doctor.fromJson({...doc.data(), 'id': doc.id}))
              .toList(),
        );
  }

  @override
  Future<Doctor?> getDoctorById(String id) async {
    final doc = await _firestore.collection('doctors').doc(id).get();
    final data = doc.data();

    if (data == null) return null;

    return Doctor.fromJson({...data, 'id': doc.id});
  }

  @override
  Stream<List<Doctor>> watchDoctorsByType(DoctorType type) {
    return _firestore
        .collection('doctors')
        .where('type', isEqualTo: type.name)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Doctor.fromJson({...doc.data(), 'id': doc.id}))
              .toList(),
        );
  }
}
