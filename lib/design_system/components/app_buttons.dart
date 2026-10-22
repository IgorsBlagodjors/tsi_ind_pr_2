import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_tappable.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class AppButtons {
  static Widget textButton({
    required VoidCallback onPressed,
    required String text,
    required TextStyle textStyle,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: textStyle),
    );
  }

  static Widget gradientCircleIconBTN({
    required VoidCallback onPressed,
    required Widget icon,
    required double radius,
    bool gradientOutlined = false,
  }) {
    return AppTappable(
      onTap: onPressed,
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradientOutlined ? null : AppColors.degradadoAzul,
        border: gradientOutlined
            ? BoxBorder.all(width: 1, color: AppColors.primary)
            : null,
      ),
      child: icon,
    );
  }

  static Widget circleIconBTN({
    required VoidCallback onPressed,
    required Widget icon,
    required double radius,
    bool fullWhite = false,
  }) {
    return AppTappable(
      onTap: onPressed,
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fullWhite ? Colors.transparent : Colors.white,
        border: fullWhite ? Border.all(color: Colors.white, width: 1.r) : null,
      ),
      child: icon,
    );
  }

  static Widget smallSquareBTN({
    required VoidCallback onPressed,
    required double contWidth,
    required double contHeight,
    required double radius,
    required Widget icon,
    required DoctorType type,
    required bool isSelected,
  }) {
    return AppTappable(
      onTap: onPressed,
      width: contWidth,
      height: contHeight,
      decoration: BoxDecoration(
        color: isSelected ? null : AppColors.elements,
        gradient: isSelected ? AppColors.degradadoAzul : null,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: icon,
    );
  }

  //Log in/ Sign up
  static Widget authButton({
    required String text,
    required VoidCallback onPressed,
    required double width,
    required double height,
    bool isGradient = false,
  }) {
    return Container(
      width: width,
      constraints: BoxConstraints(minHeight: height),
      decoration: BoxDecoration(
        gradient: isGradient ? AppColors.degradadoAzul : null,
        color: isGradient ? null : AppColors.elements,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: isGradient
              ? AppTextStyles.semiBold24Prime.copyWith(color: Colors.white)
              : AppTextStyles.semiBold24Prime,
        ),
      ),
    );
  }

  //SingelTextButton
  static Widget singleTextButton({
    required String text,
    required VoidCallback onPressed,
    required double height,
    required horizontalPadding,
    TextStyle? textStyle,
    bool adaptiveHeight = false,
    bool isGradient = false,
    bool textIsBlack = false,
  }) {
    return AppTappable(
      onTap: onPressed,
      height: adaptiveHeight ? null : height,
      decoration: BoxDecoration(
        border: isGradient
            ? null
            : Border.all(color: AppColors.primary, width: 1),
        gradient: isGradient ? AppColors.degradadoAzul : null,
        color: isGradient ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Container(
        constraints: adaptiveHeight ? BoxConstraints(minHeight: height) : null,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: adaptiveHeight ? 4 : 0,
        ),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style:
                textStyle ??
                TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isGradient
                      ? Colors.white
                      : textIsBlack
                      ? AppColors.text2
                      : AppColors.primary,
                ),
          ),
        ),
      ),
    );
  }

  static Widget textWithImageBTNWhite({
    required VoidCallback onPressed,
    required double height,
    required Text? textData,
    required double paddingLeft,
    required double paddingRight,
    required Widget icon,
    Offset textOffset = Offset.zero,
    bool isGradient = false,
    bool whiteBorder = false,
  }) {
    return AppTappable(
      padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
      onTap: onPressed,
      height: height,
      decoration: BoxDecoration(
        border: isGradient
            ? null
            : Border.all(
                color: whiteBorder ? AppColors.elements : AppColors.primary,
                width: 1,
              ),
        gradient: isGradient ? AppColors.degradadoAzul : null,
        color: isGradient ? null : Colors.white,
        borderRadius: BorderRadius.circular(13.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 5),
          Flexible(
            child: Transform.translate(offset: textOffset, child: textData),
          ),
        ],
      ),
    );
  }

  static Widget switchBTN({
    required bool value,
    required VoidCallback onTap,
    bool isBig = false,
  }) {
    final bool hasWhiteTrack = isBig ? value : !value;
    return AppTappable(
      onTap: onTap,
      width: isBig ? 51.w : 31.w,
      height: isBig ? 26.h : 15.h,
      padding: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
        gradient: hasWhiteTrack ? null : AppColors.degradadoAzul,
        color: hasWhiteTrack ? Colors.white : null,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary, width: 1.r),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 12.r,
          height: 12.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hasWhiteTrack ? AppColors.primary : Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget backBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        width: 48.w,
        height: 48.h,
        child: Center(
          child: AppIcons.returnIcon(
            color: Colors.white,
            width: 10.w,
            height: 16.h,
          ),
        ),
      ),
    );
  }

  static Widget continueBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        width: 48.w,
        height: 48.h,
        child: Center(
          child: Icon(Icons.chevron_right, color: AppColors.primary, size: 32),
        ),
      ),
    );
  }

  static Widget infoOutlinedPrimeBTN({
    required String plaintText,
    required VoidCallback onPressed,
    required double horizontalPadding,
    required double verticalPadding,
  }) {
    return AppTappable(
      onTap: onPressed,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38.r),
        border: BoxBorder.all(color: AppColors.primary, width: 1.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Text(plaintText, style: AppTextStyles.semiBold14Prime),
      ),
    );
  }
}
