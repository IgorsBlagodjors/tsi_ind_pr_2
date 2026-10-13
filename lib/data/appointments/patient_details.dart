import '../gender.dart';

/// Patient details at booking time. The patient may differ from the account owner.
class PatientDetails {
  const PatientDetails({
    required this.fullName,
    required this.age,
    required this.gender,
    this.isAccountOwner = true,
    this.problem = '',
  });

  final String fullName;
  final int age;
  final Gender gender;
  final bool isAccountOwner;
  final String problem;

  factory PatientDetails.fromMap(Map<String, dynamic> data) => PatientDetails(
    fullName: data['fullName'] as String,
    age: (data['age'] as num).toInt(),
    gender: Gender.values.byName(data['gender'] as String),
    isAccountOwner: data['isAccountOwner'] as bool,
    problem: data['problem'] as String? ?? '',
  );

  Map<String, dynamic> toMap() => {
    'fullName': fullName,
    'age': age,
    'gender': gender.name,
    'isAccountOwner': isAccountOwner,
    'problem': problem,
  };
}
