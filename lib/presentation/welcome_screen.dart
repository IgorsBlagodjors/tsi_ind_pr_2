import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/design_system/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/text_styles.dart';

class WelcomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 52),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                SvgPicture.asset('assets/app_logo_splash/app_logo.svg'),
                SizedBox(height: 27.h),
                SvgPicture.asset('assets/app_logo_splash/health_track.svg'),
                SizedBox(height: 80.h),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                  'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.lague12Light,
                ),
                SizedBox(height: 40.h),
                AppButtons.authButton(
                  text: 'Log in',
                  onPressed: () => context.pushNamed('login'),
                  isGradient: true,
                ),
                SizedBox(height: 7.h),
                AppButtons.authButton(
                  text: 'Sign up',
                  onPressed: () => print('sign in pressed'),
                ),
                SizedBox(height: 67.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
