import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/app_containers.dart';

class AppIcons {
  //GradientCircles
  static Widget userIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/user.svg',
          width: 18.1.w,
          height: 21.9.h,
        ),
      ),
    );
  }

  static Widget checkIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/check.svg',
          width: 21.w,
          height: 15.75.h,
        ),
      ),
    );
  }

  static Widget closekIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/x.svg',
          width: 12.95.w,
          height: 13.33.h,
        ),
      ),
    );
  }

  static Widget heartIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/heart.svg',
          width: 18.18.w,
          height: 16.36.h,
        ),
      ),
    );
  }

  static Widget heartOutlinedIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/heartOutlined.svg',
          width: 23.w,
          height: 20.h,
        ),
      ),
    );
  }

  static Widget topIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/top.svg',
          width: 18.51.w,
          height: 18.51.h,
        ),
      ),
    );
  }

  static Widget walletIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/wallet.svg',
          width: 21.9.w,
          height: 19.05.h,
        ),
      ),
    );
  }

  static Widget soundIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/sound.svg',
          width: 23.w,
          height: 23.h,
        ),
      ),
    );
  }

  static Widget fingerprintIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/fingerprint.svg',
          width: 23.w,
          height: 23.h,
        ),
      ),
    );
  }

  static Widget privacyIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/privacy.svg',
          width: 18.1.w,
          height: 20.95.h,
        ),
      ),
    );
  }

  static Widget globalIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/global.svg',
          width: 22.w,
          height: 22.h,
        ),
      ),
    );
  }

  static Widget facebookIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/facebook.svg',
          width: 22.w,
          height: 22.h,
        ),
      ),
    );
  }

  static Widget sattingIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/settings.svg',
          width: 23.81.w,
          height: 23.81.h,
        ),
      ),
    );
  }

  static Widget whatsappIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/whatsapp.svg',
          width: 23.6.w,
          height: 24.h,
        ),
      ),
    );
  }

  static Widget googleIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/google.svg',
          width: 18.w,
          height: 18.h,
        ),
      ),
    );
  }

  static Widget questionsIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/questions.svg',
          width: 11.w,
          height: 21.h,
        ),
      ),
    );
  }

  static Widget logOutIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/logOut.svg',
          width: 19.05.w,
          height: 16.1.h,
        ),
      ),
    );
  }

  static Widget picgramIcons() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/picgram.svg',
          width: 18.w,
          height: 18.h,
        ),
      ),
    );
  }

  //Square
  static Widget documentOutlinedIcons() {
    return Container(
      width: 46.w,
      height: 44.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(9.r),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/icons/documentOutlined.svg',
        width: 18.w,
        height: 21.h,
      ),
    );
  }

  //Gradient outlined icons
  static Widget get bookingGradientOutlinedIcon => SvgPicture.asset(
    'assets/icons/bookingGradientOutlined.svg',
    width: 18.1.w,
    height: 21.09.h,
  );

  static Widget get infoGradientIcon => SvgPicture.asset(
    'assets/icons/infoGradient.svg',
    width: 0.w,
    height: 20.h,
  );

  static Widget get heartGradientOutlinedIcon => SvgPicture.asset(
    'assets/icons/heartGradientOutlined.svg',
    width: 20.w,
    height: 18.18.h,
  );

  static Widget get returnGradientIcon => SvgPicture.asset(
    'assets/icons/returnGradient.svg',
    width: 13.43.w,
    height: 23.5.h,
  );

  static Widget get questionMarkGradientIcon => SvgPicture.asset(
    'assets/icons/questionMarkGradient.svg',
    width: 11.11.w,
    height: 20.h,
  );

  static Widget get returnIcon =>
      SvgPicture.asset('assets/icons/return.svg', width: 8.w, height: 14.h);

  static Widget get homeGradientOutlinedIcon => SvgPicture.asset(
    'assets/icons/homeGradientOutlined.svg',
    width: 23.12.w,
    height: 22.36.h,
  );

  static Widget get stethoscopeIcon => SvgPicture.asset(
    'assets/icons/stethoscope.svg',
    width: 17.18.w,
    height: 20.62.h,
  );

  static Widget get chatOutlinedIcon => SvgPicture.asset(
    'assets/icons/chatOutlined.svg',
    width: 23.53.w,
    height: 21.h,
  );

  static Widget get userProfileGradientOutlined => SvgPicture.asset(
    'assets/icons/userGradientOutlined.svg',
    width: 19.w,
    height: 20.97.h,
  );

  static Widget get pharmacy => SvgPicture.asset(
    'assets/icons/pharmacy.svg',
    width: 19.7.w,
    height: 20.h,
  );

  static Widget get record =>
      SvgPicture.asset('assets/icons/record.svg', width: 13.16.w, height: 20.h);

  static Widget get speciality =>
      Icon(Icons.add_circle_outline, size: 20.r, color: AppColors.primary);

  ///WhiteCircles
  static Widget get bell =>
      SvgPicture.asset('assets/icons/bell.svg', width: 12.w, height: 15.h);

  static Widget settings() {
    return CircleAvatar(
      radius: 14.r,
      backgroundColor: Colors.red,
      child: SvgPicture.asset(
        'assets/icons/settingsBlack.svg',
        width: 15.w,
        height: 15.h,
      ),
    );
  }

  static Widget search() {
    return CircleAvatar(
      radius: 14.r,
      backgroundColor: Colors.red,
      child: SvgPicture.asset(
        'assets/icons/search.svg',
        width: 12.w,
        height: 14.h,
      ),
    );
  }

  static Widget filters() {
    return CircleAvatar(
      radius: 14.r,
      backgroundColor: Colors.red,
      child: SvgPicture.asset(
        'assets/icons/filters.svg',
        width: 14.54.w,
        height: 9.35.h,
      ),
    );
  }

  static Widget edit() {
    return CircleAvatar(
      radius: 14.r,
      backgroundColor: Colors.red,
      child: SvgPicture.asset(
        'assets/icons/edit.svg',
        width: 12.15.w,
        height: 17.55.h,
      ),
    );
  }

  //NavigationGradient
  static Widget doctorsContainer() {
    return AppContainers.navigations(
      icon: AppIcons.stethoscopeIcon,
      text: 'Doctors',
    );
  }

  static Widget pharmasyContainer() {
    return AppContainers.navigations(icon: AppIcons.pharmacy, text: 'Pharmacy');
  }

  static Widget specialtiesContainer() {
    return AppContainers.navigations(
      icon: AppIcons.speciality,
      text: 'Specialties',
    );
  }

  static Widget recordContainer() {
    return AppContainers.navigations(icon: AppIcons.record, text: 'Record');
  }

  //Medical specialities
  static Widget get generalMedicine => SvgPicture.asset(
    'assets/icons/generalMedicine.svg',
    width: 32.75.w,
    height: 40.h,
  );

  static Widget get ophtamology => SvgPicture.asset(
    'assets/icons/ophtamology.svg',
    width: 40.w,
    height: 27.88.h,
  );

  static Widget get dermatology => SvgPicture.asset(
    'assets/icons/dermatology.svg',
    width: 40.w,
    height: 21.55.h,
  );

  static Widget get casrdiology => SvgPicture.asset(
    'assets/icons/cardiology.svg',
    width: 40.w,
    height: 31.29.h,
  );

  static Widget get gynecology => SvgPicture.asset(
    'assets/icons/gynecology.svg',
    width: 40.w,
    height: 20.62.h,
  );

  static Widget get oncology =>
      SvgPicture.asset('assets/icons/oncology.svg', width: 40.w, height: 40.h);

  static Widget get odontology => SvgPicture.asset(
    'assets/icons/odontology.svg',
    width: 35.99.w,
    height: 40.h,
  );

  static Widget get orthopedics => SvgPicture.asset(
    'assets/icons/orthopedics.svg',
    width: 40.w,
    height: 39.15.h,
  );

  static Widget get otolaryngology => SvgPicture.asset(
    'assets/icons/otolaryngology.svg',
    width: 40.w,
    height: 34.88.h,
  );

  //Gradient
  static Widget get bookingGradientIcon => SvgPicture.asset(
    'assets/icons/bookingGradient.svg',
    width: 18.1.w,
    height: 21.59.h,
  );
  static Widget get homeGradientIcon => SvgPicture.asset(
    'assets/icons/homeGradient.svg',
    width: 22.09.w,
    height: 21.36.h,
  );
  static Widget get chatGradienFullIcon => SvgPicture.asset(
    'assets/icons/chatGradientFull.svg',
    width: 22.43.w,
    height: 19.87.h,
  );

  static Widget get userGradientIcon => SvgPicture.asset(
    'assets/icons/userGradient.svg',
    width: 19.w,
    height: 20.09.h,
  );
  static Widget get pinHomeLocation => SvgPicture.asset(
    'assets/icons/pinHomeLocation.svg',
    width: 26.w,
    height: 34.5.h,
  );

  //Medical Record Icons
  static Widget analysis({bool big = false}) {
    return SvgPicture.asset(
      'assets/icons/analysis.svg',
      width: big ? 70.w : 43.w,
      height: big ? 70.h : 43.h,
    );
  }

  static Widget vaccinations({bool big = false}) {
    return SvgPicture.asset(
      'assets/icons/vaccinations.svg',
      width: big ? 70.w : 43.w,
      height: big ? 70.h : 43.h,
    );
  }

  static Widget allergies({bool big = false}) {
    return SvgPicture.asset(
      'assets/icons/allergies.svg',
      width: big ? 70.w : 43.w,
      height: big ? 70.h : 43.h,
    );
  }

  static Widget medicalHistory({bool big = false}) {
    return SvgPicture.asset(
      'assets/icons/medicalHistory.svg',
      width: big ? 70.w : 43.w,
      height: big ? 70.h : 43.h,
    );
  }
}
