import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class Upcomingapointmentslw extends StatelessWidget {
  const Upcomingapointmentslw({super.key, required this.doctors});
  final List<Doctor> doctors;
  @override
  Widget build(BuildContext context) => Expanded(
    child: ListView.separated(
      key: const PageStorageKey('Upcomingapointmentslw'),
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: doctors.length,
      itemBuilder: (context, index) => _appointment(context, doctors[index]),
      separatorBuilder: (context, index) =>
          Divider(height: 1, thickness: 1, color: AppColors.outline),
    ),
  );
  Widget _appointment(BuildContext context, Doctor doctor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 33,
                backgroundImage: AssetImage(doctor.image),
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
                'Sunday, 12 June',
              );
              final time = _badge(context, Icons.alarm, '9:30 AM - 10:00 AM');
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
                  onPressed: () =>
                      context.pushNamed('doctors_info', extra: doctor),
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
                onPressed: () => showActionMessage(context, 'Confirm'),
                icon: Icon(Icons.check, size: 21, color: AppColors.primary),
              ),
              const SizedBox(width: 5),
              AppButtons.gradientCircleIconBTN(
                radius: 15,
                gradientOutlined: true,
                onPressed: () => showActionMessage(context, 'Cancel'),
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
}
