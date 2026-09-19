import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/app_icons.dart';

class AppContainers {
  static Widget notification({required bool hasNotification}) {
    return CircleAvatar(
      radius: 14.r,
      backgroundColor: Colors.red,
      child: Stack(
        children: [
          AppIcons.bell,
          Positioned(
            right: 0,
            top: 0,
            child: hasNotification
                ? Container(
                    width: 4.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  static Widget navigations({required Widget icon, required String text}) {
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          icon,
          Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  static Widget dateContainer({
    required String date,
    required String day,
    required bool isSelected,
  }) {
    return Container(
      width: 42.w,
      height: 64.h,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
          Text(
            day.toUpperCase(),
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
