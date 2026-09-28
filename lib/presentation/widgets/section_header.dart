import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    this.title,
    this.trailingText = 'See all',
    this.color,
    this.dividerColor,
    this.onPressed,
  });

  final String? title;
  final String trailingText;
  final Color? color;
  final Color? dividerColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? AppColors.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: title == null
                  ? const SizedBox.shrink()
                  : Text(
                      title!,
                      style: AppTextStyles.semiBold14Prime.copyWith(
                        color: textColor,
                      ),
                    ),
            ),
            SizedBox(width: 8.w),
            InkWell(
              onTap: onPressed,
              child: Text(
                trailingText,
                style: AppTextStyles.regular12Prime.copyWith(
                  color: textColor,
                  decoration: TextDecoration.underline,
                  decorationColor: textColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 7.h),
        Divider(
          color: dividerColor ?? AppColors.elements,
          thickness: 1.h,
          height: 1.h,
        ),
      ],
    );
  }
}
