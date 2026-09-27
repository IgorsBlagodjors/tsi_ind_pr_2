import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/auth_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/design_system/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/text_styles.dart';

class LogIn extends StatefulWidget {
  const new({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form is valid. Authentication is not connected yet.'),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Log In',
      backRoute: 'welcome',
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(31.w, 0, 31.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 43.h),
              Text('Welcome', style: AppTextStyles.semiBold24Prime),
              SizedBox(height: 33.h),
              Text(
                'Email or Mobile Number',
                style: AppTextStyles.medium20Black,
              ),
              SizedBox(height: 12.h),
              AppInputs.inputEmail(
                controller: emailController,
                allowPhone: true,
              ),
              SizedBox(height: 20.h),
              Text('Password ', style: AppTextStyles.medium20Black),
              SizedBox(height: 12.h),
              AppInputs.inputPassword(
                controller: passwordController,
                isNewPassword: false,
                textInputAction: TextInputAction.done,
                onSubmitted: _submit,
                obscureText: obscureText,
                onEyePressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),

              SizedBox(height: 9.h),
              Align(
                alignment: Alignment.centerRight,
                child: AppButtons.textButton(
                  onPressed: () {
                    context.pushNamed('set_password');
                  },
                  text: 'Forgot Password?',
                  textStyle: AppTextStyles.lague12Light.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 33.h),
              Center(
                child: Column(
                  children: [
                    AppButtons.authButton(
                      width: 191.w,
                      height: 45.h,
                      isGradient: true,
                      text: 'Log In',
                      onPressed: _submit,
                    ),
                    SizedBox(height: 29.h),
                    Text('or', style: AppTextStyles.lague12Light),
                    SizedBox(height: 12.h),
                    AppButtons.circleIconBTN(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Fingerprint')),
                        );
                      },
                      icon: AppIcons.fingerprintIcon(),
                    ),
                    SizedBox(height: 29.h),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account? ',
                          style: AppTextStyles.lague12Light,
                        ),
                        AppButtons.textButton(
                          onPressed: () => context.pushNamed('create_account'),
                          text: 'Sign Up',
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
    );
  }
}
