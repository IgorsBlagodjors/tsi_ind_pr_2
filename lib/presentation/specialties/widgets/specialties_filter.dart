import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class SpecialtiesFilter extends StatelessWidget {
  const new({super.key, required this.trailingText});
  final String trailingText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 31.w, right: 33.w),
          child: Row(
            children: [
              Text(
                'Sort By',
                style: AppTextStyles.light12White.copyWith(
                  color: AppColors.text2,
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                decoration: BoxDecoration(
                  gradient: AppColors.degradadoAzul,
                  borderRadius: BorderRadius.circular(38.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'A',
                      style: AppTextStyles.semiBold14Prime.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Transform.translate(
                      offset: Offset(0, -2.h),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 14.r,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(width: 3.w),
                    Text(
                      'Z',
                      style: AppTextStyles.semiBold14Prime.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(trailingText, style: AppTextStyles.semiBold14Prime),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w),
          child: Divider(
            color: AppColors.elements,
            thickness: 1.h,
            height: 1.h,
          ),
        ),
      ],
    );
  }
}
