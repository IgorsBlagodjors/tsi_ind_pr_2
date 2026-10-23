import 'package:tsi_ind_pr_2/domain/filters/doctor_filters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/domain/repositories/doctors_repository.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/domain/models/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class FavoriteDoctorLW extends StatefulWidget {
  const FavoriteDoctorLW({super.key, required this.sortOrder, this.filters});

  final SortOrder sortOrder;
  final DoctorFilters? filters;

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
    return Expanded(
      child: StreamBuilder<List<Doctor>>(
        stream: _doctors,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load doctors.'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final favorites =
              snapshot.data!
                  .where((doctor) => user.favoriteDoctorIds.contains(doctor.id))
                  .toList()
                ..sort((a, b) {
                  final comparison = a.name.toLowerCase().compareTo(
                    b.name.toLowerCase(),
                  );
                  return widget.sortOrder == SortOrder.ascending
                      ? comparison
                      : -comparison;
                });
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorite doctors yet.'));
          }
          final visible = favorites
              .where((doctor) => widget.filters?.matches(doctor) ?? true)
              .toList();
          if (visible.isEmpty) {
            return const Center(child: Text('No doctors match your filters.'));
          }
          return _buildList(visible);
        },
      ),
    );
  }

  Widget _buildList(List<Doctor> doctors) {
    return ListView.separated(
      separatorBuilder: (context, index) => AppContainers.appDivider(),
      itemCount: doctors.length,

      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return Column(
          children: [
            SizedBox(height: 17.h),
            Row(
              children: [
                AppContainers.cachedNetworkImage(
                  imageUrl: doctor.image,
                  size: 87,
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
                                  style: AppTextStyles.regular12Prime.copyWith(
                                    color: AppColors.text2,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  doctor.name,
                                  style: AppTextStyles.medium15Prime.copyWith(
                                    height: 1.h,
                                  ),
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  doctor.specialization,
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
                                    extra: doctor,
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
                        bottom: 45,
                        right: 17,
                        child: AppIcons.favIcon(
                          isFavorite: true,
                          onPressed: () => context
                              .read<ProfileCubit>()
                              .toggleFavoriteDoctor(doctor.id),
                        ),
                      ),
                      Positioned(
                        left: -5,
                        child: AppButtons.gradientCircleIconBTN(
                          onPressed: () =>
                              context.pushNamed('doctors_info', extra: doctor),
                          icon: AppIcons.topIcon(width: 10.w, height: 10.84.h),
                          radius: 8.725.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
          ],
        );
      },
    );
  }
}
