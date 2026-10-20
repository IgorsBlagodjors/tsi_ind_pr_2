import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/appointment_details.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';

import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_booking.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class UpcomingApointmentsLW extends StatefulWidget {
  const UpcomingApointmentsLW({
    super.key,
    required this.doctors,
    required this.appointments,
  });
  final List<Doctor> doctors;
  final List<AppointmentBooking> appointments;
  @override
  State<UpcomingApointmentsLW> createState() => _UpcomingState();
}

class _UpcomingState extends State<UpcomingApointmentsLW> {
  List<Doctor> get doctors => widget.doctors;
  List<AppointmentBooking> get appointments => widget.appointments;
  bool _saving = false;

  @override
  Widget build(BuildContext context) => ListView.separated(
    key: const PageStorageKey('Upcomingapointmentslw'),
    padding: const EdgeInsets.only(bottom: 16),
    itemCount: appointments.length,
    itemBuilder: (context, index) {
      final booking = appointments[index];
      final doctor = doctors.firstWhere(
        (item) => item.id == booking.doctorId,
        orElse: () => Doctor(
          id: booking.doctorId,
          name: 'Doctor unavailable',
          type: DoctorType.cardiology,
          specialization: '',
          image: '',
        ),
      );
      return KeyedSubtree(
        key: ValueKey(booking.id),
        child: _appointment(context, doctor, booking),
      );
    },
    separatorBuilder: (context, index) =>
        Divider(height: 1, thickness: 1, color: AppColors.outline),
  );
  Widget _appointment(
    BuildContext context,
    Doctor doctor,
    AppointmentBooking booking,
  ) {
    final start = booking.startsAt.toLocal();
    final end = booking.endsAt.toLocal();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              AppContainers.cachedNetworkImage(
                imageUrl: doctor.image,
                size: 65,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.1,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      doctor.specialization,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.15,
                        color: AppColors.text2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final date = _badge(
                context,
                Icons.calendar_month_outlined,
                MaterialLocalizations.of(context).formatMediumDate(start),
              );
              final time = _badge(
                context,
                Icons.alarm,
                '${TimeOfDay.fromDateTime(start).format(context)} - ${TimeOfDay.fromDateTime(end).format(context)}',
              );
              if (constraints.maxWidth < 270 ||
                  MediaQuery.textScalerOf(context).scale(12) > 15) {
                return Wrap(spacing: 6, runSpacing: 6, children: [date, time]);
              }
              return Row(
                children: [
                  Expanded(flex: 46, child: date),
                  const SizedBox(width: 6),
                  Expanded(flex: 54, child: time),
                ],
              );
            },
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: AppButtons.singleTextButton(
                  text: 'Details',
                  onPressed: () => context.pushNamed(
                    'appointment_details',
                    extra: AppointmentDetailsArgs(
                      doctor: doctor,
                      booking: booking,
                    ),
                  ),
                  height: 30,
                  horizontalPadding: 6.0,
                  adaptiveHeight: true,
                  textStyle: TextStyle(fontSize: 18, color: AppColors.text2),
                ),
              ),
              const SizedBox(width: 10),
              AppButtons.gradientCircleIconBTN(
                radius: 15,
                gradientOutlined: true,
                onPressed: () => _change(booking, AppointmentStatus.completed),
                icon: Icon(Icons.check, size: 21, color: AppColors.primary),
              ),
              const SizedBox(width: 5),
              AppButtons.gradientCircleIconBTN(
                radius: 15,
                gradientOutlined: true,
                onPressed: () => _change(booking, AppointmentStatus.cancelled),
                icon: Icon(Icons.close, size: 21, color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(BuildContext context, IconData icon, String text) =>
      AppButtons.textWithImageBTNWhite(
        onPressed: () => showActionMessage(context, text),
        height: MediaQuery.textScalerOf(context).scale(12) > 15 ? 40 : 22,
        paddingLeft: 6,
        paddingRight: 6,
        icon: Icon(icon, size: 12, color: AppColors.primary),
        textData: Text(
          text,
          style: TextStyle(fontSize: 11, height: 1.1, color: AppColors.text2),
        ),
      );

  Future<void> _change(
    AppointmentBooking booking,
    AppointmentStatus status,
  ) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final accepted = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            status == AppointmentStatus.cancelled
                ? 'Cancel appointment?'
                : 'Mark visit completed?',
          ),
          content: const Text(
            'The visit will remain in your appointment history.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Back'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
      if (accepted != true || !mounted) return;
      final uid = context.read<AuthRepository>().currentUser?.id ?? '';
      await context.read<AppointmentsRepository>().changeStatus(
        userId: uid,
        appointmentId: booking.id,
        status: status,
      );
    } on BookingFailure catch (error) {
      if (mounted) showActionMessage(context, error.message);
    } on FirebaseException catch (error) {
      if (mounted) {
        showActionMessage(
          context,
          error.code == 'permission-denied'
              ? 'Firebase denied this change. Check appointment access rules.'
              : 'Could not update the appointment (${error.code}). Please try again.',
        );
      }
    } catch (_) {
      if (mounted) {
        showActionMessage(
          context,
          'Could not update the appointment. Please try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
