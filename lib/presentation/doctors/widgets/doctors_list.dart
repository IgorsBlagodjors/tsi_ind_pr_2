import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/domain/models/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_state.dart';

class DoctorsLw extends StatefulWidget {
  const new({super.key, required this.doctorList});
  final List<Doctor> doctorList;

  @override
  State<DoctorsLw> createState() => _DoctorsLwState();
}

class _DoctorsLwState extends State<DoctorsLw> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final user = state.user;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 31.w),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 13.h),
          itemCount: widget.doctorList.length,
          itemBuilder: (context, index) {
            final doctor = widget.doctorList[index];
            final isFavorite = user.favoriteDoctorIds.contains(doctor.id);
            return SizedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      AppContainers.cachedNetworkImage(
                        imageUrl: doctor.image,
                        size: 87,
                      ),
                      SizedBox(width: 13.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              doctor.name,
                              style: AppTextStyles.medium15Prime,
                            ),
                            Text(
                              doctor.specialization,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.light13Prime.copyWith(
                                color: AppColors.text2,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Wrap(
                              spacing: 4.w,
                              runSpacing: 4.h,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                AppButtons.infoOutlinedPrimeBTN(
                                  onPressed: () => context.pushNamed(
                                    'doctors_info',
                                    extra: doctor,
                                  ),
                                  plaintText: 'Info',
                                  horizontalPadding: 15.w,
                                  verticalPadding: 2,
                                ),
                                IconButton(
                                  tooltip: 'Schedule',
                                  onPressed: () => context.pushNamed(
                                    'schedule',
                                    extra: doctor,
                                  ),
                                  icon: AppIcons.bookingOutlinedIcon(
                                    color: AppColors.primary,
                                    width: 13.w,
                                    height: 14.82.h,
                                  ),
                                ),
                                AppIcons.questionsIcon(
                                  color: AppColors.primary,
                                  width: 14.w,
                                  height: 14.h,
                                ),

                                AppIcons.favIcon(
                                  isFavorite: isFavorite,
                                  onPressed: () {
                                    context
                                        .read<ProfileCubit>()
                                        .toggleFavoriteDoctor(doctor.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Divider(thickness: 1, height: 1.h, color: AppColors.elements),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
