import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/app_tappable.dart';

class AppSelectors {
  static Widget specialitySelector({
    required VoidCallback onPressed,
    required Widget icon,
    required String text,
    bool isClicked = false,
  }) {
    return AppTappable(
      onTap: onPressed,
      width: 96.w,
      height: 94.h,
      decoration: BoxDecoration(
        gradient: isClicked ? AppColors.degradadoAzul : null,
        color: isClicked ? null : Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(height: 10.h),
          Flexible(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isClicked ? Colors.white : AppColors.primary,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
