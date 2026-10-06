import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class FavoriteDoctorlw extends StatefulWidget {
  const new({super.key, required this.doctorList});
  final List<Doctor> doctorList;

  @override
  State<FavoriteDoctorlw> createState() => _FavoriteDoctorlwState();
}

class _FavoriteDoctorlwState extends State<FavoriteDoctorlw> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => AppContainers.appDivider(),
        itemCount: widget.doctorList.length,

        itemBuilder: (context, index) {
          final data = widget.doctorList[index];
          return Column(
            children: [
              SizedBox(height: 17.h),
              Row(
                children: [
                  AppContainers.profileAvatar(
                    image: AssetImage(data.image),
                    radius: 35.r,
                  ),
                  Expanded(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 17.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Professional Doctor',
                                    style: AppTextStyles.regular12Prime
                                        .copyWith(color: AppColors.text2),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    data.name,
                                    style: AppTextStyles.medium15Prime.copyWith(
                                      height: 1.h,
                                    ),
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    data.specialization,
                                    style: AppTextStyles.light13Prime.copyWith(
                                      color: AppColors.text2,
                                      height: 1.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 11.h),

                            Row(
                              children: [
                                Expanded(
                                  child: AppButtons.singleTextButton(
                                    isGradient: true,
                                    text: 'Make Appointment',
                                    onPressed: () => context.pushNamed(
                                      'schedule',
                                      extra: data,
                                    ),
                                    height: 20.h,
                                    horizontalPadding: 10.w,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 17.h),
                          ],
                        ),
                        Positioned(
                          bottom: 52,
                          right: 17,
                          child: GestureDetector(
                            onTap: () =>
                                showActionMessage(context, 'Heart pressed'),
                            child: AppIcons.heartIcon(color: AppColors.primary),
                          ),
                        ),
                        Positioned(
                          left: -5,
                          child: AppButtons.gradientCircleIconBTN(
                            onPressed: () =>
                                showActionMessage(context, 'top Icon'),
                            icon: AppIcons.topIcon(
                              width: 10.w,
                              height: 10.84.h,
                            ),
                            radius: 8.725.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
