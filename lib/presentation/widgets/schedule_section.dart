import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleSection extends StatefulWidget {
  const ScheduleSection({super.key});

  @override
  State<ScheduleSection> createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<ScheduleSection> {
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  late DateTime _selectedDate;
  late DateTime _weekStart;
  final _selectedDayKey = GlobalKey();
  bool apointmentExist = true;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _weekStart = DateTime(now.year, now.month, now.day - now.weekday + 1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dayContext = _selectedDayKey.currentContext;
      if (dayContext != null) {
        Scrollable.of(dayContext).position
            .ensureVisible(dayContext.findRenderObject()!, alignment: 0.5);
      }
    });
  }

  void _changeWeek(int direction) {
    setState(() {
      _weekStart = DateTime(
        _weekStart.year,
        _weekStart.month,
        _weekStart.day + direction * 7,
      );
    });
  }

  String get _monthLabel {
    final end = DateTime(_weekStart.year, _weekStart.month, _weekStart.day + 6);
    if (end.month == _weekStart.month) return _months[end.month - 1];
    return '${_months[_weekStart.month - 1].substring(0, 3)} / '
        '${_months[end.month - 1].substring(0, 3)}';
  }

  Widget _calendarDay(int index) {
    final date = DateTime(
      _weekStart.year,
      _weekStart.month,
      _weekStart.day + index,
    );
    return SizedBox(
      key: DateUtils.isSameDay(date, _selectedDate) ? _selectedDayKey : null,
      width: 42.w < 42 ? 42 : 42.w,
      child: GestureDetector(
        onTap: () => setState(() => _selectedDate = date),
        child: AppContainers.dateContainer(
          date: '${date.day}',
          day: _days[index],
          isSelected: DateUtils.isSameDay(date, _selectedDate),
        ),
      ),
    );
  }

  Widget _appointment({
    required String date,
    required String time,
    required String doctor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Icon(Icons.circle, size: 7.r, color: Colors.white),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: AppTextStyles.medium14White),
            Wrap(
              spacing: 12.w,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(time, style: AppTextStyles.medium16White),
                Text(
                  doctor,
                  style: AppTextStyles.semiBold14Prime.copyWith(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.degradadoAzul),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 31.w),
            child: SectionHeader(
              title: 'Upcoming schedule',
              trailingText: _monthLabel,
              onPressed: () => showActionMessage(context, _monthLabel),
              color: Colors.white,
              dividerColor: Colors.white,
            ),
          ),
          SizedBox(height: 7.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                SizedBox(
                  width: 19.w,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    tooltip: 'Previous week',
                    onPressed: () => _changeWeek(-1),
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 24.w,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var index = 0; index < 7; index++) ...[
                          if (index > 0) SizedBox(width: 7.w),
                          _calendarDay(index),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 24.w,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    tooltip: 'Next week',
                    onPressed: () => _changeWeek(1),
                    icon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 24.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),
          apointmentExist
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 31.w),
                  padding: EdgeInsets.fromLTRB(19.w, 8.h, 19.w, 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28.r),
                    border: Border.all(color: Colors.white, width: 1.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SectionHeader(
                        onPressed: () =>
                            showActionMessage(context, 'All appointments'),
                        color: Colors.white,
                        dividerColor: Colors.white,
                      ),
                      SizedBox(height: 9.h),
                      _appointment(
                        date: '11 Month - Wednesday - Today',
                        time: '10:00 am',
                        doctor: 'Dr. Olivia Turner',
                      ),
                      SizedBox(height: 9.h),
                      Divider(color: Colors.white, thickness: 1.h, height: 1.h),
                      SizedBox(height: 9.h),
                      _appointment(
                        date: '16 Month - Monday',
                        time: '08:00 am',
                        doctor: 'Dr. Alexander Bennett',
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
