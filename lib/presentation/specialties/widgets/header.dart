import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.title, this.onSearchChanged});

  final String title;
  final ValueChanged<String>? onSearchChanged;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
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
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      height: 197.h,
      decoration: BoxDecoration(gradient: AppColors.degradadoAzul),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AppIcons.returnIcon(
                  color: Colors.white,
                  width: 8.w,
                  height: 14.h,
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
          SizedBox(height: 22.h),
          Text('Find Your Doctor', style: AppTextStyles.regular16White),
          SizedBox(height: 22.h),
          SizedBox(
            height: 38.h,
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
        ],
      ),
    );
  }
}
