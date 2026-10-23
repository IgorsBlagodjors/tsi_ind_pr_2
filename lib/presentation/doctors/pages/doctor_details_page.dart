import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/domain/models/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/widgets/doctor_info_header.dart';

class DoctorsInfo extends StatefulWidget {
  const DoctorsInfo({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<DoctorsInfo> createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<DoctorsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DoctorInfoHeader(doctor: widget.doctor),
              SizedBox(height: 22.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppContainers.infoTextContainer(
                      label: 'Focus:',
                      text: widget.doctor.focus ?? 'Not specified.',
                    ),
                    SizedBox(height: 18.h),
                    AppContainers.appDivider(),
                    SizedBox(height: 10.h),
                    Text(
                      'Profile',
                      style: AppTextStyles.medium14White.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    AppContainers.appDivider(),
                    SizedBox(height: 7.h),
                    Text(
                      widget.doctor.profile ?? 'Not specified.',
                      style: AppTextStyles.light12White.copyWith(
                        color: AppColors.text2,
                      ),
                    ),
                    SizedBox(height: 17.h),
                    AppContainers.appDivider(),
                    SizedBox(height: 10.h),
                    Text(
                      'Career Path',
                      style: AppTextStyles.medium14White.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    AppContainers.appDivider(),
                    SizedBox(height: 7.h),
                    Text(
                      widget.doctor.careerPath ?? 'Not specified.',
                      style: AppTextStyles.light12White.copyWith(
                        color: AppColors.text2,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    AppContainers.appDivider(),
                    SizedBox(height: 17.h),

                    Text(
                      'Highlights',
                      style: AppTextStyles.medium14White.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    AppContainers.appDivider(),
                    SizedBox(height: 7.h),
                    Text(
                      widget.doctor.highlights ?? 'Not specified.',
                      style: AppTextStyles.light12White.copyWith(
                        color: AppColors.text2,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    AppContainers.appDivider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
