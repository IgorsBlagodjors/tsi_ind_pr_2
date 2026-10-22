import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/a_z_filter.dart';

class SpecialtiesFilter extends StatelessWidget {
  const new({
    super.key,
    this.trailingText,
    required this.onFilterPressed,
    this.showDivider = true,
    required this.onPressed,
    required this.sortOrder,
  });
  final String? trailingText;
  final VoidCallback onFilterPressed;
  final bool showDivider;
  final VoidCallback onPressed;
  final SortOrder sortOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sort By',
                      style: AppTextStyles.light12White.copyWith(
                        color: AppColors.text2,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    AZFilter(sortOrder: sortOrder, onPressed: onPressed),
                    SizedBox(width: 7.w),
                    AppButtons.infoOutlinedPrimeBTN(
                      horizontalPadding: 10.w,
                      verticalPadding: 2.h,
                      plaintText: 'Filter',
                      onPressed: onFilterPressed,
                    ),
                  ],
                ),
              ),
            ),
            if (trailingText != null) ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: trailingText == 'Doctors' || trailingText == 'See all'
                    ? () => context.pushNamed('doctors')
                    : null,
                child: Text(
                  trailingText!,
                  style: AppTextStyles.regular12Prime.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (showDivider) ...[
          SizedBox(height: 14.h),
          Divider(color: AppColors.elements, thickness: 1.h, height: 1.h),
        ],
      ],
    );
  }
}
