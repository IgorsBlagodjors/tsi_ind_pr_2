import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/speciality_wiev.dart';

enum Gender { male, female }

enum AgeSelector { first, seccont, third }

class Filters extends StatefulWidget {
  const new({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  Gender _selectedGender = Gender.male;
  AgeSelector _ageSelector = AgeSelector.first;
  bool _switchActive = true;
  int _selectedRating = 3;
  double _selectedAge = 40;
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Filters',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: Text('Reset', style: AppTextStyles.regular12Prime),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Text(
                    'Availability Today',
                    style: AppTextStyles.medium15Prime,
                  ),
                  Spacer(),
                  AppButtons.switchBTN(
                    value: _switchActive,
                    onTap: () {
                      setState(() {
                        _switchActive = !_switchActive;
                      });
                    },
                  ),
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
                        _selectedGender = Gender.male;
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
                        _selectedGender = Gender.female;
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
                            _selectedRating = starNumber;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButtons.singleTextButton(
                    isGradient: _ageSelector == AgeSelector.first,
                    textIsBlack: _ageSelector != AgeSelector.first,
                    text: '1 - 5',
                    onPressed: () {
                      setState(() {
                        _ageSelector = AgeSelector.first;
                      });
                    },
                    height: 21.h,
                    horizontalPadding: 23.w,
                  ),

                  AppButtons.singleTextButton(
                    isGradient: _ageSelector == AgeSelector.seccont,
                    textIsBlack: _ageSelector != AgeSelector.seccont,
                    text: '6 - 9',
                    onPressed: () {
                      setState(() {
                        _ageSelector = AgeSelector.seccont;
                      });
                    },
                    height: 21.h,
                    horizontalPadding: 23.w,
                  ),
                  AppButtons.singleTextButton(
                    isGradient: _ageSelector == AgeSelector.third,
                    textIsBlack: _ageSelector != AgeSelector.third,
                    text: '10 >',
                    onPressed: () {
                      setState(() {
                        _ageSelector = AgeSelector.third;
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
              Text('Specialty', style: AppTextStyles.medium15Prime),
              SizedBox(height: 12.h),
              SpecialityWiev(),
              SizedBox(height: 24.h),
              AppContainers.appDivider(),
              SizedBox(height: 24.h),
              Text('Age', style: AppTextStyles.medium15Prime),
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
                  onChanged: (value) => setState(() => _selectedAge = value),
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
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
