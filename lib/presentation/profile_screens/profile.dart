import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/widgets/profile_menu_tile.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class Profile extends StatefulWidget {
  const new({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _profileHeader(context: context),
            SizedBox(height: 28.h),
            _profileSettings(context: context),
          ],
        ),
      ),
    );
  }

  static Widget _profileHeader({required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.degradadoAzul),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 21.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AppButtons.backBTN(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.pushNamed('home');
                        }
                      },
                    ),
                  ),
                ),
                Text(
                  'My Profile',
                  style: AppTextStyles.semiBold24Prime.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 23.h),
            Padding(
              padding: EdgeInsets.only(left: 50.w, right: 39.w),
              child: Row(
                children: [
                  Stack(
                    children: [
                      AppContainers.profileAvatar(
                        image: AssetImage('assets/avatars/Perfil.png'),
                        radius: 54.5.r,
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: AppButtons.circleIconBTN(
                          onPressed: () =>
                              showActionMessage(context, 'Change Image'),
                          icon: AppIcons.edit(
                            width: 12.15.w,
                            height: 17.55.h,
                            color: Colors.white,
                          ),
                          radius: 13.5.r,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          'Jane Doe',
                          style: AppTextStyles.semiBold24Prime.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          '+123 567 89000',
                          style: AppTextStyles.regular14Black.copyWith(
                            color: Colors.white,
                            height: 1.h,
                          ),
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          'Janedoe@example.com',
                          style: AppTextStyles.regular14Black.copyWith(
                            color: Colors.white,
                            height: 1.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 31.h),
          ],
        ),
      ),
    );
  }

  static Widget _profileSettings({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 31.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileMenuTile(
            onPressed: () => context.pushNamed('edit_profile'),
            plainText: 'Profile',
            icon: AppIcons.userOutlinedIcon(
              color: Colors.white,
              width: 18.1.w,
              height: 21.9.h,
            ),
          ),
          ProfileMenuTile(
            onPressed: () => showActionMessage(context, 'Favorite'),
            plainText: 'Favorite',
            icon: AppIcons.heartOutlinedIcon(
              color: Colors.white,
              width: 23.w,
              height: 20.h,
            ),
          ),
          ProfileMenuTile(
            onPressed: () => showActionMessage(context, 'Payment Method'),
            plainText: 'Payment Method',
            icon: AppIcons.walletIcon(),
          ),
          ProfileMenuTile(
            onPressed: () => showActionMessage(context, 'Privacy Policy'),
            plainText: 'Privacy Policy',
            icon: AppIcons.privacyIcon(),
          ),
          ProfileMenuTile(
            onPressed: () => showActionMessage(context, 'Settings'),
            plainText: 'Settings',
            icon: AppIcons.settingIcon(
              color: Colors.white,
              width: 23.81.w,
              height: 23.81.h,
            ),
          ),
          ProfileMenuTile(
            onPressed: () => showActionMessage(context, 'Help'),
            plainText: 'Help',
            icon: AppIcons.questionsIcon(
              color: Colors.white,
              width: 11.w,
              height: 21.h,
            ),
          ),
          ProfileMenuTile(
            onPressed: () => showActionMessage(context, 'Logout'),

            plainText: 'Logout',
            icon: AppIcons.logOutIcon(),
          ),
        ],
      ),
    );
  }
}
