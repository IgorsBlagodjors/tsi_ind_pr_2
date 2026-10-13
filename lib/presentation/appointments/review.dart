import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class Review extends StatefulWidget {
  const new({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final TextEditingController _inputTextController = TextEditingController();
  int _selectedRating = 5;
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      backRoute: 'apointment',
      title: 'Review',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25.h),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: AppTextStyles.light12White.copyWith(
                  color: AppColors.text2,
                ),
              ),
              SizedBox(height: 30.h),
              AppContainers.networkImage(imageUrl: widget.doctor.image),
              SizedBox(height: 24.h),
              Text(
                overflow: TextOverflow.ellipsis,
                widget.doctor.name,
                style: AppTextStyles.medium24Prime.copyWith(height: 1.h),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                widget.doctor.specialization,
                style: AppTextStyles.light15Blacke.copyWith(height: 1.h),
              ),
              SizedBox(height: 13.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButtons.gradientCircleIconBTN(
                    onPressed: () => showActionMessage(
                      context,
                      'Saving favorites is not connected yet.',
                    ),
                    icon: Icon(Icons.favorite, color: Colors.white, size: 15.h),
                    radius: 12.h,
                  ),
                  SizedBox(width: 3.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 11.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      border: BoxBorder.all(
                        width: 2.w,
                        color: AppColors.primary,
                      ),
                    ),
                    child: Row(
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
                  ),
                ],
              ),
              SizedBox(height: 19.h),
              AppInputs.inputText(
                fillColor: AppColors.elements,
                hint: 'Enter your comment here...',
                controller: _inputTextController,
                height: 151.h,
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: AppButtons.singleTextButton(
                  isGradient: true,
                  text: 'Add Review',
                  onPressed: () => showActionMessage(
                    context,
                    'Sending reviews is not connected yet. The review was not sent.',
                  ),
                  height: 48.h,
                  horizontalPadding: 1.w,
                  textStyle: AppTextStyles.semiBold20White,
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
