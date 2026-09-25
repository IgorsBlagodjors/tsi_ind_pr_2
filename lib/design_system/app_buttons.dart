import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/app_tappable.dart';

class AppButtons {
  static Widget circleInkButton({
    required VoidCallback onPressed,
    required Widget icon,
  }) {
    return circleIconBTN(onPressed: onPressed, icon: icon);
  }

  static Widget circleIconBTN({
    required VoidCallback onPressed,
    required Widget icon,
  }) {
    return AppTappable(
      onTap: onPressed,
      width: 40.r,
      height: 40.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
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
  }) {
    return AppTappable(
      onTap: onPressed,
      width: contWidth.w,
      height: contHeight.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(radius.r),
      ),
      alignment: Alignment.center,
      child: icon,
    );
  }

  static Widget squareImageAndTextBTN({
    required VoidCallback onPressed,
    required double contWidth,
    required double contHeight,
    required double radius,
    required double spacing,
    required Widget icon,
    required String text,
    required int textSize,
  }) {
    return AppTappable(
      onTap: onPressed,
      width: contWidth.w,
      height: contHeight.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(radius.r),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(height: spacing.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSize.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  static Widget bookingGradientBTN({required VoidCallback onPressed}) {
    return IconButton(onPressed: onPressed, icon: AppIcons.bookingIcon);
  }

  static Widget homeGradientBTN({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: AppIcons.homeIcon(width: 23.12, height: 22.36),
    );
  }

  static Widget chatGradientBTN({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        'assets/icons/chat.svg',
        width: 23.53.w,
        height: 21.h,
      ),
    );
  }

  static Widget userGradientBTN({required VoidCallback onPressed}) {
    return IconButton(onPressed: onPressed, icon: AppIcons.userIcon());
  }

  static Widget starIconBTN({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.star, size: 15.sp, color: AppColors.primary),
    );
  }

  static Widget starOutlindedIconBTN({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.star_border, size: 15.sp, color: AppColors.primary),
    );
  }

  static Widget maleIconBTN({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.male, size: 15.sp, color: AppColors.primary),
    );
  }

  static Widget famaleIconBTN({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.female, size: 15.sp, color: AppColors.primary),
    );
  }

  static Widget heartIconBTN({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.favorite, size: 15.sp, color: AppColors.primary),
    );
  }

  static Widget heartOutlinedIconBTN({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.favorite_border, size: 15.sp, color: AppColors.primary),
    );
  }

  //Log in/ Sign up
  static Widget authButton({
    required String text,
    required VoidCallback onPressed,
    bool isGradient = false,
  }) {
    return Container(
      width: 207.w,
      height: 45.h,
      decoration: BoxDecoration(
        gradient: isGradient ? AppColors.primaryGradient : null,
        color: isGradient ? null : Colors.white,
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
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: isGradient ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }

  //SingelTextButton
  static Widget singleTextButton({
    required String text,
    required VoidCallback onPressed,
    required double width,
    required double height,
    bool isGradient = false,
    bool textIsBlack = false,
  }) {
    return AppTappable(
      onTap: onPressed,
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        border: isGradient
            ? null
            : Border.all(color: AppColors.primary, width: 1),
        gradient: isGradient ? AppColors.primaryGradient : null,
        color: isGradient ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: isGradient
                ? Colors.white
                : textIsBlack
                ? Colors.black
                : AppColors.primary,
          ),
        ),
      ),
    );
  }

  static Widget textWithImageBTN({
    required VoidCallback onPressed,
    bool isGradient = false,
    String text = 'Main Button',
  }) {
    return AppTappable(
      onTap: onPressed,
      width: 153.w,
      height: 28.h,
      decoration: BoxDecoration(
        border: isGradient
            ? null
            : Border.all(color: AppColors.primary, width: 1),
        gradient: isGradient ? AppColors.primaryGradient : null,
        color: isGradient ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(38.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isGradient
              ? AppIcons.bookingOutlinedIcon(
                  color: Colors.white,
                  width: 14,
                  height: 15,
                )
              : AppIcons.bookingOutlinedIcon(
                  color: Colors.black,
                  width: 14,
                  height: 15,
                ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: isGradient ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget contactUs({required VoidCallback onPressed}) {
    return AppTappable(
      onTap: onPressed,
      width: 146.w,
      height: 41.h,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.transparent,
      ),
      child: Center(
        child: Text(
          'Contact us',
          style: TextStyle(fontSize: 20.sp, color: AppColors.primary),
        ),
      ),
    );
  }

  static Widget customRadioBTN({
    required bool selected,
    required VoidCallback onTap,
  }) {
    return AppTappable(
      onTap: onTap,
      width: 20.r,
      height: 20.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 2.r),
      ),
      child: Center(
        child: selected
            ? Container(
                width: 12.r,
                height: 12.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                ),
              )
            : null,
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
        gradient: hasWhiteTrack ? null : AppColors.primaryGradient,
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
}
