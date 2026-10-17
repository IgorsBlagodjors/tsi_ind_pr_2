import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/users/profile_repository.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_state.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

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
                      AppContainers.networkImage(imageUrl: doctor.image),
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
                            Row(
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
                                Spacer(),
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

  Future<void> _toggleFavoriteDoctor({
    required String docId,
    required removeIfIsFav,
  }) async {
    final uid = (context.read<ProfileCubit>().state as ProfileLoaded).user.id;
    FocusScope.of(context).unfocus();
    try {
      await context.read<ProfileRepository>().setFavoriteDoctor(
        uid: uid,
        doctorId: docId,
        removeIfIsFav: removeIfIsFav,
      );
      if (mounted) showActionMessage(context, 'Profile saved.');
    } catch (error) {
      if (mounted) showActionMessage(context, profileErrorMessage(error));
    }
  }
}
