import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/doctor_favorite/widgets/doctor_details_badges.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class DoctorInfoHeader extends StatelessWidget {
  const new({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 234.h,
      child: Stack(
        children: [
          Container(
            height: 220.h,
            decoration: BoxDecoration(gradient: AppColors.degradadoAzul),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(right: 26.w, left: 10.w),
                  child: Row(
                    children: [
                      AppButtons.backBTN(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.goNamed('doctors');
                          }
                        },
                      ),

                      AppButtons.textWithImageBTNWhite(
                        paddingLeft: 9.w,
                        paddingRight: 9.w,
                        onPressed: () =>
                            context.pushNamed('schedule', extra: doctor),
                        height: 23.h,
                        textData: Text(
                          'Schedule',
                          style: AppTextStyles.medium12Prime,
                        ),
                        icon: AppIcons.bookingOutlinedIcon(
                          color: AppColors.primary,
                          width: 10,
                          height: 11,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      AppButtons.circleIconBTN(
                        radius: 10.5.r,
                        onPressed: () => showActionMessage(context, 'phone'),
                        icon: AppIcons.phoneIcon(),
                      ),
                      SizedBox(width: 3.w),
                      AppButtons.circleIconBTN(
                        radius: 10.5.r,
                        onPressed: () => showActionMessage(context, 'camera'),
                        icon: AppIcons.cameraIcon(),
                      ),
                      SizedBox(width: 3.w),
                      AppButtons.circleIconBTN(
                        radius: 10.5.r,
                        onPressed: () => showActionMessage(context, 'chat'),
                        icon: AppIcons.chatOutlinedIcon(
                          width: 12.w,
                          height: 11.h,
                        ),
                      ),
                      Spacer(),
                      AppButtons.circleIconBTN(
                        fullWhite: true,
                        radius: 10.5.r,
                        onPressed: () =>
                            showActionMessage(context, 'questions'),
                        icon: Icon(
                          Icons.question_mark,
                          size: 12.w,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      AppButtons.circleIconBTN(
                        fullWhite: true,
                        radius: 10.5.r,
                        onPressed: () =>
                            showActionMessage(context, 'questions'),
                        icon: Icon(
                          Icons.favorite_border,
                          size: 12.w,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 52.w, right: 26.w),
                  child: Row(
                    children: [
                      AppContainers.profileAvatar(
                        image: AssetImage(doctor.image),
                        radius: 47.5.r,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.semiBold16Prime.copyWith(
                                color: Colors.white,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              doctor.specialization,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.regular14Black.copyWith(
                                color: Colors.white,
                                height: 1.0,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                AppButtons.textWithImageBTNWhite(
                                  paddingLeft: 5.w,
                                  paddingRight: 15.w,
                                  onPressed: () =>
                                      showActionMessage(context, 'star'),
                                  height: 23.h,
                                  textData: Text(
                                    '5',
                                    style: AppTextStyles.light12White.copyWith(
                                      color: AppColors.text2,
                                    ),
                                  ),
                                  textOffset: Offset(0, 1.h),
                                  icon: Icon(
                                    Icons.star,
                                    size: 13.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                AppButtons.textWithImageBTNWhite(
                                  paddingLeft: 5.w,
                                  paddingRight: 15.w,
                                  onPressed: () =>
                                      showActionMessage(context, 'chat'),
                                  height: 23.h,
                                  textData: Text(
                                    '40',
                                    style: AppTextStyles.light12White.copyWith(
                                      color: AppColors.text2,
                                    ),
                                  ),
                                  textOffset: Offset(0, 1.h),
                                  icon: AppIcons.messageOutlinedIcon(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 31.w,
            right: 31.w,
            bottom: 0,
            child: const DoctorDetailsBadges(),
          ),
        ],
      ),
    );
  }
}
