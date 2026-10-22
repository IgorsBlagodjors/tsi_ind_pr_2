import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';

class AppIcons {
  static Widget userOutlinedIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/userOutlined.svg',
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget checkIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/check.svg',
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget closeIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/x.svg',
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget favIcon({
    required bool isFavorite,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        size: 20.w,
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: AppColors.primary,
      ),
    );
  }

  static Widget phoneIcon() {
    return SvgPicture.asset(
      'assets/icons/phone.svg',
      width: 10.w,
      height: 11.h,
    );
  }

  static Widget cameraIcon() {
    return SvgPicture.asset('assets/icons/camera.svg');
  }

  static Widget heartOutlinedIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/heartOutlined.svg',
      width: width.w,
      height: height.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget topIcon({
    Color? color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/top.svg',
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color, BlendMode.srcIn),
      width: width,
      height: height,
    );
  }

  static Widget walletIcon() {
    return SvgPicture.asset(
      'assets/icons/wallet.svg',
      width: 21.9.w,
      height: 19.05.h,
    );
  }

  static Widget fingerprintIcon() {
    return SvgPicture.asset(
      'assets/icons/fingerprint.svg',
      width: 23.w,
      height: 23.h,
    );
  }

  static Widget privacyIcon() {
    return SvgPicture.asset(
      'assets/icons/privacy.svg',
      width: 18.1.w,
      height: 20.95.h,
    );
  }

  static Widget facebookIcon() {
    return SvgPicture.asset(
      'assets/icons/facebook.svg',
      width: 22.w,
      height: 22.h,
    );
  }

  static Widget settingIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/settings.svg',
      width: width.w,
      height: height.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget googleIcon() {
    return SvgPicture.asset(
      'assets/icons/google.svg',
      width: 18.w,
      height: 18.h,
    );
  }

  static Widget questionsIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/questions.svg',
      width: width.w,
      height: height.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget logOutIcon() {
    return SvgPicture.asset(
      'assets/icons/logOut.svg',
      width: 19.05.w,
      height: 16.1.h,
    );
  }

  static Widget bookingOutlinedIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/bookingOutlined.svg',
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget returnIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return GestureDetector(
      child: SvgPicture.asset(
        'assets/icons/return.svg',
        width: width,
        height: height,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }

  static Widget homeOutlinedIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/homeOutlined.svg',
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget stethoscopeIcon() {
    return SvgPicture.asset(
      'assets/icons/stethoscope.svg',
      width: 17.18.w,
      height: 20.62.h,
    );
  }

  static Widget chatOutlinedIcon({
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/chatOutlined.svg',
      width: width,
      height: height,
    );
  }

  static Widget pharmacyIcon() {
    return SvgPicture.asset(
      'assets/icons/pharmacy.svg',
      width: 19.7.w,
      height: 20.h,
    );
  }

  static Widget speciality() {
    return Icon(Icons.add_circle_outline, size: 20.r, color: AppColors.primary);
  }

  static Widget record() {
    return SvgPicture.asset(
      'assets/icons/record.svg',
      width: 13.16.w,
      height: 20.h,
    );
  }

  static Widget get bell =>
      SvgPicture.asset('assets/icons/bell.svg', width: 12.w, height: 15.h);

  static Widget search() {
    return SvgPicture.asset(
      'assets/icons/search.svg',
      width: 12.w,
      height: 14.h,
    );
  }

  static Widget edit({
    required double width,
    required double height,
    required Color color,
  }) {
    return SvgPicture.asset(
      'assets/icons/edit.svg',
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  //Medical specialities
  static Widget generalMedicine({required Color color}) {
    return SvgPicture.asset(
      'assets/icons/generalMedicine.svg',
      width: 32.75.w,
      height: 40.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget ophtamology({required Color color}) {
    return SvgPicture.asset(
      'assets/icons/ophtamology.svg',
      width: 40.w,
      height: 27.88.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget dermatology({required Color color}) {
    return SvgPicture.asset(
      'assets/icons/dermatology.svg',
      width: 40.w,
      height: 21.55.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget cardiology({required Color color}) {
    return SvgPicture.asset(
      'assets/icons/cardiology.svg',
      width: 40.w,
      height: 31.29.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget gynecology({required Color color}) {
    return SvgPicture.asset(
      'assets/icons/gynecology.svg',
      width: 40.w,
      height: 20.62.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget oncology({required Color color}) {
    return SvgPicture.asset(
      'assets/icons/oncology.svg',
      width: 40.w,
      height: 40.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget odontology({required Color color}) {
    return SvgPicture.asset(
      'assets/icons/odontology.svg',
      width: 35.99.w,
      height: 40.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget orthopedics({required Color color}) {
    return SvgPicture.asset(
      'assets/icons/orthopedics.svg',
      width: 40.w,
      height: 39.15.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget otolaryngology({required Color color}) {
    return SvgPicture.asset(
      'assets/icons/otolaryngology.svg',
      width: 40.w,
      height: 34.88.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget messageOutlinedIcon() {
    return SvgPicture.asset('assets/icons/messageOutlined.svg');
  }
}
