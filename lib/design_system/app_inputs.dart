import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/text_styles.dart';

class AppInputs {
  static bool _validPhone(String value) {
    final normalized = value.trim().replaceAll(RegExp(r'[\s()\-]'), '');
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(normalized);
  }

  static Widget inputEmail({
    required TextEditingController controller,
    bool allowPhone = false,
  }) {
    return SizedBox(
      width: 298.w,
      child: TextFormField(
        controller: controller,
        keyboardType: allowPhone
            ? TextInputType.text
            : TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        autocorrect: false,
        autofillHints: [
          allowPhone ? AutofillHints.username : AutofillHints.email,
        ],
        style: AppTextStyles.regular20Prime,
        decoration: InputDecoration(
          errorMaxLines: 3,
          hintText: 'example@example.com',
          hintStyle: AppTextStyles.regular20Prime,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          fillColor: AppColors.elements,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return allowPhone ? 'Enter email or mobile number' : 'Enter email';
          }

          final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

          if (allowPhone && _validPhone(value)) return null;
          if (!emailRegex.hasMatch(value.trim())) {
            return allowPhone
                ? 'Enter a valid email or mobile number'
                : 'Enter a valid email';
          }

          return null;
        },
      ),
    );
  }

  static Widget inputName({required TextEditingController controller}) {
    return SizedBox(
      width: 298.w,
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        autofillHints: const [AutofillHints.name],
        style: AppTextStyles.regular20Prime,
        decoration: InputDecoration(
          errorMaxLines: 3,
          counterText: '',
          hintText: 'Full name',
          hintStyle: AppTextStyles.regular20Prime,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          fillColor: AppColors.elements,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Enter name';
          }

          return null;
        },
      ),
    );
  }

  static Widget inputPhoneNumber({required TextEditingController controller}) {
    return SizedBox(
      width: 298.w,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        autofillHints: const [AutofillHints.telephoneNumber],
        style: AppTextStyles.regular20Prime,
        decoration: InputDecoration(
          errorMaxLines: 3,
          hintText: '+371 20000000',
          hintStyle: AppTextStyles.regular20Prime,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          fillColor: AppColors.elements,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Enter phone number';
          }

          if (!_validPhone(value)) {
            return 'Enter a valid phone number';
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
    bool isNewPassword = true,
    TextEditingController? confirmWith,
    TextInputAction textInputAction = TextInputAction.next,
    VoidCallback? onSubmitted,
  }) {
    return SizedBox(
      width: 298.w,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        autocorrect: false,
        enableSuggestions: false,
        autofillHints: [
          isNewPassword ? AutofillHints.newPassword : AutofillHints.password,
        ],
        textInputAction: textInputAction,
        onFieldSubmitted: onSubmitted == null ? null : (_) => onSubmitted(),
        textAlignVertical: TextAlignVertical.center,
        style: AppTextStyles.regular20Prime,
        decoration: InputDecoration(
          errorMaxLines: 3,
          isDense: true,
          counterText: '',
          filled: true,
          fillColor: AppColors.elements,
          hintText: '••••••••••••••',
          hintStyle: AppTextStyles.regular20Prime,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
          suffixIconConstraints: BoxConstraints(
            minWidth: 45.w,
            minHeight: 45.h,
          ),
          suffixIcon: IconButton(
            tooltip: obscureText ? 'Show password' : 'Hide password',
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
          if (value == null || value.trim().isEmpty) {
            return 'Enter password';
          }

          if (isNewPassword && value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          if (confirmWith != null && value != confirmWith.text) {
            return 'Passwords do not match';
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
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate:
                DateTime.tryParse(
                  controller.text.split(' / ').reversed.join('-'),
                ) ??
                DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (date != null && context.mounted) {
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
          errorMaxLines: 3,
          hintText: 'DD / MM / YYYY',
          hintStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 43.w,
            vertical: 12.h,
          ),
          fillColor: AppColors.elements,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
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
          errorMaxLines: 3,
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
