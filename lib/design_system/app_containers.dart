import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/app_icons.dart';

class AppContainers {
  static Widget notification({required bool hasNotification}) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.red,
      child: Stack(
        children: [
          AppIcons.bell,
          Positioned(
            right: 0,
            top: 0,
            child: hasNotification
                ? Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  static Widget settings() {
    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.red,
      child: AppIcons.settings,
    );
  }

  static Widget search() {
    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.red,
      child: AppIcons.search,
    );
  }

  static Widget edit() {
    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.red,
      child: AppIcons.edit,
    );
  }

  static Widget navigations({required Widget icon, required String text}) {
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          icon,
          Text(text, style: TextStyle(fontSize: 12, color: AppColors.primary)),
        ],
      ),
    );
  }
}
