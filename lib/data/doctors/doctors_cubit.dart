import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_state.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit(this._doctorRep) : super(const Loading());

  final DoctorsRepository _doctorRep;
  StreamSubscription<List<Doctor>>? _subscription;

  void load({DoctorType? type}) {
    if (isClosed || _subscription != null) return;
    emit(const Loading());
    final stream = type == null
        ? _doctorRep.watchDoctors()
        : _doctorRep.watchDoctorsByType(type);
    _subscription = stream.listen(
      (doctors) {
        if (isClosed) return;

        if (doctors.isEmpty) {
          emit(const EmptyState());
        } else {
          emit(Loaded(doctors));
        }
      },
      onError: (Object error) {
        if (!isClosed) {
          emit(const ErrorState('Loading Error'));
        }
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
