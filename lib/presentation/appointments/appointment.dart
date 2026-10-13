// import 'package:flutter/material.dart';
// import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
// import 'package:tsi_ind_pr_2/data/demo/demo_data.dart';
// import 'package:tsi_ind_pr_2/data/appointments/appointment_status.dart';
// import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
// import 'package:tsi_ind_pr_2/presentation/appointments/widgets/cancelledApointmentLW.dart';
// import 'package:tsi_ind_pr_2/presentation/appointments/widgets/completedApointmentLW.dart';
// import 'package:tsi_ind_pr_2/presentation/appointments/widgets/upcomingApointmentsLW.dart';
// import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';

// class Appointment extends StatefulWidget {
//   const Appointment({super.key});
//   @override
//   State<Appointment> createState() => _AppointmentState();
// }

// class _AppointmentState extends State<Appointment> {
//   AppointmentStatus _selectedAppointmentStatus = AppointmentStatus.completed;

//   @override
//   Widget build(BuildContext context) => AuthScaffold(
//     title: 'All Appointment',
//     backRoute: 'home',
//     child: Center(
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 540),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             children: [
//               const SizedBox(height: 28),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _tab(AppointmentStatus.completed, 'Complete'),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(child: _tab(AppointmentStatus.upcoming, 'Upcoming')),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: _tab(AppointmentStatus.cancelled, 'Cancelled'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 26),
//               Divider(height: 1, thickness: 1, color: AppColors.outline),
//               switch (_selectedAppointmentStatus) {
//                 AppointmentStatus.completed => CompletedApointmentlw(
//                   doctors: demoData
//                       .appointmentsFor(
//                         demoData.currentUser.id,
//                         AppointmentStatus.completed,
//                       )
//                       .map((item) => demoData.doctorById(item.doctorId))
//                       .toList(),
//                 ),
//                 AppointmentStatus.upcoming => UpcomingApointmentsLW(
//                   doctors: demoData.allDoctors,
//                   appointments: demoData.appointmentsFor(
//                     demoData.currentUser.id,
//                     AppointmentStatus.upcoming,
//                   ),
//                 ),
//                 AppointmentStatus.cancelled => CancelledApointmentlLW(
//                   doctors: demoData
//                       .appointmentsFor(
//                         demoData.currentUser.id,
//                         AppointmentStatus.cancelled,
//                       )
//                       .map((item) => demoData.doctorById(item.doctorId))
//                       .toList(),
//                 ),
//               },
//             ],
//           ),
//         ),
//       ),
//     ),
//   );

//   Widget _tab(AppointmentStatus status, String label) {
//     final selected = _selectedAppointmentStatus == status;
//     return AppButtons.singleTextButton(
//       text: label,
//       onPressed: () => setState(() => _selectedAppointmentStatus = status),
//       height: 28,
//       horizontalPadding: 3.0,
//       adaptiveHeight: true,
//       isGradient: selected,
//       textIsBlack: true,
//       textStyle: TextStyle(
//         fontFamily: 'League Spartan',
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//         color: selected ? Colors.white : AppColors.text2,
//       ),
//     );
//   }
// }
