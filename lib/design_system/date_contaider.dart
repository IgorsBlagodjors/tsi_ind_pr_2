import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';

class DateContainer {
  static Widget dateContainer({
    required String date,
    required String day,
    required bool isSelected,
  }) {
    return Container(
      width: 42,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 17.0, bottom: 12.0),
        child: Column(
          children: [
            Text(
              date,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            Text(
              day.toUpperCase(),
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
