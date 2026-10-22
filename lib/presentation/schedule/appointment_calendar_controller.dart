import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/schedule/weekly_availability.dart';

class AppointmentCalendarController extends ChangeNotifier {
  AppointmentCalendarController(
    this._repository,
    this._doctorId, {
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => refreshTime());
    retry();
  }
  final AppointmentsRepository _repository;
  final DateTime Function() _now;
  String _doctorId;
  late final Timer _timer;
  StreamSubscription<Set<DateTime>>? _subscription;
  Set<DateTime> _booked = {};
  bool _disposed = false;
  int _generation = 0;
  bool _loading = true;
  bool _failed = false;
  DateTime? _selectedTime;
  bool get loading => _loading;
  bool get failed => _failed;
  DateTime? get selectedTime => _selectedTime;

  void changeDoctor(String id) {
    if (_doctorId == id) return;
    _doctorId = id;
    retry();
  }

  void retry() {
    if (_disposed) return;
    final generation = ++_generation;
    _subscription?.cancel();
    _booked = {};
    _selectedTime = null;
    _loading = true;
    _failed = false;
    notifyListeners();
    void fail(Object error) {
      if (_disposed || generation != _generation) return;
      _loading = false;
      _failed = true;
      _selectedTime = null;
      notifyListeners();
    }

    try {
      _subscription = _repository.watchBookedTimes(_doctorId).listen((times) {
        if (_disposed || generation != _generation) return;
        _booked = Set.of(times);
        _loading = false;
        _failed = false;
        if (_booked.contains(_selectedTime)) _selectedTime = null;
        notifyListeners();
      }, onError: fail);
    } catch (error) {
      fail(error);
    }
  }

  List<AppointmentSlot> slotsFor(DateTime date) =>
      WeeklyAvailability(_doctorId)
          .slotsFor(date, now: _now())
          .map(
            (slot) => _booked.contains(slot.start)
                ? AppointmentSlot(slot.start, SlotStatus.booked)
                : slot,
          )
          .toList();

  void selectTime(DateTime? time) {
    if (time != null &&
        (_loading ||
            _failed ||
            !slotsFor(time).any(
              (slot) =>
                  slot.start == time && slot.status == SlotStatus.available,
            ))) {
      return;
    }
    if (_selectedTime == time) return;
    _selectedTime = time;
    notifyListeners();
  }

  void refreshTime() {
    if (_disposed) return;
    if (_selectedTime != null && !_selectedTime!.isAfter(_now())) {
      _selectedTime = null;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    ++_generation;
    _timer.cancel();
    _subscription?.cancel();
    super.dispose();
  }
}
