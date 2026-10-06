import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/widgets/favorite_doctorLW.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class FavoriteDoctor extends StatefulWidget {
  const new({super.key});

  @override
  State<FavoriteDoctor> createState() => _FavoriteDoctorState();
}

class _FavoriteDoctorState extends State<FavoriteDoctor> {
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Favorite',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 31.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _faboriteFilter(context: context),
            FavoriteDoctorlw(doctorList: getFavDoctors()),
          ],
        ),
      ),
    );
  }

  static Widget _faboriteFilter({required BuildContext context}) {
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
              onPressed: () => showActionMessage(context, 'Filter'),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: AppButtons.singleTextButton(
                isGradient: true,
                text: 'Doctors',
                onPressed: () => showActionMessage(context, 'Doctors'),
                height: 40.h,
                horizontalPadding: 5.w,
                textStyle: AppTextStyles.semiBold16Prime.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: AppButtons.singleTextButton(
                isGradient: false,
                textIsBlack: true,
                text: 'Services',
                onPressed: () => showActionMessage(context, 'Services'),
                height: 40.h,
                horizontalPadding: 5.w,
                textStyle: AppTextStyles.semiBold16Prime.copyWith(
                  color: AppColors.text2,
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
