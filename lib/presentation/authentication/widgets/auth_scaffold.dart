import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.child,
    this.backRoute = 'welcome',
  });
  final String title;
  final Widget child;
  final String backRoute;

  @override
  Widget build(BuildContext context) => Scaffold(
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
        child: AppButtons.backBTN(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed(backRoute);
            }
          },
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.semiBold24Prime.copyWith(color: Colors.white),
      ),
    ),
    body: SafeArea(top: false, child: AutofillGroup(child: child)),
  );
}
