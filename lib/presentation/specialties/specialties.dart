import 'package:tsi_ind_pr_2/data/doctors/doctor_filters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/doc_by_specialty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/app_constants.dart';
import 'package:tsi_ind_pr_2/data/app_enums.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_selectors.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/specialties_filter.dart';
import 'package:tsi_ind_pr_2/presentation/widgets/specialties_header.dart';

class Specialties extends StatefulWidget {
  const new({super.key});

  @override
  State<Specialties> createState() => _SpecialtiesState();
}

class _SpecialtiesState extends State<Specialties> {
  SortOrder sortOrder = SortOrder.ascending;
  String _search = '';
  DoctorFilters _filters = DoctorFilters();
  Stream<List<Doctor>>? _doctors;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Doctor>>(
      stream: _doctors,
      builder: (context, snapshot) {
        final matchingTypes = _doctors == null
            ? null
            : snapshot.data
                  ?.where(_filters.matches)
                  .map((doctor) => doctor.type)
                  .toSet();
        final visibleSpecialties =
            specialties
                .where(
                  (item) =>
                      item['title'].toString().toLowerCase().contains(
                        _search,
                      ) &&
                      _filters.types.contains(item['type']) &&
                      (matchingTypes == null ||
                          matchingTypes.contains(item['type'])),
                )
                .toList()
              ..sort((a, b) {
                final comparison = a['title'].toString().compareTo(
                  b['title'].toString(),
                );
                return sortOrder == SortOrder.ascending
                    ? comparison
                    : -comparison;
              });
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SpecialtiesHeader(
                  title: 'Specialties',
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
                SizedBox(height: 25.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 31.w),
                  child: SpecialtiesFilter(
                    onFilterPressed: () async {
                      final result = await context.pushNamed<DoctorFilters>(
                        'filters',
                        extra: _filters,
                      );
                      if (!mounted || result == null) return;
                      setState(() {
                        _filters = result;
                        _doctors =
                            result.gender != null ||
                                result.minimumRating > 0 ||
                                result.experience != null
                            ? (_doctors ??
                                  context
                                      .read<DoctorsRepository>()
                                      .watchDoctors())
                            : null;
                      });
                    },
                    trailingText: 'Doctors',
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
                Expanded(
                  child: _doctors != null && snapshot.hasError
                      ? const Center(child: Text('Unable to load doctors.'))
                      : _doctors != null && !snapshot.hasData
                      ? const Center(child: CircularProgressIndicator())
                      : visibleSpecialties.isEmpty
                      ? const Center(
                          child: Text('No specialties match your filters.'),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.26.w),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 11,
                                  mainAxisExtent: 129.h,
                                ),
                            itemBuilder: ((context, index) {
                              final item = visibleSpecialties[index];

                              return AppSelectors.specialitySelector(
                                isClicked: true,
                                onPressed: () {
                                  context.pushNamed(
                                    'doc_by_specialty',
                                    extra: DocBySpecialtyArgs(
                                      item['type'] as DoctorType,
                                      _filters,
                                    ),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  item['image']!.toString(),
                                  width: 40.w,
                                  height: 40.h,
                                ),
                                text: item['title']!.toString(),
                                fontSize: 17.84,
                              );
                            }),
                            itemCount: visibleSpecialties.length,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
