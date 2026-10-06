import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

enum PatientGender { male, female, other }

class Schedule extends StatefulWidget {
  const new({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  bool patientDetailsYourself = true;
  PatientGender _selectedGender = PatientGender.male;
  final _patientNameController = TextEditingController();
  final _patientAgeController = TextEditingController();
  final _patientProblemController = TextEditingController();

  @override
  void dispose() {
    _patientNameController.dispose();
    _patientAgeController.dispose();
    _patientProblemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            onPressed: () =>
                                showActionMessage(context, 'phone'),
                            icon: AppIcons.phoneIcon(),
                          ),
                          SizedBox(width: 2.w),
                          AppButtons.circleIconBTN(
                            radius: 10.5.r,
                            onPressed: () =>
                                showActionMessage(context, 'camera'),
                            icon: AppIcons.cameraIcon(),
                          ),
                          SizedBox(width: 2.w),
                          AppButtons.circleIconBTN(
                            radius: 10.5.r,
                            onPressed: () => showActionMessage(context, 'chat'),
                            icon: AppIcons.chatOutlinedIcon(
                              width: 12.w,
                              height: 11.h,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          AppButtons.circleIconBTN(
                            fullWhite: true,
                            radius: 10.5.r,
                            onPressed: () =>
                                showActionMessage(context, 'questions'),
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
                            onPressed: () =>
                                showActionMessage(context, 'questions'),
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
              AppointmentCalendar(doctorId: widget.doctor.id),
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
                      child: Row(
                        children: [
                          AppButtons.singleTextButton(
                            textIsBlack: !patientDetailsYourself,
                            isGradient: patientDetailsYourself,
                            text: 'Yourself',
                            onPressed: () => setState(() {
                              patientDetailsYourself = true;
                            }),
                            height: 18.h,
                            horizontalPadding: 10.w,
                          ),
                          SizedBox(width: 3.w),
                          AppButtons.singleTextButton(
                            textIsBlack: true,
                            isGradient: !patientDetailsYourself,
                            text: 'Another Person',
                            onPressed: () => setState(() {
                              patientDetailsYourself = false;
                            }),
                            height: 18.h,
                            horizontalPadding: 7.w,
                          ),
                        ],
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
                      height: 35.h,
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text('Age', style: AppTextStyles.regular14Black),
                    ),
                    AppInputs.inputAge(
                      controller: _patientAgeController,
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
                            isGradient: _selectedGender == PatientGender.male,
                            text: 'Male',
                            onPressed: () => setState(() {
                              _selectedGender = PatientGender.male;
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
                            isGradient: _selectedGender == PatientGender.female,
                            text: 'Female',
                            onPressed: () => setState(() {
                              _selectedGender = PatientGender.female;
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
                            isGradient: _selectedGender == PatientGender.other,
                            text: 'Other',
                            onPressed: () => setState(() {
                              _selectedGender = PatientGender.other;
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
                      controller: _patientProblemController,
                      height: 97.h,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
