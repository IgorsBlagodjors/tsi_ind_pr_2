import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class SpecialtiesHeader extends StatefulWidget {
  const SpecialtiesHeader({
    super.key,
    required this.title,
    this.onSearchChanged,
    required this.onPressed,
  });

  final String title;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback onPressed;

  @override
  State<SpecialtiesHeader> createState() => _HeaderState();
}

class _HeaderState extends State<SpecialtiesHeader> {
  Timer? _searchDebounce;

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(seconds: 2), () {
      widget.onSearchChanged?.call(value);
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 197.h,
      decoration: BoxDecoration(gradient: AppColors.degradadoAzul),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 21.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppButtons.backBTN(onPressed: widget.onPressed),
                ),
              ),
              Text(
                widget.title,
                style: AppTextStyles.semiBold24Prime.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text('Find Your Doctor', style: AppTextStyles.regular16White),
          SizedBox(height: 22.h),
          SizedBox(
            height: 38.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 31.w),
              child: TextFormField(
                onChanged: _onSearchChanged,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 13.9.w, right: 10.93.w),
                    child: AppIcons.search(),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 38.w,
                    minHeight: 38.h,
                  ),
                  hintText: 'Search',
                  hintStyle: AppTextStyles.regular16White.copyWith(
                    color: AppColors.primary,
                  ),
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 13.91.w,
                    vertical: 0,
                  ),
                  fillColor: AppColors.elements,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
