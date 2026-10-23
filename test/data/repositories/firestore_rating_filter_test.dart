import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/domain/filters/doctor_filters.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/bloc/doctors_cubit.dart';
import 'package:tsi_ind_pr_2/data/repositories/firebase_doctors_repository.dart';

void main() {
  test(
    'Firestore integer rating with zero reviews passes three-star filter',
    () async {
      final db = FakeFirebaseFirestore();
      await db.collection('doctors').doc('david-smith').set({
        'name': 'Dr. David Smith',
        'type': 'oncology',
        'specialization': 'Medical Oncologist',
        'image': '',
        'gender': 'male',
        'yearsOfExperience': 12,
        'rating': 3,
        'reviewCount': 0,
      });
      final repository = FirebaseDoctorsRepository(firestore: db);
      final cubit = DoctorsCubit(repository);
      addTearDown(cubit.close);
      final doctors = await repository.watchDoctors().first;
      expect(doctors.single.rating, 3.0);
      for (final stars in [1, 2, 3, 4, 5]) {
        final result = cubit.filterAndSortDoctors(
          doctors: doctors,
          selectedTypes: DoctorType.values.toSet(),
          sortOrder: SortOrder.ascending,
          search: '',
          filters: DoctorFilters(minimumRating: stars),
        );
        expect(
          result.map((doctor) => doctor.id),
          stars <= 3 ? ['david-smith'] : isEmpty,
        );
      }
    },
  );
}
