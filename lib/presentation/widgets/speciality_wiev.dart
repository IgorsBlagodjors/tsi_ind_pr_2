import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';

class SpecialityWiev extends StatefulWidget {
  const new({super.key});

  @override
  State<SpecialityWiev> createState() => _SpecialityWievState();
}

class _SpecialityWievState extends State<SpecialityWiev> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          AppButtons.smallSquareBTN(
            onPressed: () => context.pushNamed(
              'doc_by_specialty',
              extra: DoctorType.gynecology,
            ),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.gynecology(color: Colors.white),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            onPressed: () => context.pushNamed(
              'doc_by_specialty',
              extra: DoctorType.oncology,
            ),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.oncology(color: Colors.white),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            onPressed: () => context.pushNamed(
              'doc_by_specialty',
              extra: DoctorType.otolaryngology,
            ),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.otolaryngology(color: Colors.white),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            onPressed: () => context.pushNamed(
              'doc_by_specialty',
              extra: DoctorType.cardiology,
            ),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.cardiology(color: Colors.white),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            onPressed: () => context.pushNamed(
              'doc_by_specialty',
              extra: DoctorType.orthopedics,
            ),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.orthopedics(color: Colors.white),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            onPressed: () => context.pushNamed(
              'doc_by_specialty',
              extra: DoctorType.dermatology,
            ),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.dermatology(color: Colors.white),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            onPressed: () => context.pushNamed(
              'doc_by_specialty',
              extra: DoctorType.generalMedicine,
            ),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.generalMedicine(color: Colors.white),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            onPressed: () => context.pushNamed(
              'doc_by_specialty',
              extra: DoctorType.odontology,
            ),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.odontology(color: Colors.white),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            onPressed: () => context.pushNamed(
              'doc_by_specialty',
              extra: DoctorType.ophthalmology,
            ),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.ophtamology(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
