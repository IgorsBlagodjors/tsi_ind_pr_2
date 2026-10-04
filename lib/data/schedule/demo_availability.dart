enum SlotStatus { available, booked, elapsed }

class AppointmentSlot {
  const AppointmentSlot(this.start, this.status);

  final DateTime start;
  final SlotStatus status;
}

/// Local demo availability only; no appointments are booked or persisted here.
class DemoAvailability {
  const DemoAvailability(this.doctorId);

  final String doctorId;

  List<AppointmentSlot> slotsFor(DateTime date, {required DateTime now}) {
    if (date.weekday == DateTime.sunday) return const [];
    final seed = doctorId.codeUnits.fold(0, (sum, value) => sum + value);
    final dayNumber = DateTime.utc(
      date.year,
      date.month,
      date.day,
    ).difference(DateTime.utc(2020)).inDays;
    final fullyBooked = (dayNumber + seed) % 9 == 0;
    return List.generate(15, (index) {
      final start = DateTime(date.year, date.month, date.day, 9, index * 30);
      final booked = fullyBooked || (dayNumber + seed + index) % 4 < 2;
      return AppointmentSlot(
        start,
        !start.isAfter(now)
            ? SlotStatus.elapsed
            : booked
            ? SlotStatus.booked
            : SlotStatus.available,
      );
    });
  }
}
