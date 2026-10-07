import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.child,
    required this.location,
  });

  final Widget child;
  final String location;

  int get currentIndex {
    if (location == '/profile') return 2;
    if (location == '/apointment') return 3;
    if (location == '/') return 1;
    if (['/login', '/create_account', '/set_password'].contains(location)) {
      return 2;
    }
    if ([
      '/specialties',
      '/doc_by_specialty',
      '/doctors',
      '/doctors_info',
      '/schedule',
    ].contains(location)) {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: child,
      bottomNavigationBar: Material(
        color: AppColors.elements,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _item(
                  context,
                  0,
                  'Home',
                  'home',
                  AppIcons.homeOutlinedIcon(
                    width: 24.w,
                    height: 24.h,
                    color: AppColors.primary,
                  ),
                ),
                _item(
                  context,
                  1,
                  'Chat',
                  'welcome',
                  AppIcons.chatOutlinedIcon(width: 24.w, height: 24.h),
                ),
                _item(
                  context,
                  2,
                  'Profile',
                  'profile',
                  AppIcons.userOutlinedIcon(
                    width: 24.w,
                    height: 24.h,
                    color: AppColors.primary,
                  ),
                ),
                _item(
                  context,
                  3,
                  'Appointments',
                  'apointment',
                  AppIcons.bookingOutlinedIcon(
                    width: 24.w,
                    height: 24.h,
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

  Widget _item(
    BuildContext context,
    int index,
    String label,
    String route,
    Widget icon,
  ) {
    return Semantics(
      selected: currentIndex == index,
      child: IconButton(
        tooltip: label,
        onPressed: () => context.goNamed(route),
        style: IconButton.styleFrom(
          backgroundColor: currentIndex == index
              ? AppColors.primary.withValues(alpha: 0.08)
              : Colors.transparent,
        ),
        icon: icon,
      ),
    );
  }
}
