import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/domain/app_access.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/bloc/login_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/bloc/login_state.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class LogIn extends StatefulWidget {
  const new({super.key});

  static Widget withCubit() => BlocProvider(
    create: (context) => LoginCubit(context.read<AuthRepository>()),
    child: const LogIn(),
  );

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  late final LoginCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<LoginCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LogInPageState>(
      listener: (context, state) {
        if (state is Loaded) {
          final user = context.read<AuthRepository>().currentUser;
          if (user == null) return;
          AppAccess.instance.unlock(user.id);
          context.goNamed('home');
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: AuthScaffold(
        title: 'Hello!',
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
                Text('Email', style: AppTextStyles.medium20Black),
                SizedBox(height: 12.h),
                AppInputs.inputEmail(controller: emailController),
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
                      BlocBuilder<LoginCubit, LogInPageState>(
                        builder: (context, state) => AppButtons.authButton(
                          width: 191.w,
                          height: 45.h,
                          isGradient: true,
                          text: state is Loading ? 'Logging in...' : 'Log In',
                          onPressed: _submit,
                        ),
                      ),
                      SizedBox(height: 29.h),
                      Text('or', style: AppTextStyles.lague12Light),
                      SizedBox(height: 12.h),
                      BlocBuilder<LoginCubit, LogInPageState>(
                        builder: (context, state) => Semantics(
                          label: 'Log in with biometrics',
                          button: true,
                          enabled: state is! Loading,
                          child: IgnorePointer(
                            ignoring: state is Loading,
                            child: Opacity(
                              opacity: state is Loading ? 0.5 : 1,
                              child: AppButtons.gradientCircleIconBTN(
                                radius: 20.r,
                                onPressed: _cubit.logInWithBiometrics,
                                icon: AppIcons.fingerprintIcon(),
                              ),
                            ),
                          ),
                        ),
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
                            onPressed: () =>
                                context.pushNamed('create_account'),
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
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    _cubit.logIn(
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
