import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';

class AppTextStyles {
  static TextStyle semiBold24Prime = TextStyle(
    color: AppColors.primary,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle medium20Black = TextStyle(
    color: AppColors.text2,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle regular20Prime = TextStyle(
    color: AppColors.primary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle medium12Prime = TextStyle(
    color: AppColors.primary,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle lague12Light = TextStyle(
    fontFamily: 'League Spartan',
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
    height: 15 / 12, // Figma 12/15
    letterSpacing: 0,
    color: AppColors.text2,
  );
}
