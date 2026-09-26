import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/text_styles.dart';

class AppInputs {
  static Widget inputEmail({required TextEditingController controller}) {
    return SizedBox(
      width: 298.w,
      height: 45.h,
      child: TextFormField(
        controller: controller,
        autofillHints: const [AutofillHints.email],
        style: AppTextStyles.regular20Prime,
        decoration: InputDecoration(
          hintText: 'example@example.com',
          hintStyle: AppTextStyles.regular20Prime,
          filled: true,
          contentPadding: EdgeInsets.only(top: 15.w, left: 12.h),
          fillColor: AppColors.elements,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter email';
          }

          final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

          if (!emailRegex.hasMatch(value)) {
            return 'Enter valid email';
          }

          return null;
        },
      ),
    );
  }

  static Widget inputPassword({
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onEyePressed,
  }) {
    return SizedBox(
      width: 299.w,
      height: 55.h,
      child: TextFormField(
        controller: controller,
        maxLength: 15,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.center,
        style: AppTextStyles.regular20Prime,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: AppColors.elements,
          hintText: '••••••••••••••',
          hintStyle: AppTextStyles.regular20Prime,

          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),

          suffixIcon: IconButton(
            onPressed: onEyePressed,
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.primary,
              size: 20.r,
            ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide.none,
          ),
        ),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter password';
          }

          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }

          return null;
        },
      ),
    );
  }

  static Widget inputBirth({
    required TextEditingController controller,
    required BuildContext context,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return SizedBox(
      width: 298.w,
      height: 45.h,
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (date != null) {
            onDateSelected(date);
            controller.text =
                '${date.day.toString().padLeft(2, '0')} / '
                '${date.month.toString().padLeft(2, '0')} / '
                '${date.year}';
          }
        },
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'DD / MM / YYYY',
          hintStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          contentPadding: EdgeInsets.only(top: 17.w, left: 43.w),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Select birth date';
          }

          return null;
        },
      ),
    );
  }

  static Widget inputText({
    required TextEditingController controller,
    required double width,
    required double height,
    required String hint,
  }) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
