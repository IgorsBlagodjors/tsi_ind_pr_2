import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/app_buttons.dart';

class TestPage extends StatefulWidget {
  const new({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            // Circle buttons
            AppButtons.userBTN(onPressed: () => print('userBTN')),

            AppButtons.checkBTN(onPressed: () => print('checkBTN')),

            AppButtons.closeBTN(onPressed: () => print('closeBTN')),

            AppButtons.heartOutlinedBTN(
              onPressed: () => print('heartOutlinedBTN'),
            ),

            AppButtons.top(onPressed: () => print('top')),

            AppButtons.heartBTN(onPressed: () => print('heartBTN')),

            AppButtons.walletBTN(onPressed: () => print('walletBTN')),

            AppButtons.soundBTN(onPressed: () => print('soundBTN')),

            AppButtons.fingerprintBTN(onPressed: () => print('fingerprintBTN')),

            AppButtons.privacyBTN(onPressed: () => print('privacyBTN')),

            AppButtons.globalBTN(onPressed: () => print('globalBTN')),

            AppButtons.facebookBTN(onPressed: () => print('facebookBTN')),

            AppButtons.settingsBTN(onPressed: () => print('settingsBTN')),

            AppButtons.whatsappBTN(onPressed: () => print('whatsappBTN')),

            AppButtons.googleBTN(onPressed: () => print('googleBTN')),

            AppButtons.questionsBTN(onPressed: () => print('questionsBTN')),

            AppButtons.logoutBTN(onPressed: () => print('logoutBTN')),

            AppButtons.picgramBTN(onPressed: () => print('picgramBTN')),

            // Square buttons
            AppButtons.bookingSquareBTN(
              onPressed: () => print('bookingSquareBTN'),
            ),

            AppButtons.documentSquareBTN(
              onPressed: () => print('documentSquareBTN'),
            ),

            AppButtons.messageSquareBTN(
              onPressed: () => print('messageSquareBTN'),
            ),

            // Navigation gradient icons
            AppButtons.bookingGradientOutlinedBTN(
              onPressed: () => print('bookingGradientOutlinedBTN'),
            ),

            AppButtons.bookingGradientBTN(
              onPressed: () => print('bookingGradientBTN'),
            ),

            AppButtons.homeGradienOutlinedtBTN(
              onPressed: () => print('homeGradientOutlinedBTN'),
            ),

            AppButtons.homeGradientBTN(
              onPressed: () => print('homeGradientBTN'),
            ),

            AppButtons.chatGradienOutlinedtBTN(
              onPressed: () => print('chatGradientOutlinedBTN'),
            ),

            AppButtons.chatGradientBTN(
              onPressed: () => print('chatGradientBTN'),
            ),

            AppButtons.userGradientOutlinedBTN(
              onPressed: () => print('userGradientOutlinedBTN'),
            ),

            AppButtons.userGradientBTN(
              onPressed: () => print('userGradientBTN'),
            ),

            // Small icon buttons
            AppButtons.starIconBTN(onPressed: () => print('starIconBTN')),

            AppButtons.starOutlindedIconBTN(
              onPressed: () => print('starOutlinedIconBTN'),
            ),

            AppButtons.maleIconBTN(onPressed: () => print('maleIconBTN')),

            AppButtons.famaleIconBTN(onPressed: () => print('femaleIconBTN')),

            AppButtons.heartIconBTN(onPressed: () => print('heartIconBTN')),

            AppButtons.heartOutlinedIconBTN(
              onPressed: () => print('heartOutlinedIconBTN'),
            ),

            // Auth buttons
            AppButtons.authButton(
              text: 'Log In',
              onPressed: () => print('Log In white'),
            ),

            AppButtons.authButton(
              text: 'Log In',
              isGradient: true,
              onPressed: () => print('Log In gradient'),
            ),

            AppButtons.authButton(
              text: 'Sign Up',
              onPressed: () => print('Sign Up white'),
            ),

            AppButtons.authButton(
              text: 'Sign Up',
              isGradient: true,
              onPressed: () => print('Sign Up gradient'),
            ),

            // Single text buttons
            AppButtons.singleTextButton(
              text: 'Main Button',
              width: 135,
              height: 28,
              textIsBlack: true,
              onPressed: () => print('Main Button outline'),
            ),

            AppButtons.singleTextButton(
              text: 'Main Button',
              width: 135,
              height: 28,
              isGradient: true,
              onPressed: () => print('Main Button gradient'),
            ),

            AppButtons.singleTextButton(
              text: 'Filter Button',
              width: 115,
              height: 28,
              onPressed: () => print('Filter Button outline'),
            ),

            AppButtons.singleTextButton(
              text: 'Filter Button',
              width: 115,
              height: 28,
              isGradient: true,
              onPressed: () => print('Filter Button gradient'),
            ),

            // Text + image buttons
            AppButtons.textWithImageBTN(
              onPressed: () => print('textWithImage outline'),
            ),

            AppButtons.textWithImageBTN(
              isGradient: true,
              onPressed: () => print('textWithImage gradient'),
            ),
          ],
        ),
      ),
    );
  }
}
