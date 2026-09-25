import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';

class AppIcons {
  static Widget userOutlinedIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/userOutlined.svg',
      width: width.w,
      height: height.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget userIcon() {
    return SvgPicture.asset(
      'assets/icons/user.svg',
      width: 19.0.w,
      height: 20.99.h,
    );
  }

  static Widget checkIcon() {
    return SvgPicture.asset(
      'assets/icons/check.svg',
      width: 21.w,
      height: 15.75.h,
    );
  }

  static Widget closeIcon() {
    return SvgPicture.asset(
      'assets/icons/x.svg',
      width: 12.95.w,
      height: 13.33.h,
    );
  }

  static Widget heartIcon() {
    return SvgPicture.asset(
      'assets/icons/heart.svg',
      width: 18.18.w,
      height: 16.36.h,
    );
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

  static Widget topIcon() {
    return SvgPicture.asset(
      'assets/icons/top.svg',
      width: 18.51.w,
      height: 18.51.h,
    );
  }

  static Widget walletIcon() {
    return SvgPicture.asset(
      'assets/icons/wallet.svg',
      width: 21.9.w,
      height: 19.05.h,
    );
  }

  static Widget soundIcon() {
    return SvgPicture.asset(
      'assets/icons/sound.svg',
      width: 23.w,
      height: 23.h,
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

  static Widget globalIcon() {
    return SvgPicture.asset(
      'assets/icons/global.svg',
      width: 22.w,
      height: 22.h,
    );
  }

  static Widget facebookIcon() {
    return SvgPicture.asset(
      'assets/icons/facebook.svg',
      width: 22.w,
      height: 22.h,
    );
  }

  static Widget sattingIcon({
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

  static Widget whatsappIcon() {
    return SvgPicture.asset(
      'assets/icons/whatsapp.svg',
      width: 23.6.w,
      height: 24.h,
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

  static Widget picgramIcon() {
    return SvgPicture.asset(
      'assets/icons/picgram.svg',
      width: 18.w,
      height: 18.h,
    );
  }

  static Widget documentIcon() {
    return SvgPicture.asset(
      'assets/icons/document.svg',
      width: 17.14.w,
      height: 20.h,
    );
  }

  static Widget bookingOutlinedIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/bookingOutlined.svg',
      width: width.w,
      height: height.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget infoIcon() {
    return SvgPicture.asset('assets/icons/info.svg', width: 2.w, height: 20.h);
  }

  static Widget returnIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/return.svg',
      width: width.w,
      height: height.h,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static Widget homeIcon({required double width, required double height}) {
    return SvgPicture.asset(
      'assets/icons/home.svg',
      width: width.w,
      height: height.h,
    );
  }

  static Widget homeOutlinedIcon({
    required Color color,
    required double width,
    required double height,
  }) {
    return SvgPicture.asset(
      'assets/icons/homeOutlined.svg',
      width: width.w,
      height: height.h,
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

  static Widget chatOutlinedIcon() {
    return SvgPicture.asset(
      'assets/icons/chatOutlined.svg',
      width: 20.0.w,
      height: 17.5.h,
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

  static Widget filters() {
    return SvgPicture.asset(
      'assets/icons/filters.svg',
      width: 14.54.w,
      height: 9.35.h,
    );
  }

  static Widget edit() {
    return SvgPicture.asset(
      'assets/icons/edit.svg',
      width: 12.15.w,
      height: 17.55.h,
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

  //Gradient
  static Widget get bookingIcon => SvgPicture.asset(
    'assets/icons/bookingGradient.svg',
    width: 18.1.w,
    height: 21.59.h,
  );

  static Widget get chatGradienFullIcon => SvgPicture.asset(
    'assets/icons/chatGradientFull.svg',
    width: 22.43.w,
    height: 19.87.h,
  );

  static Widget get pinHomeLocationIcon => SvgPicture.asset(
    'assets/icons/pinHomeLocation.svg',
    width: 26.w,
    height: 34.5.h,
  );

  static Widget get messaheIcon =>
      SvgPicture.asset('assets/icons/message.svg', width: 18.w, height: 18.h);

  static Widget analysis({bool big = false}) {
    return SvgPicture.asset(
      big ? 'assets/icons/analysis.svg' : 'assets/icons/analysisSmall.svg',
      width: big ? 41.56.w : 14.93.w,
      height: big ? 60.44.h : 21.72.h,
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
  }

  static Widget vaccinations({bool big = false}) {
    return SvgPicture.asset(
      big
          ? 'assets/icons/vaccinations.svg'
          : 'assets/icons/vaccinationsSmall.svg',
      width: big ? 60.44.w : 21.72.w,
      height: big ? 60.44.h : 21.72.h,
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
  }

  static Widget allergies({bool big = false}) {
    return SvgPicture.asset(
      big ? 'assets/icons/allergies.svg' : 'assets/icons/allergiesSmall.svg',
      width: big ? 71.76.w : 23.w,
      height: big ? 64.h : 20.51.h,
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
  }

  static Widget medicalHistory({bool big = false}) {
    return SvgPicture.asset(
      big
          ? 'assets/icons/medicalHistory.svg'
          : 'assets/icons/medicalHistorySmall.svg',
      width: big ? 56.w : 19.41.w,
      height: big ? 64.h : 23.h,
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
  }
}
