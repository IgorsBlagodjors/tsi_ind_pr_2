import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/specialties.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_selectors.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/Specialties_header.dart';
import 'package:tsi_ind_pr_2/presentation/specialties/widgets/specialties_filter.dart';

class Specialties extends StatefulWidget {
  const new({super.key});

  @override
  State<Specialties> createState() => _SpecialtiesState();
}

class _SpecialtiesState extends State<Specialties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SpecialtiesHeader(
              title: 'Specialties',
              onPressed: () => context.pop(),
            ),
            SizedBox(height: 25.h),
            SpecialtiesFilter(trailingText: 'Doctors'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.26.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 11,
                    mainAxisExtent: 129.h,
                  ),
                  itemBuilder: ((context, index) {
                    final item = specialties[index];

                    return AppSelectors.specialitySelector(
                      isClicked: true,
                      onPressed: () {
                        context.pushNamed('doctors_page', extra: item['type']);
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
                  itemCount: specialties.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
