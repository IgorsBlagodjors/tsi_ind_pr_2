import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class EditProfile extends StatefulWidget {
  const new({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _inputNameController = TextEditingController();
  final TextEditingController _inputPhoneNumberController =
      TextEditingController();
  final TextEditingController _inputEmailrController = TextEditingController();
  final TextEditingController _inputDateOfBirthController =
      TextEditingController();
  DateTime? dateOfBirth;

  @override
  void dispose() {
    _inputNameController.dispose();
    _inputPhoneNumberController.dispose();
    _inputEmailrController.dispose();
    _inputDateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(gradient: AppColors.degradadoAzul),
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(left: 21.w, right: 31.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButtons.backBTN(
                            onPressed: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.goNamed('profile');
                              }
                            },
                          ),
                          Text(
                            'Profile',
                            style: AppTextStyles.semiBold24Prime.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          AppButtons.circleIconBTN(
                            onPressed: () =>
                                showActionMessage(context, 'Settings'),
                            icon: AppIcons.settingIcon(
                              color: AppColors.primary,
                              width: 12.w,
                              height: 12.h,
                            ),
                            radius: 11.r,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Stack(
                      children: [
                        AppContainers.profileAvatar(
                          image: AssetImage('assets/avatars/Perfil.png'),
                          radius: 54.5.r,
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: AppButtons.circleIconBTN(
                            onPressed: () =>
                                showActionMessage(context, 'Change Image'),
                            icon: AppIcons.edit(
                              width: 12.15.w,
                              height: 17.55.h,
                              color: AppColors.primary,
                            ),
                            radius: 13.5.r,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              SizedBox(height: 31.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 31.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full Name', style: AppTextStyles.medium20Black),
                    SizedBox(height: 12.h),
                    AppInputs.inputName(
                      isGradient: false,
                      controller: _inputNameController,
                      height: 45.h,
                    ),
                    SizedBox(height: 31.h),
                    Text('Phone number', style: AppTextStyles.medium20Black),
                    AppInputs.inputPhoneNumber(
                      isGradient: false,
                      height: 45.h,
                      controller: _inputPhoneNumberController,
                    ),
                    SizedBox(height: 31.h),
                    Text('Email', style: AppTextStyles.medium20Black),
                    AppInputs.inputEmail(
                      isGradient: false,
                      controller: _inputEmailrController,
                    ),
                    SizedBox(height: 31.h),
                    Text('Date of birth', style: AppTextStyles.medium20Black),
                    AppInputs.inputBirth(
                      isGradient: false,
                      controller: _inputDateOfBirthController,
                      context: context,
                      onDateSelected: (value) {
                        dateOfBirth = value;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
