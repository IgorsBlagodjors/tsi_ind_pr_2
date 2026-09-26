import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70.h,
        backgroundColor: const Color(0xFFECF1FF),
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          child: const DecoratedBox(
            decoration: BoxDecoration(gradient: AppColors.degradadoAzul),
            child: SizedBox.expand(),
          ),
        ),
        leading: Center(
          child: AppIcons.returnIcon(
            color: Colors.white,
            width: 10,
            height: 16,
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed('welcome');
              }
            },
          ),
        ),
        title: Text(
          'Log In',
          style: AppTextStyles.semiBold24Prime.copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(31.w, 0, 31.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 43.h),
              Text('Welcome', style: AppTextStyles.semiBold24Prime),
              SizedBox(height: 53.h),
              Text(
                'Email or Mobile Number',
                style: AppTextStyles.medium20Black,
              ),
              SizedBox(height: 12.h),
              AppInputs.inputEmail(controller: emailController),
              SizedBox(height: 20.h),
              Text('Password ', style: AppTextStyles.medium20Black),
              SizedBox(height: 12.h),
              AppInputs.inputPassword(
                controller: passwordController,
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(' Forget Password')),
                    );
                  },
                  text: 'Forget Password',
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
                      isGradient: true,
                      text: 'Log In',
                      onPressed: () {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('Log In')));
                      },
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
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sign Up')),
                            );
                          },
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
