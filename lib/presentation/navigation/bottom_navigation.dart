import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_tappable.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/log_in.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/pages/set_password.dart';
import 'package:tsi_ind_pr_2/presentation/home/home_page.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/specialties.dart';
import 'package:tsi_ind_pr_2/presentation/welcome/welcome_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> pages = const [
    HomePage(),
    WelcomeScreen(),
    LogIn(),
    Specialties(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Material(
        color: AppColors.elements,
        elevation: 8,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _item(
                  0,
                  'Home',
                  AppIcons.homeOutlinedIcon(
                    width: 23.12,
                    height: 22.36,
                    color: AppColors.primary,
                  ),
                ),
                _item(1, 'Chat', AppIcons.chatOutlinedIcon()),
                _item(
                  2,
                  'Profile',
                  AppIcons.userOutlinedIcon(
                    width: 19,
                    height: 20.97,
                    color: AppColors.primary,
                  ),
                ),
                _item(
                  3,
                  'Booking',
                  AppIcons.bookingOutlinedIcon(
                    width: 19,
                    height: 22,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(int index, String label, Widget icon) {
    final selected = currentIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTappable(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected
                ? AppColors.primary.withValues(alpha: 0.12)
                : Colors.transparent,
          ),
          onTap: () {
            setState(() {
              currentIndex = index;
            });
          },
          child: icon,
        ),
      ],
    );
  }
}
