import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/data/users/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_state.dart';
import 'package:tsi_ind_pr_2/data/firestore_dates.dart';
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
  final _formKey = GlobalKey<FormState>();
  bool _initialized = false;
  bool _saving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final user = (context.read<ProfileCubit>().state as ProfileLoaded).user;
    _inputNameController.text = user.fullName;
    _inputPhoneNumberController.text = user.phoneNumber ?? '';
    _inputEmailrController.text = user.email;
    dateOfBirth = user.dateOfBirth;
    _inputDateOfBirthController.text = dateOfBirth == null
        ? ''
        : dateOnly(dateOfBirth!);
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    final birth = dateOfBirth;
    if (birth == null) return;
    final uid = (context.read<ProfileCubit>().state as ProfileLoaded).user.id;
    FocusScope.of(context).unfocus();
    setState(() => _saving = true);
    try {
      await context.read<ProfileRepository>().saveDetails(
        uid: uid,
        fullName: _inputNameController.text,
        phoneNumber: _inputPhoneNumberController.text,
        dateOfBirth: birth,
      );
      if (mounted) showActionMessage(context, 'Profile saved.');
    } catch (error) {
      if (mounted) showActionMessage(context, profileErrorMessage(error));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                              onPressed: () => showActionMessage(
                                context,
                                'Settings are not available yet.',
                              ),
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
                          AppContainers.networkImage(
                            imageUrl: 'https://www.dropbox.com/scl/fi/arp7awfdbtbz69gckyudy/unknown.png?rlkey=as20833k60pgp09hky1g8r8h6&st=p0ygqz9b&dl=1',
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: AppButtons.circleIconBTN(
                              onPressed: () => showActionMessage(
                                context,
                                'Image upload is not available yet.',
                              ),
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
                        readOnly: true,
                        isGradient: false,
                        controller: _inputEmailrController,
                      ),
                      const Text('Your sign-in email cannot be changed here.'),
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
                      SizedBox(height: 30.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: AppButtons.singleTextButton(
                          isGradient: true,
                          text: _saving ? 'Saving...' : 'Confirm',
                          onPressed: _save,
                          height: 48.h,
                          horizontalPadding: 1.w,
                          textStyle: AppTextStyles.semiBold20White,
                        ),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
