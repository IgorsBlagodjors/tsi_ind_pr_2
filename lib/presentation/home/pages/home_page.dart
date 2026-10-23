import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/core/constants/app_constants.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_state.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_selectors.dart';
import 'package:tsi_ind_pr_2/presentation/home/widgets/section_header.dart';
import 'package:tsi_ind_pr_2/presentation/home/widgets/schedule_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Header(),
              SizedBox(height: 31.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w),
                child: SectionHeader(
                  title: 'Categories',
                  onPressed: () => context.pushNamed('specialties'),
                ),
              ),
              SizedBox(height: 13.h),
              SpecialtiesSection(),
              SizedBox(height: 19.h),
              const ScheduleSection(),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w),
                child: SectionHeader(
                  title: 'Specialties',
                  onPressed: () => context.pushNamed('specialties'),
                ),
              ),
              SizedBox(height: 18.h),
              SpecialitySection(),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecialitySection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.w,
      runSpacing: 15.h,
      children: [
        AppSelectors.specialitySelector(
          fontSize: 13,
          onPressed: () => context.pushNamed(
            'doc_by_specialty',
            extra: DoctorType.cardiology,
          ),
          icon: AppIcons.cardiology(color: Colors.white),
          text: 'Cardiology',
          isClicked: true,
        ),
        AppSelectors.specialitySelector(
          fontSize: 13,
          onPressed: () => context.pushNamed(
            'doc_by_specialty',
            extra: DoctorType.dermatology,
          ),
          icon: AppIcons.dermatology(color: Colors.white),
          text: 'Dermatology',
          isClicked: true,
        ),
        AppSelectors.specialitySelector(
          fontSize: 13,
          onPressed: () => context.pushNamed(
            'doc_by_specialty',
            extra: DoctorType.generalMedicine,
          ),
          icon: AppIcons.generalMedicine(color: Colors.white),
          text: 'General medicine',
          isClicked: true,
        ),
        AppSelectors.specialitySelector(
          fontSize: 13,
          onPressed: () => context.pushNamed(
            'doc_by_specialty',
            extra: DoctorType.gynecology,
          ),
          icon: AppIcons.gynecology(color: Colors.white),
          text: 'Gynecology',
          isClicked: true,
        ),
        AppSelectors.specialitySelector(
          fontSize: 13,
          onPressed: () => context.pushNamed(
            'doc_by_specialty',
            extra: DoctorType.odontology,
          ),
          icon: AppIcons.odontology(color: Colors.white),
          text: 'Odontology',
          isClicked: true,
        ),
        AppSelectors.specialitySelector(
          fontSize: 13,
          onPressed: () =>
              context.pushNamed('doc_by_specialty', extra: DoctorType.oncology),
          icon: AppIcons.oncology(color: Colors.white),
          text: 'Oncology',
          isClicked: true,
        ),
      ],
    );
  }
}

class SpecialtiesSection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 31.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppContainers.navigations(
            icon: AppIcons.heartOutlinedIcon(
              color: AppColors.primary,
              width: 20,
              height: 18.8,
            ),
            text: 'Favorite',
            onTap: () => context.pushNamed('favorite_doctor'),
          ),
          AppContainers.navigations(
            icon: AppIcons.stethoscopeIcon(),
            text: 'Doctors',
            onTap: () => context.pushNamed('doctors'),
          ),
          AppContainers.navigations(
            icon: AppIcons.pharmacyIcon(),
            text: 'Pharmacy',
            onTap: () =>
                showActionMessage(context, 'Pharmacy is not available yet.'),
          ),
          AppContainers.navigations(
            icon: AppIcons.speciality(),
            text: 'Specialties',
            onTap: () {
              context.pushNamed('specialties');
            },
          ),
          AppContainers.navigations(
            icon: AppIcons.record(),
            text: 'Record',
            onTap: () => showActionMessage(
              context,
              'Medical records are not available yet.',
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    if (state is! ProfileLoaded) return const SizedBox.shrink();
    final user = state.user;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 31.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppContainers.whiteCircleContainer(
            radius: 14,
            hasNotification: true,
            icon: AppIcons.bell,
            onTap: () => showActionMessage(
              context,
              'Notifications are not available yet.',
            ),
          ),
          SizedBox(width: 4.w),
          AppContainers.whiteCircleContainer(
            radius: 14,
            onTap: () =>
                showActionMessage(context, 'Settings are not available yet.'),
            icon: AppIcons.settingIcon(
              color: Colors.black,
              width: 15,
              height: 15,
            ),
          ),
          SizedBox(width: 4.w),

          AppContainers.whiteCircleContainer(
            radius: 14,
            icon: AppIcons.search(),
            onTap: () => context.pushNamed('doctors'),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Hi, WelcomeBack',
                        style: AppTextStyles.light13Prime.copyWith(height: 1),
                      ),
                      Text(
                        user.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.regular14Black.copyWith(height: 1),
                      ),
                    ],
                  ),
                ),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () => context.pushNamed('profile'),
                      child: AppContainers.cachedNetworkImage(
                        size: 29,
                        imageUrl: user.photoUrl ?? defaultNetworkImage,
                      ),
                    ),
                    Positioned(
                      right: -2.w,
                      bottom: -2.h,
                      child: Container(
                        width: 14.r,
                        height: 14.r,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: AppContainers.whiteCircleContainer(
                          hasNotification: false,
                          icon: AppIcons.edit(
                            width: 9,
                            height: 9,
                            color: AppColors.text2,
                          ),
                          onTap: () => context.pushNamed('profile'),
                          radius: 6.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
