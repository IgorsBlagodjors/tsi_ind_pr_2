import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor_state.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_cubit.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

import 'package:tsi_ind_pr_2/presentation/widgets/doctors_lw.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/speciality_wiev.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/specialties_filter.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/specialties_header.dart';

class Doctors extends StatefulWidget {
  const new({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
  static Widget withCubit() => BlocProvider(
    create: (context) =>
        DoctorsCubit(context.read<DoctorsRepository>())..load(),
    child: const Doctors(),
  );
}

class _DoctorsState extends State<Doctors> {
  String _search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SpecialtiesHeader(
              title: 'Doctors',
              onSearchChanged: (value) =>
                  setState(() => _search = value.trim().toLowerCase()),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed('home');
                }
              },
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 31.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.pushNamed('specialties'),
                      child: Text(
                        'See all',
                        style: AppTextStyles.regular12Prime,
                      ),
                    ),
                  ),
                  SpecialityWiev(),
                  SizedBox(height: 17.h),
                  Divider(
                    height: 1.h,
                    color: AppColors.primary,
                    thickness: 1.h,
                  ),
                  SizedBox(height: 12.h),
                  SpecialtiesFilter(trailingText: 'Top Rating'),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            BlocBuilder<DoctorsCubit, DoctorsState>(
              builder: (context, state) {
                return switch (state) {
                  Loading() => const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),

                  EmptyState() => const Expanded(
                    child: Center(child: Text('There is no doctors')),
                  ),

                  Loaded(:final doctors) => DoctorsLw(
                    doctorList: doctors
                        .where(
                          (doctor) =>
                              doctor.name.toLowerCase().contains(_search) ||
                              doctor.specialization.toLowerCase().contains(
                                _search,
                              ),
                        )
                        .toList(),
                  ),

                  ErrorState(:final message) => Expanded(
                    child: Center(child: Text(message)),
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
