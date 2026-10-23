import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/domain/filters/doctor_filters.dart';
import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/specialty_view.dart';

class Filters extends StatefulWidget {
  const new({super.key, this.initialFilters});
  final DoctorFilters? initialFilters;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  Gender? _selectedGender;
  AgeSelector? _ageSelector;
  int _selectedRating = 0;
  Set<DoctorType> _selectedTypes = DoctorType.values.toSet();
  final double _selectedAge = 40;
  @override
  void initState() {
    super.initState();
    final initial = widget.initialFilters ?? DoctorFilters();
    _selectedGender = initial.gender;
    _ageSelector = initial.experience;
    _selectedRating = initial.minimumRating;
    _selectedTypes = Set.of(initial.types);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Filters',
      backRoute: 'doctors',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: AppButtons.textButton(
                  text: 'Reset',
                  textStyle: AppTextStyles.regular12Prime,
                  onPressed: () => setState(() {
                    _selectedGender = null;
                    _ageSelector = null;
                    _selectedRating = 0;
                    _selectedTypes = DoctorType.values.toSet();
                  }),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Availability Today',
                      style: AppTextStyles.medium15Prime,
                    ),
                  ),
                  const Switch(value: false, onChanged: null),
                ],
              ),
              SizedBox(height: 24.h),
              AppContainers.appDivider(),
              SizedBox(height: 24.h),
              Text('Gender', style: AppTextStyles.medium15Prime),
              SizedBox(height: 12.h),
              Row(
                children: [
                  AppButtons.singleTextButton(
                    isGradient: _selectedGender == Gender.male,
                    textIsBlack: _selectedGender != Gender.male,
                    text: 'Male',
                    onPressed: () {
                      setState(() {
                        _selectedGender = _selectedGender == Gender.male
                            ? null
                            : Gender.male;
                      });
                    },
                    height: 21.h,
                    horizontalPadding: 23.w,
                  ),
                  SizedBox(width: 12.w),
                  AppButtons.singleTextButton(
                    isGradient: _selectedGender == Gender.female,
                    textIsBlack: _selectedGender != Gender.female,
                    text: 'Female',
                    onPressed: () {
                      setState(() {
                        _selectedGender = _selectedGender == Gender.female
                            ? null
                            : Gender.female;
                      });
                    },
                    height: 21.h,
                    horizontalPadding: 23.w,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              AppContainers.appDivider(),
              SizedBox(height: 24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Top Rated', style: AppTextStyles.medium15Prime),
                  SizedBox(width: 33.w),
                  Row(
                    children: List.generate(5, (index) {
                      final starNumber = index + 1;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRating = _selectedRating == starNumber
                                ? 0
                                : starNumber;
                          });
                        },
                        child: Icon(
                          starNumber <= _selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              AppContainers.appDivider(),
              SizedBox(height: 24.h),
              Text(
                'Work Experience (Years)',
                style: AppTextStyles.medium15Prime,
              ),
              SizedBox(height: 12.h),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  SizedBox(
                    width: 84.w,
                    child: AppButtons.singleTextButton(
                      isGradient: _ageSelector == AgeSelector.first,
                      textIsBlack: _ageSelector != AgeSelector.first,
                      text: '1 - 5',
                      onPressed: () {
                        setState(() {
                          _ageSelector = _ageSelector == AgeSelector.first
                              ? null
                              : AgeSelector.first;
                        });
                      },
                      height: 21.h,
                      horizontalPadding: 8.w,
                    ),
                  ),

                  SizedBox(
                    width: 84.w,
                    child: AppButtons.singleTextButton(
                      isGradient: _ageSelector == AgeSelector.seccont,
                      textIsBlack: _ageSelector != AgeSelector.seccont,
                      text: '6 - 9',
                      onPressed: () {
                        setState(() {
                          _ageSelector = _ageSelector == AgeSelector.seccont
                              ? null
                              : AgeSelector.seccont;
                        });
                      },
                      height: 21.h,
                      horizontalPadding: 8.w,
                    ),
                  ),
                  SizedBox(
                    width: 84.w,
                    child: AppButtons.singleTextButton(
                      isGradient: _ageSelector == AgeSelector.third,
                      textIsBlack: _ageSelector != AgeSelector.third,
                      text: '10+',
                      onPressed: () {
                        setState(() {
                          _ageSelector = _ageSelector == AgeSelector.third
                              ? null
                              : AgeSelector.third;
                        });
                      },
                      height: 21.h,
                      horizontalPadding: 8.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              AppContainers.appDivider(),
              SizedBox(height: 24.h),
              Text('Specialty', style: AppTextStyles.medium15Prime),
              SizedBox(height: 12.h),
              SpecialityWiev(
                selectedTypes: _selectedTypes,
                onChanged: (selectedTypes) {
                  setState(() => _selectedTypes = Set.of(selectedTypes));
                },
              ),
              SizedBox(height: 24.h),
              AppContainers.appDivider(),
              SizedBox(height: 24.h),
              Text('Age (unavailable)', style: AppTextStyles.medium15Prime),
              SizedBox(height: 12.h),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4.h,
                  trackShape: const RectangularSliderTrackShape(),
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: const Color(0xFFD9D9D9),
                  thumbColor: AppColors.primary,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 7.r,
                    elevation: 0,
                    pressedElevation: 0,
                  ),
                  overlayColor: AppColors.primary.withValues(alpha: 0.12),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 14.r),
                  tickMarkShape: SliderTickMarkShape.noTickMark,
                  showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                ),
                child: Slider(
                  value: _selectedAge,
                  min: 20,
                  max: 80,
                  divisions: 60,
                  padding: EdgeInsets.zero,
                  label: '${_selectedAge.round()}',
                  semanticFormatterCallback: (value) =>
                      '${value.round()} years',
                  onChanged: null,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final age in [20, 40, 60, 80])
                    Text(
                      '$age',
                      style: AppTextStyles.light14White.copyWith(
                        color: AppColors.text2,
                      ),
                    ),
                ],
              ),
              Text(
                'Age and availability filters are not available yet.',
                style: AppTextStyles.regular12Prime,
              ),
              SizedBox(height: 16.h),
              AppButtons.singleTextButton(
                text: 'Apply filters',
                height: 40.h,
                horizontalPadding: 24.w,
                isGradient: true,
                onPressed: () {
                  final result = DoctorFilters(
                    gender: _selectedGender,
                    minimumRating: _selectedRating,
                    experience: _ageSelector,
                    types: _selectedTypes,
                  );
                  if (context.canPop()) context.pop(result);
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
