import 'package:tsi_ind_pr_2/core/constants/app_constants.dart';
import 'package:tsi_ind_pr_2/presentation/appointments/pages/appointments_page.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';
import 'package:tsi_ind_pr_2/presentation/home/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';

class ScheduleSection extends StatefulWidget {
  const ScheduleSection({super.key});

  @override
  State<ScheduleSection> createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<ScheduleSection> {
  late DateTime _selectedDate;
  bool _filterByDate = false;
  late DateTime _weekStart;
  final _selectedDayKey = GlobalKey();

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
          if (_filterByDate)
            TextButton(
              onPressed: () => setState(() => _filterByDate = false),
              child: const Text(
                'Next appointments',
                style: TextStyle(color: Colors.white),
              ),
            ),
          BookingList(
            date: _filterByDate ? _selectedDate : null,
            homeStyle: true,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  String get _monthLabel {
    final end = DateTime(_weekStart.year, _weekStart.month, _weekStart.day + 6);
    if (end.month == _weekStart.month) return months[end.month - 1];
    return '${months[_weekStart.month - 1].substring(0, 3)} / '
        '${months[end.month - 1].substring(0, 3)}';
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
        onTap: () => setState(() {
          _selectedDate = date;
          _filterByDate = true;
        }),
        child: AppContainers.dateContainer(
          date: '${date.day}',
          day: days[index],
          isSelected: DateUtils.isSameDay(date, _selectedDate),
        ),
      ),
    );
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
}
