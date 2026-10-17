import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_state.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_type.dart';

import 'package:tsi_ind_pr_2/data/doctors/doctors_cubit.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

import 'package:tsi_ind_pr_2/presentation/widgets/specialties_filter.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/specialties_header.dart';

class DocBySpecialty extends StatefulWidget {
  const new({super.key, required this.doctorType});

  final DoctorType doctorType;

  @override
  State<DocBySpecialty> createState() => _DocBySpecialtyState();
  Widget withCubit() => BlocProvider(
    create: (context) => DoctorsCubit(context.read()),
    child: DocBySpecialty(doctorType: doctorType),
  );
}

class _DocBySpecialtyState extends State<DocBySpecialty> {
  late final DoctorsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read();
    _cubit.load(type: widget.doctorType);
  }

  @override
  Widget build(BuildContext context) {
    SortOrder sortOrder = SortOrder.ascending;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SpecialtiesHeader(
              title: widget.doctorType.title,
              onSearchChanged: (value) =>
                  showActionMessage(context, 'not awaible yet'),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed('specialties');
                }
              },
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 31.w),
              child: SpecialtiesFilter(
                trailingText: 'See all',
                sortOrder: sortOrder,
                onPressed: () {
                  setState(() {
                    sortOrder = sortOrder == SortOrder.ascending
                        ? SortOrder.descending
                        : SortOrder.ascending;
                  });
                },
              ),
            ),
            SizedBox(height: 14.h),
            BlocBuilder<DoctorsCubit, DoctorsState>(
              builder: (context, state) {
                return switch (state) {
                  Loading() => const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  ErrorState(:final message) => Expanded(
                    child: Center(child: Text(message)),
                  ),

                  EmptyState() => const Expanded(
                    child: Center(child: Text('There is no doctors')),
                  ),
                  Loaded(:final doctors) => Expanded(
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(left: 27.w, right: 31.w),
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 13.h),
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = doctors[index];
                          return SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    AppContainers.networkImage(
                                      imageUrl: doctor.image,
                                    ),
                                    SizedBox(width: 13.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doctor.name,
                                            style: AppTextStyles.medium15Prime,
                                          ),
                                          Text(
                                            doctor.specialization,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.light13Prime
                                                .copyWith(
                                                  color: AppColors.text2,
                                                ),
                                          ),
                                          SizedBox(height: 15.h),
                                          Row(
                                            children: [
                                              AppButtons.infoOutlinedPrimeBTN(
                                                horizontalPadding: 15.w,
                                                verticalPadding: 2.h,
                                                onPressed: () =>
                                                    context.pushNamed(
                                                      'doctors_info',
                                                      extra: doctor,
                                                    ),
                                                plaintText: 'Info',
                                              ),
                                              Spacer(),
                                              IconButton(
                                                tooltip: 'Schedule',
                                                onPressed: () =>
                                                    context.pushNamed(
                                                      'schedule',
                                                      extra: doctor,
                                                    ),
                                                icon:
                                                    AppIcons.bookingOutlinedIcon(
                                                      color: AppColors.primary,
                                                      width: 13.w,
                                                      height: 14.82.h,
                                                    ),
                                              ),
                                              SizedBox(width: 14.w),
                                              AppIcons.questionsIcon(
                                                color: AppColors.primary,
                                                width: 14.w,
                                                height: 14.h,
                                              ),
                                              SizedBox(width: 14.w),
                                              AppIcons.heartIcon(
                                                color: AppColors.primary,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Divider(
                                  thickness: 1,
                                  height: 1.h,
                                  color: AppColors.elements,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
