import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class DoctorDetailsBadges extends StatelessWidget {
  const DoctorDetailsBadges({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _badge(
            icon: AppIcons.topIcon(
              color: AppColors.primary,
              width: 18.51.w,
              height: 18.51.h,
            ),
            label: doctor.yearsOfExperience == null
                ? '—'
                : '${doctor.yearsOfExperience} years',
            label2: 'experience',
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          flex: 2,
          child: _badge2(
            icon: Icon(Icons.alarm, color: AppColors.primary, size: 18.r),
            label: doctor.workingHoursDescription ?? 'Hours not specified',
            label2: '',
          ),
        ),
      ],
    );
  }

  Widget _badge({
    required Widget icon,
    required String label,
    required String label2,
  }) {
    return Container(
      height: 32.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary, width: 1.w),
        borderRadius: BorderRadius.circular(13.r),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            icon,
            SizedBox(width: 4.72.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.regular12Prime.copyWith(
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                Text(
                  label2,
                  style: AppTextStyles.lague12Light.copyWith(
                    color: Colors.black,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge2({
    required Widget icon,
    required String label,
    required String label2,
  }) {
    return Container(
      height: 32.h,
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary, width: 1.w),
        borderRadius: BorderRadius.circular(13.r),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            icon,
            SizedBox(width: 4.72.w),
            Text(
              label,
              style: AppTextStyles.light14White.copyWith(
                color: Colors.black,
                height: 1,
              ),
            ),
            Text(
              label2.isEmpty ? '' : ' / ',
              style: AppTextStyles.light14White.copyWith(
                color: Colors.black,
                height: 1,
              ),
            ),
            Text(
              label2,
              style: AppTextStyles.light14White.copyWith(
                color: Colors.black,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
