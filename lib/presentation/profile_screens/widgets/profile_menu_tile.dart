import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class ProfileMenuTile extends StatelessWidget {
  const new({
    super.key,
    required this.plainText,
    required this.icon,
    required this.onPressed,
  });
  final String plainText;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          AppButtons.gradientCircleIconBTN(
            onPressed: onPressed,
            icon: icon,
            radius: 20.r,
          ),
          SizedBox(width: 21.w),
          Text(
            plainText,
            style: AppTextStyles.regular20Prime.copyWith(
              color: AppColors.text2,
            ),
          ),
          Spacer(),
          AppButtons.continueBTN(
            onPressed: () => showActionMessage(context, plainText),
          ),
        ],
      ),
    );
  }
}
