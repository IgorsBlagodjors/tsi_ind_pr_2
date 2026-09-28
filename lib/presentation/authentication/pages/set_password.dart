import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class SetPassword extends StatefulWidget {
  const new({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Set Password',
      backRoute: 'login',
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(31.w, 0, 31.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36.h),
              Text('Password', style: AppTextStyles.medium20Black),
              SizedBox(height: 8.h),
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
              Text('Confirm Password', style: AppTextStyles.medium20Black),
              SizedBox(height: 8.h),
              AppInputs.inputPassword(
                controller: confirmPasswordController,
                confirmWith: passwordController,
                textInputAction: TextInputAction.done,
                onSubmitted: _submit,
                obscureText: obscureText,
                onEyePressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
              SizedBox(height: 53.h),
              Center(
                child: AppButtons.authButton(
                  width: 269.w,
                  height: 44.h,
                  text: 'Create New Password',
                  onPressed: _submit,
                  isGradient: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
