import 'package:tsi_ind_pr_2/domain/filters/doctor_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/bloc/doctor_state.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/bloc/doctors_cubit.dart';
import 'package:tsi_ind_pr_2/domain/repositories/doctors_repository.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';

import 'package:tsi_ind_pr_2/presentation/doctors/widgets/doctors_list.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/specialty_view.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/widgets/specialties_filter.dart';
import 'package:tsi_ind_pr_2/presentation/doctors/widgets/specialties_header.dart';

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
  late final DoctorsCubit _cubit;
  String _search = '';
  DoctorFilters _filters = DoctorFilters();
  Set<DoctorType> _selectedTypes = DoctorType.values.toSet();
  SortOrder sortOrder = SortOrder.ascending;

  @override
  void initState() {
    _cubit = BlocProvider.of<DoctorsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: SpecialtiesHeader(
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
            ),
            PinnedHeaderSliver(
              child: ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          SpecialityWiev(
                            selectedTypes: _selectedTypes,
                            onChanged: (selectedTypes) {
                              setState(
                                () => _selectedTypes = Set.of(selectedTypes),
                              );
                            },
                          ),
                          SizedBox(height: 17.h),
                          Divider(
                            height: 1.h,
                            color: AppColors.primary,
                            thickness: 1.h,
                          ),
                          SizedBox(height: 12.h),
                          SpecialtiesFilter(
                            trailingText: 'Top Rating',
                            onFilterPressed: () async {
                              final result = await context
                                  .pushNamed<DoctorFilters>(
                                    'filters',
                                    extra: DoctorFilters(
                                      gender: _filters.gender,
                                      minimumRating: _filters.minimumRating,
                                      experience: _filters.experience,
                                      types: _selectedTypes,
                                    ),
                                  );
                              if (!mounted || result == null) return;
                              setState(() {
                                _filters = result;
                                _selectedTypes = Set.of(result.types);
                              });
                            },
                            sortOrder: sortOrder,
                            onPressed: () {
                              setState(() {
                                sortOrder = sortOrder == SortOrder.ascending
                                    ? SortOrder.descending
                                    : SortOrder.ascending;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                  ],
                ),
              ),
            ),
            BlocBuilder<DoctorsCubit, DoctorsState>(
              builder: (context, state) {
                if (state is Loaded) {
                  final visibleDoctors = _cubit.filterAndSortDoctors(
                    doctors: state.doctors,
                    selectedTypes: _selectedTypes,
                    sortOrder: sortOrder,
                    search: _search,
                    filters: DoctorFilters(
                      gender: _filters.gender,
                      minimumRating: _filters.minimumRating,
                      experience: _filters.experience,
                      types: _selectedTypes,
                    ),
                  );
                  if (visibleDoctors.isEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text('No doctors match your filters.'),
                      ),
                    );
                  }
                  return DoctorsLw(doctorList: visibleDoctors, sliver: true);
                }
                return switch (state) {
                  Loading() => const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  ),

                  EmptyState() => const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('No doctors available.')),
                  ),

                  Loaded() => const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),

                  ErrorState(:final message) => SliverFillRemaining(
                    hasScrollBody: false,
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
