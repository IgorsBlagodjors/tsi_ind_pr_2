import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/app_icons.dart';

class AppButtons {
  //Circle buttons
  static Widget userBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.userIcons());
  }

  static Widget checkBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.checkIcons());
  }

  static Widget closeBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.closekIcons());
  }

  static Widget heartOutlinedBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AppIcons.heartOutlinedIcons(),
    );
  }

  static Widget top({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.topIcons());
  }

  static Widget heartBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.heartIcons());
  }

  static Widget walletBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.walletIcons());
  }

  static Widget soundBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.soundIcons());
  }

  static Widget fingerprintBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AppIcons.fingerprintIcons(),
    );
  }

  static Widget privacyBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.privacyIcons());
  }

  static Widget globalBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.globalIcons());
  }

  static Widget facebookBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.facebookIcons());
  }

  static Widget settingsBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.sattingIcons());
  }

  static Widget whatsappBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.whatsappIcons());
  }

  static Widget googleBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.googleIcons());
  }

  static Widget questionsBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.questionsIcons());
  }

  static Widget logoutBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.logOutIcons());
  }

  static Widget picgramBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.picgramIcons());
  }

  //Square buttons
  static Widget bookingSquareBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 46.w,
        height: 44.h,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(9.r),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icons/booking.svg',
          width: 18.w,
          height: 21.h,
        ),
      ),
    );
  }

  static Widget documentSquareBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AppIcons.documentOutlinedIcons(),
    );
  }

  static Widget messageSquareBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 46.w,
        height: 44.h,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(9.r),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icons/message.svg',
          width: 18.w,
          height: 18.h,
        ),
      ),
    );
  }

  //Gradient/GradientOutline buttons
  static Widget bookingGradientOutlinedBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AppIcons.bookingGradientOutlinedIcon,
    );
  }

  static Widget bookingGradientBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AppIcons.bookingGradientIcon,
    );
  }

  static Widget homeGradienOutlinedtBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AppIcons.homeGradientOutlinedIcon,
    );
  }

  static Widget homeGradientBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.homeGradientIcon);
  }

  static Widget chatGradienOutlinedtBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.chatOutlinedIcon);
  }

  static Widget chatGradientBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        'assets/icons/chat.svg',
        width: 23.53.w,
        height: 21.h,
      ),
    );
  }

  static Widget userGradientOutlinedBTN({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AppIcons.userProfileGradientOutlined,
    );
  }

  static Widget userGradientBTN({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.userGradientIcon);
  }

  //IconButtons
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
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
      ),
    );
  }

  static Widget textWithImageBTN({
    required VoidCallback onPressed,
    bool isGradient = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
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
                ? SvgPicture.asset(
                    'assets/icons/booking.svg',
                    width: 14.w,
                    height: 15.h,
                  )
                : SvgPicture.asset(
                    'assets/icons/bookingBlack.svg',
                    width: 14.w,
                    height: 15.h,
                  ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Main Button',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: isGradient ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
