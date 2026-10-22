import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/presentation/schedule/appointment_calendar_controller.dart';

class Bookings implements AppointmentsRepository {
  final streams = <String, StreamController<Set<DateTime>>>{};
  @override
  Stream<Set<DateTime>> watchBookedTimes(String id) =>
      (streams[id] ??= StreamController<Set<DateTime>>.broadcast(
        sync: true,
      )).stream;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late Bookings repository;
  late AppointmentCalendarController controller;
  late DateTime now;
  final slot = DateTime(2026, 10, 22, 10);
  setUp(() {
    repository = Bookings();
    now = DateTime(2026, 10, 22, 8);
    controller = AppointmentCalendarController(repository, 'a', now: () => now);
  });
  tearDown(() async {
    controller.dispose();
    for (final stream in repository.streams.values) {
      await stream.close();
    }
  });
  test('Loading prevents selection; live booking invalidates selection', () {
    controller.selectTime(slot);
    expect(controller.selectedTime, isNull);
    repository.streams['a']!.add({});
    controller.selectTime(slot);
    expect(controller.selectedTime, slot);
    repository.streams['a']!.add({slot});
    expect(controller.selectedTime, isNull);
    expect(
      controller.slotsFor(slot).firstWhere((s) => s.start == slot).status,
      SlotStatus.booked,
    );
  });
  test('Error clears selection; retry recovers', () {
    repository.streams['a']!.add({});
    controller.selectTime(slot);
    repository.streams['a']!.addError(StateError('offline'));
    expect(controller.failed, isTrue);
    expect(controller.selectedTime, isNull);
    controller.retry();
    expect(controller.loading, isTrue);
    repository.streams['a']!.add({});
    expect(controller.failed, isFalse);
    expect(controller.loading, isFalse);
  });
  test('Switching doctors discards selection and old events', () {
    repository.streams['a']!.add({});
    controller.selectTime(slot);
    controller.changeDoctor('b');
    expect(controller.selectedTime, isNull);
    repository.streams['a']!.add({slot});
    expect(controller.loading, isTrue);
    repository.streams['b']!.add({});
    controller.selectTime(slot);
    expect(controller.selectedTime, slot);
  });
  test('Clock refresh clears elapsed time and rejects non-slots', () {
    repository.streams['a']!.add({});
    controller.selectTime(slot.add(const Duration(minutes: 1)));
    expect(controller.selectedTime, isNull);
    controller.selectTime(slot);
    now = slot;
    controller.refreshTime();
    expect(controller.selectedTime, isNull);
  });
}
