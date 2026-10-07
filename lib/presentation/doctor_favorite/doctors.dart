import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/doctors_lw.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/speciality_wiev.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/specialties_filter.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/specialties_header.dart';

class Doctors extends StatefulWidget {
  const new({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SpecialtiesHeader(
              title: 'Doctors',
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed('home');
                }
              },
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 31.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('See all', style: AppTextStyles.regular12Prime),
                  ),
                  SpecialityWiev(),
                  SizedBox(height: 17.h),
                  Divider(
                    height: 1.h,
                    color: AppColors.primary,
                    thickness: 1.h,
                  ),
                  SizedBox(height: 12.h),
                  SpecialtiesFilter(trailingText: 'Top Rating'),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            DoctorsLw(doctorList: doctors),
          ],
        ),
      ),
    );
  }

  static Widget _specialityWiev({required BuildContext context}) {
    return Row(
      children: [
        AppButtons.smallSquareBTN(
          onPressed: () => showActionMessage(context, 'Gynecology'),
          contWidth: 50.w,
          contHeight: 48.96.h,
          radius: 12.r,
          icon: AppIcons.gynecology(color: Colors.white),
        ),
        SizedBox(width: 21.w),
        AppButtons.smallSquareBTN(
          onPressed: () => showActionMessage(context, 'Oncology'),
          contWidth: 50.w,
          contHeight: 48.96.h,
          radius: 12.r,
          icon: AppIcons.oncology(color: Colors.white),
        ),
        SizedBox(width: 21.w),
        AppButtons.smallSquareBTN(
          onPressed: () => showActionMessage(context, 'Otolaryngology'),
          contWidth: 50.w,
          contHeight: 48.96.h,
          radius: 12.r,
          icon: AppIcons.otolaryngology(color: Colors.white),
        ),
        SizedBox(width: 21.w),
        AppButtons.smallSquareBTN(
          onPressed: () => showActionMessage(context, 'Cardiology'),
          contWidth: 50.w,
          contHeight: 48.96.h,
          radius: 12.r,
          icon: AppIcons.cardiology(color: Colors.white),
        ),
        SizedBox(width: 21.w),
        AppButtons.smallSquareBTN(
          onPressed: () => showActionMessage(context, 'Orthopedics'),
          contWidth: 50.w,
          contHeight: 48.96.h,
          radius: 12.r,
          icon: AppIcons.orthopedics(color: Colors.white),
        ),
        SizedBox(width: 21.w),
        AppButtons.smallSquareBTN(
          onPressed: () => showActionMessage(context, 'Dermatology'),
          contWidth: 50.w,
          contHeight: 48.96.h,
          radius: 12.r,
          icon: AppIcons.dermatology(color: Colors.white),
        ),
        SizedBox(width: 21.w),
        AppButtons.smallSquareBTN(
          onPressed: () => showActionMessage(context, 'General medicine'),
          contWidth: 50.w,
          contHeight: 48.96.h,
          radius: 12.r,
          icon: AppIcons.generalMedicine(color: Colors.white),
        ),
        SizedBox(width: 21.w),
        AppButtons.smallSquareBTN(
          onPressed: () => showActionMessage(context, 'Odontology'),
          contWidth: 50.w,
          contHeight: 48.96.h,
          radius: 12.r,
          icon: AppIcons.odontology(color: Colors.white),
        ),
        SizedBox(width: 21.w),
        AppButtons.smallSquareBTN(
          onPressed: () => showActionMessage(context, 'Ophtamology'),
          contWidth: 50.w,
          contHeight: 48.96.h,
          radius: 12.r,
          icon: AppIcons.ophtamology(color: Colors.white),
        ),
      ],
    );
  }
}
