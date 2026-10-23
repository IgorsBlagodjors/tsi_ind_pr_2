import 'package:tsi_ind_pr_2/domain/filters/doctor_filters.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:tsi_ind_pr_2/presentation/favorites/widgets/favorite_doctors_list.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/widgets/specialties_filter.dart';

class FavoriteDoctor extends StatefulWidget {
  const new({super.key});

  @override
  State<FavoriteDoctor> createState() => _FavoriteDoctorState();
}

class _FavoriteDoctorState extends State<FavoriteDoctor> {
  DoctorFilters _filters = DoctorFilters();
  FavSelector selected = FavSelector.doctor;
  SortOrder sortOrder = SortOrder.ascending;

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
            _favoriteFilter(context: context),
            if (selected == FavSelector.doctor)
              FavoriteDoctorLW(sortOrder: sortOrder, filters: _filters)
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

  Widget _favoriteFilter({required BuildContext context}) {
    return Column(
      children: [
        SpecialtiesFilter(
          onFilterPressed: () async {
            final result = await context.pushNamed<DoctorFilters>(
              'filters',
              extra: _filters,
            );
            if (!mounted || result == null) return;
            setState(() => _filters = result);
          },
          showDivider: false,
          sortOrder: sortOrder,
          onPressed: () {
            setState(() {
              sortOrder = sortOrder == SortOrder.ascending
                  ? SortOrder.descending
                  : SortOrder.ascending;
            });
          },
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
