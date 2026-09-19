import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/app_containers.dart';

class AppIcons {
  static final Widget star = Icon(
    Icons.star,
    size: 12,
    color: AppColors.primary,
  );

  static final Widget starBorder = Icon(
    Icons.star_border,
    size: 12,
    color: AppColors.primary,
  );

  static final Widget favourite = Icon(
    Icons.favorite,
    size: 12,
    color: AppColors.primary,
  );

  static final Widget favouriteBorder = Icon(
    Icons.favorite_border,
    size: 12,
    color: AppColors.primary,
  );

  static final Widget male = Icon(
    Icons.male,
    size: 12,
    color: AppColors.primary,
  );

  static final Widget female = Icon(
    Icons.female,
    size: 12,
    color: AppColors.primary,
  );
  static final Widget booking = SvgPicture.asset(
    'assets/icons/booking.svg',
    width: 18.1,
    height: 21.09,
  );

  static final Widget bookingOutlined = SvgPicture.asset(
    'assets/icons/bookingOutlined.svg',
    width: 18.1,
    height: 21.09,
  );

  static final Widget chat = SvgPicture.asset(
    'assets/icons/message.svg',
    width: 23.53,
    height: 21,
  );

  static final Widget messageOutlined = SvgPicture.asset(
    'assets/icons/messageOutlined.svg',
    width: 23.53,
    height: 21,
  );

  static final Widget home = SvgPicture.asset(
    'assets/icons/home.svg',
    width: 23.12,
    height: 22.36,
  );

  static final Widget homeOutlined = SvgPicture.asset(
    'assets/icons/homeOutlined.svg',
    width: 23.12,
    height: 22.36,
  );

  static final Widget userProfile = SvgPicture.asset(
    'assets/icons/userProfile.svg',
    width: 19,
    height: 20.97,
  );

  static final Widget userProfileOutlined = SvgPicture.asset(
    'assets/icons/userProfileOutlined.svg',
    width: 19,
    height: 20.97,
  );

  static final Widget doctorInfo = SvgPicture.asset(
    'assets/icons/doctorInfo.svg',
    width: 0,
    height: 20,
  );

  static final Widget heartPrimeOutlined = SvgPicture.asset(
    'assets/icons/heartPrimeOutlined.svg',
    width: 20,
    height: 18.18,
  );

  static final Widget returnIcon = SvgPicture.asset(
    'assets/icons/return.svg',
    width: 13.43,
    height: 23.5,
  );

  static final Widget info = SvgPicture.asset(
    'assets/icons/info.svg',
    width: 11.11,
    height: 20,
  );

  static final Widget back = SvgPicture.asset(
    'assets/icons/back.svg',
    width: 8,
    height: 14,
  );

  static final Widget stethoscope = SvgPicture.asset(
    'assets/icons/stethoscope.svg',
    width: 17.18,
    height: 20.62,
  );

  static final Widget pharmacy = SvgPicture.asset(
    'assets/icons/pharmacy.svg',
    width: 19.7,
    height: 20,
  );

  static final Widget record = SvgPicture.asset(
    'assets/icons/record.svg',
    width: 13.16,
    height: 20,
  );

  static final Widget speciality = Icon(
    Icons.add_circle_outline,
    size: 20,
    color: AppColors.primary,
  );

  static final Widget filters = SvgPicture.asset(
    'assets/icons/filters.svg',
    width: 14.54,
    height: 9.35,
  );

  static final Widget edit = SvgPicture.asset(
    'assets/icons/edit.svg',
    width: 12.15,
    height: 17.55,
  );

  static final Widget search = SvgPicture.asset(
    'assets/icons/search.svg',
    width: 12,
    height: 14,
  );

  static final Widget bell = SvgPicture.asset(
    'assets/icons/bell.svg',
    width: 12,
    height: 15,
  );

  static final Widget settings = SvgPicture.asset(
    'assets/icons/settingsBlack.svg',
    width: 15,
    height: 15,
  );

  static final Widget generalMedicine = SvgPicture.asset(
    'assets/icons/generalMedicine.svg',
    width: 32.75,
    height: 40,
  );

  static final Widget ophtamology = SvgPicture.asset(
    'assets/icons/ophtamology.svg',
    width: 40,
    height: 27.88,
  );

  static final Widget dermatology = SvgPicture.asset(
    'assets/icons/dermatology.svg',
    width: 40,
    height: 21.55,
  );

  static final Widget casrdiology = SvgPicture.asset(
    'assets/icons/cardiology.svg',
    width: 40,
    height: 31.29,
  );

  static final Widget gynecology = SvgPicture.asset(
    'assets/icons/gynecology.svg',
    width: 40,
    height: 20.62,
  );

  static final Widget oncology = SvgPicture.asset(
    'assets/icons/oncology.svg',
    width: 40,
    height: 40,
  );

  static final Widget odontology = SvgPicture.asset(
    'assets/icons/odontology.svg',
    width: 35.99,
    height: 40,
  );

  static final Widget orthopedics = SvgPicture.asset(
    'assets/icons/orthopedics.svg',
    width: 40,
    height: 39.15,
  );

  static final Widget otolaryngology = SvgPicture.asset(
    'assets/icons/otolaryngology.svg',
    width: 40,
    height: 34.88,
  );

  static final Widget pinHomeLocation = SvgPicture.asset(
    'assets/icons/pinHomeLocation.svg',
    width: 26,
    height: 34.5,
  );

  static Widget analysis({bool big = false}) {
    return SvgPicture.asset(
      'assets/icons/analysis.svg',
      width: big ? 70 : 43,
      height: big ? 70 : 43,
    );
  }

  static Widget vaccinations({bool big = false}) {
    return SvgPicture.asset(
      'assets/icons/vaccinations.svg',
      width: big ? 70 : 43,
      height: big ? 70 : 43,
    );
  }

  static Widget allergies({bool big = false}) {
    return SvgPicture.asset(
      'assets/icons/allergies.svg',
      width: big ? 70 : 43,
      height: big ? 70 : 43,
    );
  }

  static Widget medicalHistory({bool big = false}) {
    return SvgPicture.asset(
      'assets/icons/medicalHistory.svg',
      width: big ? 70 : 43,
      height: big ? 70 : 43,
    );
  }

  static Widget favouriteContainer() {
    return AppContainers.navigations(
      icon: AppIcons.heartPrimeOutlined,
      text: 'Favourite',
    );
  }

  static Widget doctorsContainer() {
    return AppContainers.navigations(
      icon: AppIcons.stethoscope,
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
}
