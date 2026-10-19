import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';

class AppointmentDoctorPhoto extends StatelessWidget {
  const AppointmentDoctorPhoto({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    Widget fallback() => ColoredBox(
      color: AppColors.elements,
      child: Icon(Icons.person, color: AppColors.primary, size: 36),
    );
    final image = doctor.image;
    return ClipOval(
      child: SizedBox(
        width: 66,
        height: 66,
        child: image.isEmpty
            ? fallback()
            : image.startsWith('https://') || image.startsWith('http://')
            ? Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, error, stack) => fallback(),
              )
            : Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, error, stack) => fallback(),
              ),
      ),
    );
  }
}
