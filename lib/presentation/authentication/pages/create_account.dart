import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class CreateAccount extends StatefulWidget {
  const new({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  void _showDocument(String title) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: const Text('This document has not been published yet.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form is valid. Authentication is not connected yet.'),
      ),
    );
  }

  DateTime? birthDate;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    birthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'New Account',
      backRoute: 'welcome',
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(31.w, 0, 31.w, 24.h),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18.h),
                Text(
                  'Full name',
                  style: AppTextStyles.medium20Black.copyWith(height: 1),
                ),
                SizedBox(height: 9.h),
                AppInputs.inputName(controller: nameController),
                SizedBox(height: 18.h),
                Text(
                  'Password',
                  style: AppTextStyles.medium20Black.copyWith(height: 1),
                ),
                SizedBox(height: 9.h),
                AppInputs.inputPassword(
                  controller: passwordController,
                  obscureText: obscureText,
                  onEyePressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
                SizedBox(height: 18.h),
                Text(
                  'Email',
                  style: AppTextStyles.medium20Black.copyWith(height: 1),
                ),
                SizedBox(height: 9.h),
                AppInputs.inputEmail(controller: emailController),
                SizedBox(height: 18.h),
                Text(
                  'Mobile Number',
                  style: AppTextStyles.medium20Black.copyWith(height: 1),
                ),
                SizedBox(height: 8.h),
                AppInputs.inputPhoneNumber(controller: phoneController),
                SizedBox(height: 18.h),
                Text(
                  'Date Of Birth',
                  style: AppTextStyles.medium20Black.copyWith(height: 1),
                ),
                SizedBox(height: 8.h),
                AppInputs.inputBirth(
                  controller: birthController,
                  context: context,
                  onDateSelected: (value) {
                    birthDate = value;
                  },
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'By continuing, you agree to ',
                        style: AppTextStyles.lague12Light,
                      ),
                      Wrap(
                        children: [
                          AppButtons.textButton(
                            text: 'Terms of Use',
                            textStyle: AppTextStyles.medium12Prime,
                            onPressed: () => _showDocument('Terms of Use'),
                          ),
                          SizedBox(width: 3.w),
                          Text('and', style: AppTextStyles.lague12Light),
                          SizedBox(width: 3.w),
                          AppButtons.textButton(
                            text: 'Privacy Policy.',
                            textStyle: AppTextStyles.medium12Prime,
                            onPressed: () => _showDocument('Privacy Policy'),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      AppButtons.authButton(
                        width: 191.w,
                        height: 45.h,
                        text: 'Sign Up',
                        isGradient: true,
                        onPressed: _submit,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'or sign up with',
                        style: AppTextStyles.lague12Light,
                      ),
                      SizedBox(height: 12.h),
                      Wrap(
                        children: [
                          AppButtons.gradientCircleIconBTN(
                            radius: 20.r,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Google')),
                              );
                            },
                            icon: AppIcons.googleIcon(),
                          ),
                          SizedBox(width: 9.w),
                          AppButtons.gradientCircleIconBTN(
                            radius: 20.r,
                            onPressed: () {
                              context.goNamed('home');
                            },
                            icon: AppIcons.facebookIcon(),
                          ),
                          SizedBox(width: 9.w),
                          AppButtons.gradientCircleIconBTN(
                            radius: 20.r,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Fingerprint')),
                              );
                            },
                            icon: AppIcons.fingerprintIcon(),
                          ),
                        ],
                      ),
                      SizedBox(height: 36.h),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'already have an account? ',
                            style: AppTextStyles.lague12Light,
                          ),
                          AppButtons.textButton(
                            onPressed: () => context.goNamed('login'),
                            text: 'Log In',
                            textStyle: AppTextStyles.lague12Light.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
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
