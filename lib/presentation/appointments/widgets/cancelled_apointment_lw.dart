import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class CancelledApointmentlLW extends StatefulWidget {
  const new({super.key, required this.doctors});

  final List<Doctor> doctors;

  @override
  State<CancelledApointmentlLW> createState() => _CancelledApointmentlLWState();
}

class _CancelledApointmentlLWState extends State<CancelledApointmentlLW> {
  @override
  Widget build(BuildContext context) => ListView.separated(
    separatorBuilder: (context, index) => AppContainers.appDivider(),

    itemBuilder: (context, index) {
      final data = widget.doctors[index];
      return _apointment(context: context, doctor: data);
    },

    itemCount: widget.doctors.length,
  );

  Widget _apointment({required BuildContext context, required Doctor doctor}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        children: [
          Row(
            children: [
              AppContainers.cachedNetworkImage(
                imageUrl: doctor.image,
                size: 65,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      doctor.name,
                      style: AppTextStyles.medium15Prime.copyWith(height: 1),
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      doctor.specialization,
                      style: AppTextStyles.medium15Prime.copyWith(
                        color: AppColors.text2,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          AppButtons.singleTextButton(
            text: 'Add Review',
            textStyle: AppTextStyles.regular20Prime.copyWith(
              color: AppColors.text2,
            ),
            onPressed: () => context.pushNamed('rewiev', extra: doctor),
            height: 27.h,
            horizontalPadding: 6.w,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
