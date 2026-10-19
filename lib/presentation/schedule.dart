import 'package:tsi_ind_pr_2/data/users/app_user.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_cubit.dart';
import 'package:tsi_ind_pr_2/presentation/profile_screens/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/data/appointments/appointments_repository.dart';
import 'package:tsi_ind_pr_2/data/appointments/patient_details.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/appointment_calendar.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class Schedule extends StatefulWidget {
  const new({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  bool patientDetailsYourself = true;
  DateTime? _selectedTime;
  bool _saving = false;
  AppUser? get _profile {
    final state = context.read<ProfileCubit>().state;
    return state is ProfileLoaded ? state.user : null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.watch<ProfileCubit>().state;
    if (!_profileFilled && patientDetailsYourself && state is ProfileLoaded) {
      _fillFromProfile();
      _profileFilled = true;
    }
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
    context.watch<ProfileCubit>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(gradient: AppColors.degradadoAzul),
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
                onChanged: (time) => _selectedTime = time,
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
                              textIsBlack: !patientDetailsYourself,
                              isGradient: patientDetailsYourself,
                              text: 'Yourself',
                              onPressed: () => _selectPatient(true),
                              height: 18.h,
                              horizontalPadding: 10.w,
                            ),
                            SizedBox(width: 3.w),
                            AppButtons.singleTextButton(
                              textIsBlack: true,
                              isGradient: !patientDetailsYourself,
                              text: 'Another Person',
                              onPressed: () => _selectPatient(false),
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
                      child: Text('Age', style: AppTextStyles.regular14Black),
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
                            isGradient: _effectiveGender == Gender.male,
                            text: 'Male',
                            onPressed: () => setState(() {
                              _selectedGender = Gender.male;
                            }),
                            height: 18.h,
                            horizontalPadding: 10.w,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 61.w,
                          child: AppButtons.singleTextButton(
                            textIsBlack: true,
                            isGradient: _effectiveGender == Gender.female,
                            text: 'Female',
                            onPressed: () => setState(() {
                              _selectedGender = Gender.female;
                            }),
                            height: 18.h,
                            horizontalPadding: 7.w,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 61.w,
                          child: AppButtons.singleTextButton(
                            textIsBlack: true,
                            isGradient: _effectiveGender == Gender.other,
                            text: 'Other',
                            onPressed: () => setState(() {
                              _selectedGender = Gender.other;
                            }),
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
                        text: _saving ? 'Saving...' : 'Confirm',
                        onPressed: _confirm,
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
    );
  }

  int? get _profileAge {
    final birth = _profile?.dateOfBirth;
    if (birth == null) return null;
    final now = DateTime.now();
    var age = now.year - birth.year;
    if (now.month < birth.month ||
        (now.month == birth.month && now.day < birth.day)) {
      age--;
    }
    return age >= 0 && age <= 120 ? age : null;
  }

  Gender? get _effectiveGender =>
      _selectedGender ?? (patientDetailsYourself ? _profile?.gender : null);
  bool _profileFilled = false;

  void _fillFromProfile() {
    _patientNameController.text = _profile?.fullName ?? '';
    _patientAgeController.text = _profileAge?.toString() ?? '';
    _selectedGender = _profile?.gender;
  }

  void _selectPatient(bool yourself) {
    setState(() {
      patientDetailsYourself = yourself;
      _patientNameController.clear();
      _patientAgeController.clear();
      _selectedGender = null;
      if (yourself) _fillFromProfile();
    });
  }

  Future<void> _confirm() async {
    if (_saving) return;
    final user = context.read<AuthRepository>().currentUser;
    final time = _selectedTime;
    final ageText = _patientAgeController.text.trim();
    final age = int.tryParse(ageText);
    final nameText = _patientNameController.text.trim();
    final name = nameText;
    final gender = _effectiveGender;
    if (user == null ||
        time == null ||
        age == null ||
        gender == null ||
        name.isEmpty) {
      showActionMessage(
        context,
        'Choose a time and enter the patient name, age and gender.',
      );
      return;
    }
    setState(() => _saving = true);
    try {
      await context.read<AppointmentsRepository>().book(
        userId: user.id,
        doctorId: widget.doctor.id,
        startsAt: time,
        patient: PatientDetails(
          fullName: name,
          age: age,
          gender: gender,
          isAccountOwner: patientDetailsYourself,
          problem: _patientProblemController.text.trim(),
        ),
      );
      if (!mounted) return;
      showActionMessage(context, 'Appointment booked.');
      context.goNamed('apointment');
    } on BookingFailure catch (error) {
      if (mounted) showActionMessage(context, error.message);
    } catch (_) {
      if (mounted) {
        showActionMessage(
          context,
          'Could not save. Check your connection and try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Gender? _selectedGender;
  final _patientNameController = TextEditingController();
  final _patientAgeController = TextEditingController();
  final _patientProblemController = TextEditingController();
}
