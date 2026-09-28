import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/header.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/specialties_filter.dart';

class Specialties extends StatefulWidget {
  const new({super.key});

  @override
  State<Specialties> createState() => _SpecialtiesState();
}

class _SpecialtiesState extends State<Specialties> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(title: 'Specialties', onPressed: () => context.pop()),
            SizedBox(height: 25.h),
            SpecialtiesFilter(trailingText: 'Doctors'),
          ],
        ),
      ),
    );
  }
}
