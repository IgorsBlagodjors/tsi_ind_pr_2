import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';

class AppButtons {
  // Rounded square button style
  static ButtonStyle rectangle() {
    return IconButton.styleFrom(
      fixedSize: const Size(46, 44),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    );
  }

  // Circle button style
  static ButtonStyle ellipse() {
    return IconButton.styleFrom(
      fixedSize: const Size(50, 50),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  static Widget user() {
    return IconButton(
      onPressed: () {},
      icon: SvgPicture.asset(
        'assets/icons/user.svg',
        width: 18.1,
        height: 21.9,
      ),
      style: ellipse(),
    );
  }

  static Widget confirm() {
    return IconButton(
      onPressed: () {},
      icon: SvgPicture.asset(
        'assets/icons/check.svg',
        width: 21,
        height: 15.75,
      ),
      style: ellipse(),
    );
  }

  static Widget close() {
    return IconButton(
      onPressed: () {},
      icon: SvgPicture.asset('assets/icons/x.svg', width: 13.33, height: 13.33),
      style: ellipse(),
    );
  }

  static Widget favorite() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.favorite_border, size: 30),
      style: ellipse(),
    );
  }

  static Widget achievement() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.workspace_premium_outlined, size: 30),
      style: ellipse(),
    );
  }

  static Widget favoriteFilled() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.favorite, size: 30),
      style: ellipse(),
    );
  }

  static Widget wallet() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.account_balance_wallet_outlined, size: 30),
      style: ellipse(),
    );
  }

  static Widget support() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.headset_mic_outlined, size: 30),
      style: ellipse(),
    );
  }

  static Widget fingerprint() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.fingerprint, size: 30),
      style: ellipse(),
    );
  }

  static Widget lock() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.lock_outline, size: 30),
      style: ellipse(),
    );
  }

  static Widget language() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.language, size: 30),
      style: ellipse(),
    );
  }

  static Widget facebook() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.facebook, size: 30),
      style: ellipse(),
    );
  }

  static Widget settings() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.settings_outlined, size: 30),
      style: ellipse(),
    );
  }

  static Widget phone() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.phone_outlined, size: 30),
      style: ellipse(),
    );
  }

  static Widget help() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.question_mark, size: 30),
      style: ellipse(),
    );
  }

  static Widget logout() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.logout, size: 30),
      style: ellipse(),
    );
  }

  static Widget camera() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.camera_alt_outlined, size: 30),
      style: ellipse(),
    );
  }

  static Widget google() {
    return IconButton(
      onPressed: () {},
      icon: const Text(
        'G',
        style: TextStyle(
          color: Colors.white,
          fontSize: 27,
          fontWeight: FontWeight.w300,
        ),
      ),
      style: IconButton.styleFrom(
        fixedSize: const Size(50, 50),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  static Widget booking() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.calendar_month_outlined, size: 21),
      style: rectangle(),
    );
  }

  static Widget documents() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.description_outlined, size: 21),
      style: rectangle(),
    );
  }

  static Widget messages() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.chat_bubble_outline, size: 21),
      style: rectangle(),
    );
  }
}
