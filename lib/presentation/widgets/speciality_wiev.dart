import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

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
      ),
    );
  }
}
