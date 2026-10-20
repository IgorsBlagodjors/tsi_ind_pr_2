import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_booking.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_tappable.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class AppointmentDetailsArgs {
  const AppointmentDetailsArgs({required this.doctor, required this.booking});
  final Doctor doctor;
  final AppointmentBooking booking;
}

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({
    super.key,
    required this.doctor,
    required this.booking,
  });
  final Doctor doctor;
  final AppointmentBooking booking;

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  bool _saving = false;
  bool _cancelled = false;

  @override
  Widget build(BuildContext context) {
    final patient = widget.booking.patient;
    final start = widget.booking.startsAt.toLocal();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(gradient: AppColors.degradadoAzul),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 21.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AppButtons.backBTN(
                              onPressed: () {
                                if (context.canPop()) {
                                  context.pop();
                                } else {
                                  context.goNamed('home');
                                }
                              },
                            ),
                          ),
                        ),
                        Text(
                          'Your appointment',
                          style: AppTextStyles.semiBold24Prime.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 17.h,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17.r),
                        ),
                        child: Row(
                          children: [
                            AppContainers.cachedNetworkImage(
                              imageUrl: widget.doctor.image,
                              size: 68.h,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.doctor.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.medium15Prime.copyWith(
                                      height: 1.h,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    widget.doctor.specialization,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.light14White.copyWith(
                                      color: AppColors.text2,
                                      height: 1.h,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      AppButtons.textWithImageBTNWhite(
                                        whiteBorder: true,
                                        paddingLeft: 5.w,
                                        paddingRight: 15.w,
                                        onPressed: () => showActionMessage(
                                          context,
                                          'Doctor reviews are not available yet.',
                                        ),
                                        height: 23.h,
                                        textData: Text(
                                          widget.doctor.rating?.toString() ??
                                              '—',
                                          style: AppTextStyles.light12White
                                              .copyWith(color: AppColors.text2),
                                        ),
                                        textOffset: Offset(0, 1.h),
                                        icon: Icon(
                                          Icons.star,
                                          size: 13.sp,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      AppButtons.textWithImageBTNWhite(
                                        whiteBorder: true,
                                        paddingLeft: 5.w,
                                        paddingRight: 15.w,
                                        onPressed: () => showActionMessage(
                                          context,
                                          'Chat is not available yet.',
                                        ),
                                        height: 23.h,
                                        textData: Text(
                                          widget.doctor.reviewCount.toString(),
                                          style: AppTextStyles.light12White
                                              .copyWith(color: AppColors.text2),
                                        ),
                                        textOffset: Offset(0, 1.h),
                                        icon: AppIcons.messageOutlinedIcon(),
                                      ),
                                      Spacer(),

                                      AppTappable(
                                        onTap: () => showActionMessage(
                                          context,
                                          'Questions are not available yet.',
                                        ),
                                        width: 22.08.w,
                                        height: 22.08.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.elements,
                                        ),
                                        child: AppIcons.questionsIcon(
                                          color: AppColors.primary,
                                          width: 5.81.w,
                                          height: 10.46.h,
                                        ),
                                      ),
                                      AppTappable(
                                        onTap: () => showActionMessage(
                                          context,
                                          'Like is not available yet.',
                                        ),
                                        width: 22.08.w,
                                        height: 22.08.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.elements,
                                        ),
                                        child: Icon(
                                          Icons.favorite,
                                          color: AppColors.primary,
                                          size: 15.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppContainers.appDivider(),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 6.h,
                              bottom: 3.h,
                              left: 15.w,
                              right: 37.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.r),
                              color: AppColors.primary,
                            ),
                            child: Text(
                              MaterialLocalizations.of(context)
                                  .formatMediumDate(start),
                              style: AppTextStyles.medium14White,
                            ),
                          ),
                        ),
                        Spacer(),
                        AppButtons.gradientCircleIconBTN(
                          onPressed: () => showActionMessage(
                            context,
                            'Confirmation is not available yet.',
                          ),
                          icon: AppIcons.checkIcon(
                            color: Colors.white,
                            width: 14.18.w,
                            height: 10.63.h,
                          ),
                          radius: 13.5.r,
                        ),
                        SizedBox(width: 9.w),
                        if (_canCancel)
                          AppButtons.gradientCircleIconBTN(
                            onPressed: _cancel,
                            icon: AppIcons.closeIcon(
                              color: Colors.white,
                              width: 8.74.w,
                              height: 9.h,
                            ),
                            radius: 13.5.r,
                          ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 15.w),
                      child: Text(
                        TimeOfDay.fromDateTime(start).format(context),
                        style: AppTextStyles.regular12Prime.copyWith(
                          color: AppColors.text2,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    AppContainers.appDivider(),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _appointmentDetailRow(
                            context: context,
                            label: 'Booking for',
                            value: patient.isAccountOwner
                                ? 'Myself'
                                : 'Another person',
                          ),
                          SizedBox(height: 5.h),
                          _appointmentDetailRow(
                            context: context,
                            label: 'Full Name',
                            value: patient.fullName,
                          ),
                          SizedBox(height: 5.h),
                          _appointmentDetailRow(
                            context: context,
                            label: 'Age',
                            value: patient.age.toString(),
                          ),
                          SizedBox(height: 5.h),
                          _appointmentDetailRow(
                            context: context,
                            label: 'Gender',
                            value: switch (patient.gender) {
                              Gender.male => 'Male',
                              Gender.female => 'Female',
                              Gender.other => 'Other',
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    AppContainers.appDivider(),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Problem',
                            style: AppTextStyles.light12White.copyWith(
                              color: AppColors.text2,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            patient.problem.trim().isEmpty
                                ? 'No problem description provided.'
                                : patient.problem,
                            style: AppTextStyles.light12White.copyWith(
                              color: AppColors.text2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButtons.singleTextButton(
                              text: 'Payment',
                              onPressed: () => showActionMessage(
                                context,
                                'Payment is not available yet.',
                              ),
                              height: 25.h,
                              horizontalPadding: 6.w,
                              textStyle: AppTextStyles.semiBold17Prime,
                            ),
                          ),
                          SizedBox(width: 32.w),
                          Expanded(
                            child: _canCancel
                                ? AppButtons.singleTextButton(
                                    text: _saving ? 'Cancelling…' : 'Cancel',
                                    onPressed: _cancel,
                                    height: 25.h,
                                    horizontalPadding: 6.w,
                                    textStyle: AppTextStyles.semiBold17Prime
                                        .copyWith(color: Colors.white),
                                    isGradient: true,
                                  )
                                : Text(
                                    _cancelled ||
                                            widget.booking.status ==
                                                AppointmentStatus.cancelled
                                        ? 'Appointment cancelled'
                                        : widget.booking.status ==
                                              AppointmentStatus.completed
                                        ? 'Appointment completed'
                                        : 'This appointment can no longer be cancelled.',
                                    style: AppTextStyles.medium12Prime,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _appointmentDetailRow({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.light12White.copyWith(color: Colors.black),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyles.medium12Prime.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  bool get _canCancel =>
      !_cancelled && widget.booking.status == AppointmentStatus.upcoming;

  Future<void> _cancel() async {
    if (_saving || !_canCancel) return;
    setState(() => _saving = true);
    try {
      final accepted = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cancel appointment?'),
          content: const Text(
            'The visit will remain in your appointment history.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Keep appointment'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Cancel appointment'),
            ),
          ],
        ),
      );
      if (accepted != true || !mounted) return;
      await context.read<AppointmentsRepository>().changeStatus(
        userId: context.read<AuthRepository>().currentUser?.id ?? '',
        appointmentId: widget.booking.id,
        status: AppointmentStatus.cancelled,
      );
      if (!mounted) return;
      setState(() => _cancelled = true);
      showActionMessage(context, 'Appointment cancelled.');
    } on BookingFailure catch (error) {
      if (mounted) showActionMessage(context, error.message);
    } catch (_) {
      if (mounted) {
        showActionMessage(
          context,
          'Could not cancel the appointment. Please try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
