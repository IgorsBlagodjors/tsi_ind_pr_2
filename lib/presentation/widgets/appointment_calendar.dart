import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/data/schedule/demo_availability.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

class AppointmentCalendar extends StatefulWidget {
  const AppointmentCalendar({
    super.key,
    required this.doctorId,
    this.onChanged,
  });

  final String doctorId;
  final ValueChanged<DateTime?>? onChanged;

  @override
  State<AppointmentCalendar> createState() => _AppointmentCalendarState();
}

class _AppointmentCalendarState extends State<AppointmentCalendar> {
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  late DateTime _selectedDate;
  late DateTime _pageStart;
  DateTime? _selectedTime;
  late final Timer _timer;

  DateTime get _today => DateUtils.dateOnly(DateTime.now());
  DateTime get _lastDate => _addDays(_today, 89);
  DemoAvailability get _availability => DemoAvailability(widget.doctorId);
  DateTime _addDays(DateTime date, int days) =>
      DateTime(date.year, date.month, date.day + days);

  @override
  void initState() {
    super.initState();
    _selectedDate = _today;
    _pageStart = _today;
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      setState(() {
        if (_selectedTime != null && !_selectedTime!.isAfter(DateTime.now())) {
          _selectedTime = null;
          widget.onChanged?.call(null);
        }
        if (_selectedDate.isBefore(_today)) _selectDate(_today);
      });
    });
  }

  @override
  void didUpdateWidget(covariant AppointmentCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.doctorId != widget.doctorId) {
      _selectedTime = null;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedTime = null;
      if (date.isBefore(_pageStart) ||
          !date.isBefore(_addDays(_pageStart, 6))) {
        _pageStart = date;
      }
    });
    widget.onChanged?.call(null);
  }

  void _changePage(int direction) {
    var date = _addDays(_pageStart, direction * 6);
    if (date.isBefore(_today)) date = _today;
    if (date.isAfter(_lastDate)) return;
    setState(() => _pageStart = date);
    _selectDate(date);
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate.isBefore(_today) ? _today : _selectedDate,
      firstDate: _today,
      lastDate: _lastDate,
    );
    if (date != null && mounted) _selectDate(date);
  }

  String _dayStatus(DateTime date) {
    final slots = _availability.slotsFor(date, now: DateTime.now());
    if (slots.isEmpty) return 'Closed';
    if (slots.any((slot) => slot.status == SlotStatus.available)) return 'Free';
    if (slots.every((slot) => slot.status == SlotStatus.elapsed)) {
      return 'Ended';
    }
    return 'Full';
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final slots = _availability.slotsFor(_selectedDate, now: DateTime.now());
    final hasAvailable = slots.any(
      (slot) => slot.status == SlotStatus.available,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(gradient: AppColors.degradadoAzul),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Upcoming Schedule',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: _pickDate,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: Text(localizations.formatMonthYear(_selectedDate)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w),
                child: const Divider(color: Colors.white, height: 1),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 19.w,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        tooltip: 'Previous days',
                        color: Colors.white,
                        disabledColor: Colors.white38,
                        onPressed: _pageStart.isAfter(_today)
                            ? () => _changePage(-1)
                            : null,
                        icon: const Icon(Icons.chevron_left),
                      ),
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Wrap(
                            spacing: 7.w,
                            runSpacing: 8,
                            children: [
                              for (var index = 0; index < 6; index++)
                                if (!_addDays(
                                  _pageStart,
                                  index,
                                ).isAfter(_lastDate))
                                  _day(
                                    _addDays(_pageStart, index),
                                    (constraints.maxWidth - 35.w) / 6,
                                  ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 19.w,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        tooltip: 'Next days',
                        color: Colors.white,
                        disabledColor: Colors.white38,
                        onPressed: _addDays(_pageStart, 6).isAfter(_lastDate)
                            ? null
                            : () => _changePage(1),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Time',
                style: AppTextStyles.medium14White.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                localizations.formatFullDate(_selectedDate),
                style: AppTextStyles.regular14Black,
              ),
              const SizedBox(height: 12),
              if (!hasAvailable)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    slots.isEmpty
                        ? 'Doctor is off on Sundays. Choose another day.'
                        : 'No available times. Choose another day.',
                    style: AppTextStyles.regular12Prime.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final gap = 3.w;
                  final slotWidth = (constraints.maxWidth - gap * 4) / 5;
                  return Wrap(
                    spacing: gap,
                    runSpacing: 3.h,
                    children: [
                      for (final slot in slots)
                        SizedBox(width: slotWidth, child: _timeSlot(slot)),
                    ],
                  );
                },
              ),
              if (_selectedTime != null) ...[
                SizedBox(height: 8.h),
                Text(
                  'Selected: ${localizations.formatMediumDate(_selectedTime!)}'
                  ' · ${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(_selectedTime!))}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _day(DateTime date, double width) {
    final selected = DateUtils.isSameDay(date, _selectedDate);
    final status = _dayStatus(date);
    return SizedBox(
      width: width,
      child: InkWell(
        key: ValueKey('day-${date.toIso8601String()}'),
        onTap: () => _selectDate(date),
        borderRadius: BorderRadius.circular(18.r),
        child: Column(
          children: [
            Opacity(
              opacity: status == 'Free' || selected ? 1 : 0.45,
              child: AppContainers.dateContainer(
                date: '${date.day}',
                day: _days[date.weekday - 1],
                isSelected: selected,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              status,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeSlot(AppointmentSlot slot) {
    final enabled = slot.status == SlotStatus.available;
    final selected = slot.start == _selectedTime;
    final label = MaterialLocalizations.of(context)
        .formatTimeOfDay(TimeOfDay.fromDateTime(slot.start));
    return OutlinedButton(
      key: ValueKey('slot-${slot.start.toIso8601String()}'),
      onPressed: enabled
          ? () {
              if (!slot.start.isAfter(DateTime.now())) {
                setState(() => _selectedTime = null);
                widget.onChanged?.call(null);
                return;
              }
              setState(() => _selectedTime = slot.start);
              widget.onChanged?.call(slot.start);
            }
          : null,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        backgroundColor: selected
            ? AppColors.primary
            : enabled
            ? Colors.transparent
            : AppColors.elements,
        foregroundColor: selected ? Colors.white : AppColors.primary,
        disabledForegroundColor: Colors.black45,
        side: BorderSide(
          color: enabled ? AppColors.primary : Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        fixedSize: Size.fromHeight(25.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.standard,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          maxLines: 1,
          style: AppTextStyles.lague12Light.copyWith(
            color: selected
                ? Colors.white
                : enabled
                ? AppColors.primary
                : AppColors.text2,
            fontWeight: enabled ? FontWeight.w600 : FontWeight.w200,
            height: 1,
          ),
        ),
      ),
    );
  }
}
