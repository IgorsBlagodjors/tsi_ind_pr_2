import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';

class AppointmentSlot {
  const AppointmentSlot(this.start, this.status);

  final DateTime start;
  final SlotStatus status;
}

/// Provides the course project's fixed timetable in the device's local time.
/// Live bookings are applied separately by the appointment calendar controller.
class WeeklyAvailability {
  const WeeklyAvailability(this.doctorId);

  final String doctorId;

  List<AppointmentSlot> slotsFor(DateTime date, {required DateTime now}) {
    if (date.weekday == DateTime.sunday) return const [];
    return List.generate(15, (index) {
      final start = DateTime(date.year, date.month, date.day, 9, index * 30);
      return AppointmentSlot(
        start,
        !start.isAfter(now) ? SlotStatus.elapsed : SlotStatus.available,
      );
    });
  }
}
