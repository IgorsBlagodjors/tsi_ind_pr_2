import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';

import 'widgets/upcoming_apointments_lw.dart';
import 'widgets/completed_appointment_lw.dart';
import 'widgets/cancelled_apointment_lw.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointment_booking.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/presentation/home/widgets/section_header.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

List<AppointmentBooking> homeAppointments(
  List<AppointmentBooking> bookings, {
  required DateTime now,
  DateTime? date,
}) {
  final items =
      bookings
          .where(
            (item) => date != null
                ? DateUtils.isSameDay(item.startsAt.toLocal(), date)
                : item.status == AppointmentStatus.upcoming &&
                      item.startsAt.isAfter(now),
          )
          .toList()
        ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
  return date == null ? items.take(2).toList() : items;
}

class Appointment extends StatefulWidget {
  const Appointment({super.key});
  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  AppointmentStatus _status = AppointmentStatus.upcoming;
  late Stream<List<AppointmentBooking>> _bookings;
  late Stream<List<Doctor>> _doctors;
  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
    title: 'All Appointment',
    backRoute: 'home',
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 28),
              Row(
                children: [
                  _tab(AppointmentStatus.completed, 'Complete'),
                  const SizedBox(width: 8),
                  _tab(AppointmentStatus.upcoming, 'Upcoming'),
                  const SizedBox(width: 8),
                  _tab(AppointmentStatus.cancelled, 'Cancelled'),
                ],
              ),
              const SizedBox(height: 26),
              Divider(height: 1, thickness: 1, color: AppColors.outline),
              Expanded(
                child: StreamBuilder<List<AppointmentBooking>>(
                  stream: _bookings,
                  builder: (context, bookings) {
                    if (bookings.hasError) return _retry();
                    if (!bookings.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return StreamBuilder<List<Doctor>>(
                      stream: _doctors,
                      builder: (context, doctors) {
                        if (doctors.hasError) return _retry();
                        if (!doctors.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final visits =
                            bookings.data!
                                .where((item) => item.status == _status)
                                .toList()
                              ..sort(
                                (a, b) => _status == AppointmentStatus.upcoming
                                    ? a.startsAt.compareTo(b.startsAt)
                                    : b.startsAt.compareTo(a.startsAt),
                              );
                        if (visits.isEmpty) {
                          return Center(
                            child: Text('No ${_status.name} appointments.'),
                          );
                        }
                        final byId = {
                          for (final doctor in doctors.data!) doctor.id: doctor,
                        };
                        final visitDoctors = visits
                            .map(
                              (item) =>
                                  byId[item.doctorId] ??
                                  Doctor(
                                    id: item.doctorId,
                                    name: 'Doctor unavailable',
                                    type: DoctorType.cardiology,
                                    specialization: '',
                                    image: '',
                                  ),
                            )
                            .toList();
                        return switch (_status) {
                          AppointmentStatus.upcoming => UpcomingApointmentsLW(
                            doctors: doctors.data!,
                            appointments: visits,
                          ),
                          AppointmentStatus.completed => CompletedApointmentlw(
                            doctors: visitDoctors,
                            appointments: visits,
                          ),
                          AppointmentStatus.cancelled => CancelledApointmentlLW(
                            doctors: visitDoctors,
                          ),
                        };
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void _subscribe() {
    final uid = context.read<AuthRepository>().currentUser?.id;
    _bookings = uid == null
        ? Stream.value([])
        : context.read<AppointmentsRepository>().watchForUser(uid);
    _doctors = context.read<DoctorsRepository>().watchDoctors();
  }

  Widget _retry() => Center(
    child: TextButton(
      onPressed: () => setState(_subscribe),
      child: const Text('Could not load appointments. Retry'),
    ),
  );
  Widget _tab(AppointmentStatus status, String label) => Expanded(
    child: AppButtons.singleTextButton(
      text: label,
      onPressed: () => setState(() => _status = status),
      height: 28,
      horizontalPadding: 3.0,
      adaptiveHeight: true,
      isGradient: _status == status,
      textIsBlack: true,
      textStyle: TextStyle(
        fontFamily: 'League Spartan',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _status == status ? Colors.white : AppColors.text2,
      ),
    ),
  );
}

class BookingList extends StatefulWidget {
  const BookingList({super.key, this.date, this.homeStyle = false});
  final DateTime? date;
  final bool homeStyle;
  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  late Stream<List<AppointmentBooking>> _bookings;
  final Map<String, Future<String>> _names = {};
  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  void _subscribe() {
    final uid = context.read<AuthRepository>().currentUser?.id;
    _bookings = uid == null
        ? Stream.value([])
        : context.read<AppointmentsRepository>().watchForUser(uid);
  }

  Widget _doctorName(AppointmentBooking item, TextStyle? style) =>
      FutureBuilder<String>(
        future: _names.putIfAbsent(
          item.doctorId,
          () => context
              .read<DoctorsRepository>()
              .getDoctorById(item.doctorId)
              .then((doctor) => doctor?.name ?? 'Doctor unavailable'),
        ),
        builder: (context, name) => Text(
          name.hasError ? 'Doctor unavailable' : name.data ?? 'Doctor',
          style: style,
        ),
      );

  Widget _homePanel(Widget child) => Container(
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
          onPressed: () => context.pushNamed('apointment'),
          color: Colors.white,
          dividerColor: Colors.white,
        ),
        SizedBox(height: 9.h),
        child,
      ],
    ),
  );

  Widget _homeRow(AppointmentBooking item) {
    final date = item.startsAt.toLocal();
    final labels = MaterialLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Icon(Icons.circle, size: 7.r, color: Colors.white),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labels.formatFullDate(date),
                style: AppTextStyles.medium14White,
              ),
              SizedBox(height: 3.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 3.h,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    labels.formatTimeOfDay(TimeOfDay.fromDateTime(date)),
                    style: AppTextStyles.medium16White,
                  ),
                  _doctorName(
                    item,
                    AppTextStyles.semiBold14Prime.copyWith(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<AppointmentBooking>>(
    stream: _bookings,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        final retry = TextButton(
          style: widget.homeStyle
              ? TextButton.styleFrom(foregroundColor: Colors.white)
              : null,
          onPressed: () => setState(_subscribe),
          child: const Text('Could not load appointments. Retry'),
        );
        return widget.homeStyle ? _homePanel(retry) : retry;
      }
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      final items = widget.homeStyle
          ? homeAppointments(
              snapshot.data!,
              now: DateTime.now(),
              date: widget.date,
            )
          : snapshot.data!
                .where(
                  (item) =>
                      widget.date == null ||
                      DateUtils.isSameDay(item.startsAt.toLocal(), widget.date),
                )
                .toList();
      if (widget.homeStyle) {
        return _homePanel(
          items.isEmpty
              ? Text(
                  widget.date == null
                      ? 'No upcoming appointments.'
                      : 'No appointments on this date.',
                  style: AppTextStyles.medium14White,
                )
              : Column(
                  children: [
                    for (var i = 0; i < items.length; i++) ...[
                      if (i > 0)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 9.h),
                          child: const Divider(color: Colors.white, height: 1),
                        ),
                      _homeRow(items[i]),
                    ],
                  ],
                ),
        );
      }
      if (items.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(24),
          child: Text('No appointments. Choose a doctor to book a visit.'),
        );
      }
      return Column(
        children: [
          for (final item in items)
            Card(
              child: ListTile(
                title: FutureBuilder<String>(
                  future: _names.putIfAbsent(
                    item.doctorId,
                    () => context
                        .read<DoctorsRepository>()
                        .getDoctorById(item.doctorId)
                        .then((doctor) => doctor?.name ?? 'Doctor unavailable'),
                  ),
                  builder: (context, name) => Text(name.data ?? 'Doctor'),
                ),
                subtitle: Text(
                  '${MaterialLocalizations.of(context).formatMediumDate(item.startsAt.toLocal())} · '
                  '${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(item.startsAt.toLocal()))}\n'
                  '${item.patient.fullName} · ${item.status.name}',
                ),
                isThreeLine: true,
              ),
            ),
        ],
      );
    },
  );
}
