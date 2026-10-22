enum Gender { male, female, other }

enum SortOrder { ascending, descending }

enum AppointmentStatus { upcoming, completed, cancelled }

enum DoctorSlotStatus { available, booked, blocked }

enum SlotStatus { available, booked, elapsed }

enum FavSelector { doctor, services }

enum AgeSelector { first, seccont, third }

enum DoctorType {
  cardiology('Cardiology'),
  dermatology('Dermatology'),
  generalMedicine('General Medicine'),
  gynecology('Gynecology'),
  odontology('Odontology'),
  oncology('Oncology'),
  ophthalmology('Ophthalmology'),
  orthopedics('Orthopedics'),
  otolaryngology('Otolaryngology');

  const DoctorType(this.title);

  final String title;
}

enum ScheduleStatus { initial, saving, success, failure }
