import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class AZFilter extends StatelessWidget {
  const new({super.key, required this.sortOrder, required this.onPressed});
  final SortOrder sortOrder;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isAscending = sortOrder == SortOrder.ascending;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        decoration: BoxDecoration(
          gradient: AppColors.degradadoAzul,
          borderRadius: BorderRadius.circular(38.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isAscending ? 'A' : 'Z',
              style: AppTextStyles.semiBold14Prime.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(width: 3.w),
            Transform.translate(
              offset: Offset(0, -2.h),
              child: Icon(Icons.arrow_forward, size: 14.r, color: Colors.white),
            ),

            SizedBox(width: 3.w),
            Text(
              isAscending ? 'Z' : 'A',
              style: AppTextStyles.semiBold14Prime.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
