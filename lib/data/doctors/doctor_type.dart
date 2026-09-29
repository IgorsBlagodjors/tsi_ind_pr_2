/// Medical categories used to group doctors.
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
