import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_state.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class FavoriteDoctorLW extends StatefulWidget {
  const new({super.key});

  @override
  State<FavoriteDoctorLW> createState() => _FavoriteDoctorLWState();
}

class _FavoriteDoctorLWState extends State<FavoriteDoctorLW> {
  late final Stream<List<Doctor>> _doctors;

  @override
  void initState() {
    super.initState();
    _doctors = context.read<DoctorsRepository>().watchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final user = state.user;
    return StreamBuilder<List<Doctor>>(
      stream: _doctors,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Expanded(
            child: Center(child: Text('Unable to load doctors.')),
          );
        }
        if (!snapshot.hasData) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final favorites = snapshot.data!
            .where((doctor) => user.favoriteDoctorIds.contains(doctor.id))
            .toList();
        if (favorites.isEmpty) {
          return const Expanded(
            child: Center(child: Text('No favorite doctors yet.')),
          );
        }
        return _buildList(favorites);
      },
    );
  }

  Widget _buildList(List<Doctor> favorites) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => AppContainers.appDivider(),
        itemCount: favorites.length,

        itemBuilder: (context, index) {
          final data = favorites[index];
          return Column(
            children: [
              SizedBox(height: 17.h),
              Row(
                children: [
                  AppContainers.networkImage(imageUrl: data.image),
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
                            onTap: () => showActionMessage(
                              context,
                              'Saving favorites is not connected yet.',
                            ),
                            child: AppIcons.heartIcon(color: AppColors.primary),
                          ),
                        ),
                        Positioned(
                          left: -5,
                          child: AppButtons.gradientCircleIconBTN(
                            onPressed: () =>
                                context.pushNamed('doctors_info', extra: data),
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
