import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/Specialties_header.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/specialties_filter.dart';

class DoctorsPage extends StatefulWidget {
  const new({super.key, required this.doctorType});

  final DoctorType doctorType;

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  Widget build(BuildContext context) {
    final List<Doctor> doctorList = doctorsByType(widget.doctorType);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SpecialtiesHeader(
              title: widget.doctorType.title,
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed('specialties');
                }
              },
            ),
            SizedBox(height: 28.h),
            SpecialtiesFilter(trailingText: 'See all'),
            SizedBox(height: 14.h),
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.only(left: 27.w, right: 31.w),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 13.h),
                  itemCount: doctorList.length,
                  itemBuilder: (context, index) {
                    final doctor = doctorList[index];
                    return SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              AppContainers.profileAvatar(
                                image: AssetImage(doctor.image),
                                radius: 53.5.r,
                              ),
                              SizedBox(width: 13.w),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor.name,
                                      style: AppTextStyles.medium15Prime,
                                    ),
                                    Text(
                                      doctor.specialization,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.light13Prime
                                          .copyWith(color: AppColors.text2),
                                    ),
                                    SizedBox(height: 15.h),
                                    Row(
                                      children: [
                                        AppContainers.primaryBorderContainer(
                                          plaintText: 'Info',
                                        ),
                                        Spacer(),
                                        AppIcons.bookingOutlinedIcon(
                                          color: AppColors.primary,
                                          width: 13.w,
                                          height: 14.82.h,
                                        ),
                                        SizedBox(width: 14.w),
                                        AppIcons.questionsIcon(
                                          color: AppColors.primary,
                                          width: 14.w,
                                          height: 14.h,
                                        ),
                                        SizedBox(width: 14.w),
                                        AppIcons.heartIcon(
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Divider(
                            thickness: 1,
                            height: 1.h,
                            color: AppColors.elements,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
