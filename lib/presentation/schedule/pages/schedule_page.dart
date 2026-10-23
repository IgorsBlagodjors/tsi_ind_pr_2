import 'package:tsi_ind_pr_2/presentation/schedule/bloc/schedule_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/schedule/bloc/schedule_state.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/domain/repositories/appointments_repository.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/domain/models/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/schedule/widgets/appointment_calendar.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final profile = context.read<ProfileCubit>().state;
      return ScheduleCubit(
        context.read<AppointmentsRepository>(),
        context.read<AuthRepository>(),
        doctorId: doctor.id,
      )..updateProfile(profile is ProfileLoaded ? profile.user : null);
    },
    child: _ScheduleView(doctor: doctor),
  );
}

class _ScheduleView extends StatefulWidget {
  const _ScheduleView({required this.doctor});
  final Doctor doctor;

  @override
  State<_ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<_ScheduleView> {
  late final ScheduleCubit _cubit;
  late final TextEditingController _patientNameController;
  late final TextEditingController _patientAgeController;
  final _patientProblemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ScheduleCubit>(context);
    final state = _cubit.state;
    _formRevision = state.formRevision;
    _patientNameController = TextEditingController(text: state.patientName);
    _patientAgeController = TextEditingController(text: state.patientAge);
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _patientAgeController.dispose();
    _patientProblemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, profile) =>
          _cubit.updateProfile(profile is ProfileLoaded ? profile.user : null),
      child: BlocConsumer<ScheduleCubit, ScheduleState>(
        bloc: _cubit,
        listener: (context, state) {
          if (_formRevision != state.formRevision) {
            _formRevision = state.formRevision;
            _patientNameController.text = state.patientName;
            _patientAgeController.text = state.patientAge;
          }
          if (state.message != null) showActionMessage(context, state.message!);
          if (state.status == ScheduleStatus.success) {
            showActionMessage(context, 'Appointment booked.');
            context.goNamed('apointment');
          }
        },
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.degradadoAzul,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 26.w, left: 10.w),
                      child: Column(
                        children: [
                          SizedBox(height: 25.h),
                          Row(
                            children: [
                              AppButtons.backBTN(
                                onPressed: () {
                                  if (context.canPop()) {
                                    context.pop();
                                  } else {
                                    context.goNamed(
                                      'doctors_info',
                                      extra: widget.doctor,
                                    );
                                  }
                                },
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () => context.pushNamed(
                                    'doctors_info',
                                    extra: widget.doctor,
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                  ),
                                  child: Text(
                                    widget.doctor.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              AppButtons.circleIconBTN(
                                radius: 10.5.r,
                                onPressed: () => showActionMessage(
                                  context,
                                  'Calls are not available yet.',
                                ),
                                icon: AppIcons.phoneIcon(),
                              ),
                              SizedBox(width: 2.w),
                              AppButtons.circleIconBTN(
                                radius: 10.5.r,
                                onPressed: () => showActionMessage(
                                  context,
                                  'Video calls are not available yet.',
                                ),
                                icon: AppIcons.cameraIcon(),
                              ),
                              SizedBox(width: 2.w),
                              AppButtons.circleIconBTN(
                                radius: 10.5.r,
                                onPressed: () => showActionMessage(
                                  context,
                                  'Chat is not available yet.',
                                ),
                                icon: AppIcons.chatOutlinedIcon(
                                  width: 12.w,
                                  height: 11.h,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              AppButtons.circleIconBTN(
                                fullWhite: true,
                                radius: 10.5.r,
                                onPressed: () => showActionMessage(
                                  context,
                                  'Help is not available yet.',
                                ),
                                icon: Icon(
                                  Icons.question_mark,
                                  size: 12.w,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              AppButtons.circleIconBTN(
                                fullWhite: true,
                                radius: 10.5.r,
                                onPressed: () => showActionMessage(
                                  context,
                                  'Saving favorites is not connected yet.',
                                ),
                                icon: Icon(
                                  Icons.favorite_border,
                                  size: 12.w,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18.h),
                        ],
                      ),
                    ),
                  ),
                  AppointmentCalendar(
                    doctorId: widget.doctor.id,
                    onChanged: _cubit.selectTime,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 31.w),
                    child: AppContainers.appDivider(),
                  ),
                  SizedBox(height: 13.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 31.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.w),
                          child: Text(
                            'Patient Details',
                            style: AppTextStyles.medium14White.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppButtons.singleTextButton(
                                  textIsBlack: !state.isAccountOwner,
                                  isGradient: state.isAccountOwner,
                                  text: 'Yourself',
                                  onPressed: () => _cubit.selectPatient(true),
                                  height: 18.h,
                                  horizontalPadding: 10.w,
                                ),
                                SizedBox(width: 3.w),
                                AppButtons.singleTextButton(
                                  textIsBlack: true,
                                  isGradient: !state.isAccountOwner,
                                  text: 'Another Person',
                                  onPressed: () => _cubit.selectPatient(false),
                                  height: 18.h,
                                  horizontalPadding: 7.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 18.h),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            'Full Name',
                            style: AppTextStyles.regular14Black,
                          ),
                        ),
                        AppInputs.inputName(
                          isGradient: false,
                          controller: _patientNameController,
                          hint: 'Full name',
                          height: 35.h,
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            'Age',
                            style: AppTextStyles.regular14Black,
                          ),
                        ),
                        AppInputs.inputAge(
                          controller: _patientAgeController,
                          hint: 'Age',
                          height: 35.h,
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            'Gender',
                            style: AppTextStyles.regular14Black,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 61.w,
                              child: AppButtons.singleTextButton(
                                textIsBlack: true,
                                isGradient: state.gender == Gender.male,
                                text: 'Male',
                                onPressed: () =>
                                    _cubit.selectGender(Gender.male),
                                height: 18.h,
                                horizontalPadding: 10.w,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SizedBox(
                              width: 61.w,
                              child: AppButtons.singleTextButton(
                                textIsBlack: true,
                                isGradient: state.gender == Gender.female,
                                text: 'Female',
                                onPressed: () =>
                                    _cubit.selectGender(Gender.female),
                                height: 18.h,
                                horizontalPadding: 7.w,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SizedBox(
                              width: 61.w,
                              child: AppButtons.singleTextButton(
                                textIsBlack: true,
                                isGradient: state.gender == Gender.other,
                                text: 'Other',
                                onPressed: () =>
                                    _cubit.selectGender(Gender.other),
                                height: 18.h,
                                horizontalPadding: 7.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 21.h),
                        AppContainers.appDivider(),
                        SizedBox(height: 13.h),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            'Describe your problem',
                            style: AppTextStyles.regular14Black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        AppInputs.inputText(
                          hint: 'Enter your Problem here...',
                          controller: _patientProblemController,
                          height: 97.h,
                        ),
                        SizedBox(height: 25.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22.w),
                          child: AppButtons.singleTextButton(
                            isGradient: true,
                            text: state.status == ScheduleStatus.saving
                                ? 'Saving...'
                                : 'Confirm',
                            onPressed: () => _cubit.confirm(
                              name: _patientNameController.text,
                              age: _patientAgeController.text,
                              problem: _patientProblemController.text,
                            ),
                            height: 48.h,
                            horizontalPadding: 1.w,
                            textStyle: AppTextStyles.semiBold20White,
                          ),
                        ),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _formRevision = 0;
}
