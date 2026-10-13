import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/widgets/favorite_doctorLW.dart';

enum FavSelector { doctor, services }

class FavoriteDoctor extends StatefulWidget {
  const new({super.key});

  @override
  State<FavoriteDoctor> createState() => _FavoriteDoctorState();
}

class _FavoriteDoctorState extends State<FavoriteDoctor> {
  FavSelector selected = FavSelector.doctor;
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Favorite',
      backRoute: 'profile',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 31.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _faboriteFilter(context: context),
            if (selected == FavSelector.doctor)
              FavoriteDoctorLW()
            else
              Expanded(
                child: Center(
                  child: Text(
                    'Services are not available yet.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.semiBold16Prime.copyWith(
                      color: AppColors.text2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _faboriteFilter({required BuildContext context}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Sort By',
              style: AppTextStyles.light12White.copyWith(
                color: AppColors.text2,
              ),
            ),
            SizedBox(width: 4.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              decoration: BoxDecoration(
                gradient: AppColors.degradadoAzul,
                borderRadius: BorderRadius.circular(38.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'A',
                    style: AppTextStyles.semiBold14Prime.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Transform.translate(
                    offset: Offset(0, -2.h),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 14.r,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(width: 3.w),
                  Text(
                    'Z',
                    style: AppTextStyles.semiBold14Prime.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 7.w),
            AppButtons.infoOutlinedPrimeBTN(
              horizontalPadding: 10.w,
              verticalPadding: 2.h,
              plaintText: 'Filter',
              onPressed: () => context.pushNamed('filters'),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: AppButtons.singleTextButton(
                isGradient: selected == FavSelector.doctor,
                text: 'Doctors',
                onPressed: () {
                  setState(() {
                    selected = FavSelector.doctor;
                  });
                },

                height: 40.h,
                horizontalPadding: 5.w,
                textStyle: AppTextStyles.semiBold16Prime.copyWith(
                  color: selected == FavSelector.doctor
                      ? Colors.white
                      : AppColors.text2,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: AppButtons.singleTextButton(
                isGradient: selected == FavSelector.services,
                text: 'Services',
                onPressed: () {
                  setState(() {
                    selected = FavSelector.services;
                  });
                },
                height: 40.h,
                horizontalPadding: 5.w,
                textStyle: AppTextStyles.semiBold16Prime.copyWith(
                  color: selected == FavSelector.services
                      ? Colors.white
                      : AppColors.text2,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 19.h),
        AppContainers.appDivider(),
      ],
    );
  }
}
