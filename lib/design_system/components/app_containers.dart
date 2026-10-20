import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/data/app_constants.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_tappable.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class AppContainers {
  static Widget smallSquareContainer({required Widget icon}) {
    return Container(
      width: 96.w,
      height: 94.h,
      decoration: BoxDecoration(
        gradient: AppColors.degradadoAzul,

        borderRadius: BorderRadius.circular(9.r),
      ),
      child: icon,
    );
  }

  static Widget whiteCircleContainer({
    bool hasNotification = false,
    required double radius,
    required Widget icon,
    VoidCallback? onTap,
  }) {
    final avatar = CircleAvatar(
      radius: radius.r,
      backgroundColor: AppColors.elements,
      child: Stack(
        children: [
          icon,
          Positioned(
            right: 0,
            top: 0,
            child: hasNotification
                ? Container(
                    width: 4.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
    if (onTap == null) return avatar;
    return AppTappable(
      onTap: onTap,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: avatar,
    );
  }

  // Outlined icon plus outlinet text on the bottom
  static Widget navigations({
    required Widget icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          icon,
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  static Widget dateContainer({
    required String date,
    required String day,
    required bool isSelected,
  }) {
    return Container(
      width: 42.w,
      constraints: BoxConstraints(minHeight: 64.h),
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white, width: 1.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
          Text(
            day.toUpperCase(),
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static Widget profileAvatar({
    required NetworkImage image,
    required double radius,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: image,
      backgroundColor: Colors.transparent,
    );
  }

  static Widget infoTextContainer({required String text, String? label}) {
    return Container(
      padding: EdgeInsets.only(
        left: 15.w,
        right: 10.w,
        top: 16.h,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.elements,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            if (label != null)
              TextSpan(
                text: '$label ',
                style: AppTextStyles.semiBold12Prime.copyWith(
                  color: Colors.black,
                ),
              ),
            TextSpan(text: text),
          ],
        ),
        style: AppTextStyles.lague12Light.copyWith(color: Colors.black),
      ),
    );
  }

  static Widget appDivider() {
    return Divider(thickness: 1, height: 1.h, color: AppColors.outline);
  }

  static Widget cachedNetworkImage({
    required String? imageUrl,
    required double size,
  }) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl == null || imageUrl.isEmpty
            ? defaultNetworkImage
            : imageUrl,
        width: size.w,
        height: size.h,
        fit: BoxFit.cover,

        placeholder: (context, url) {
          return SizedBox(
            width: size.w,
            height: size.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        },

        errorWidget: (context, url, error) {
          debugPrint('CACHE IMAGE ERROR: $error');
          debugPrint('URL: $url');

          return CircleAvatar(
            radius: size / 2,
            child: CachedNetworkImage(imageUrl: defaultNetworkImage),
          );
        },
      ),
    );
  }
}
