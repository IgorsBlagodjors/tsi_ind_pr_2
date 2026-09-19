import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/design_system/app_icons.dart';

class AppButtons {
  static Widget user({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.userIcons());
  }

  static Widget check({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.checkIcons());
  }

  static Widget close({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.closekIcons());
  }

  static Widget heart({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.heartIcons());
  }

  static Widget heartOutlined({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AppIcons.heartOutlinedIcons(),
    );
  }

  static Widget top({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.topIcons());
  }

  static Widget wallet({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.walletIcons());
  }

  static Widget sound({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.soundIcons());
  }

  static Widget fingerprint({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: AppIcons.fingerprintIcons(),
    );
  }

  static Widget privacy({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.privacyIcons());
  }

  static Widget global({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.globalIcons());
  }

  static Widget facebook({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.facebookIcons());
  }

  static Widget settings({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.sattingIcons());
  }

  static Widget whatsapp({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.whatsappIcons());
  }

  static Widget google({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.googleIcons());
  }

  static Widget questions({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.questionsIcons());
  }

  static Widget logout({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.logOutIcons());
  }

  static Widget picgram({required VoidCallback onPressed}) {
    return GestureDetector(onTap: onPressed, child: AppIcons.picgramIcons());
  }
}
