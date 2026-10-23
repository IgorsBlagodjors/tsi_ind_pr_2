import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/domain/enums/app_enums.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_icons.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';

class SpecialityWiev extends StatefulWidget {
  const new({super.key, required this.onChanged, this.selectedTypes});

  final ValueChanged<Set<DoctorType>> onChanged;
  final Set<DoctorType>? selectedTypes;

  @override
  State<SpecialityWiev> createState() => _SpecialityWievState();
}

class _SpecialityWievState extends State<SpecialityWiev> {
  late Set<DoctorType> selectedTypes;
  @override
  void initState() {
    super.initState();
    selectedTypes = Set.of(widget.selectedTypes ?? DoctorType.values.toSet());
  }

  @override
  void didUpdateWidget(covariant SpecialityWiev oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTypes != null) {
      selectedTypes = Set.of(widget.selectedTypes!);
    }
  }

  void toggleSpeciality(DoctorType type) {
    setState(() {
      if (selectedTypes.contains(type)) {
        selectedTypes.remove(type);
      } else {
        selectedTypes.add(type);
      }
    });

    widget.onChanged(Set.of(selectedTypes));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          AppButtons.smallSquareBTN(
            type: DoctorType.gynecology,
            isSelected: selectedTypes.contains(DoctorType.gynecology),
            onPressed: () => toggleSpeciality(DoctorType.gynecology),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.gynecology(
              color: selectedTypes.contains(DoctorType.gynecology)
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            type: DoctorType.oncology,
            isSelected: selectedTypes.contains(DoctorType.oncology),
            onPressed: () => toggleSpeciality(DoctorType.oncology),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.oncology(
              color: selectedTypes.contains(DoctorType.oncology)
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            type: DoctorType.otolaryngology,
            isSelected: selectedTypes.contains(DoctorType.otolaryngology),
            onPressed: () => toggleSpeciality(DoctorType.otolaryngology),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.otolaryngology(
              color: selectedTypes.contains(DoctorType.otolaryngology)
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            type: DoctorType.cardiology,
            isSelected: selectedTypes.contains(DoctorType.cardiology),
            onPressed: () => toggleSpeciality(DoctorType.cardiology),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.cardiology(
              color: selectedTypes.contains(DoctorType.cardiology)
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            type: DoctorType.orthopedics,
            isSelected: selectedTypes.contains(DoctorType.orthopedics),
            onPressed: () => toggleSpeciality(DoctorType.orthopedics),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.orthopedics(
              color: selectedTypes.contains(DoctorType.orthopedics)
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            type: DoctorType.dermatology,
            isSelected: selectedTypes.contains(DoctorType.dermatology),
            onPressed: () => toggleSpeciality(DoctorType.dermatology),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.dermatology(
              color: selectedTypes.contains(DoctorType.dermatology)
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            type: DoctorType.generalMedicine,
            isSelected: selectedTypes.contains(DoctorType.generalMedicine),
            onPressed: () => toggleSpeciality(DoctorType.generalMedicine),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.generalMedicine(
              color: selectedTypes.contains(DoctorType.generalMedicine)
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
          SizedBox(width: 21.w),

          AppButtons.smallSquareBTN(
            type: DoctorType.odontology,
            isSelected: selectedTypes.contains(DoctorType.odontology),
            onPressed: () => toggleSpeciality(DoctorType.odontology),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.odontology(
              color: selectedTypes.contains(DoctorType.odontology)
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
          SizedBox(width: 21.w),
          AppButtons.smallSquareBTN(
            type: DoctorType.ophthalmology,
            isSelected: selectedTypes.contains(DoctorType.ophthalmology),
            onPressed: () => toggleSpeciality(DoctorType.ophthalmology),
            contWidth: 50.w,
            contHeight: 48.96.h,
            radius: 12.r,
            icon: AppIcons.ophtamology(
              color: selectedTypes.contains(DoctorType.ophthalmology)
                  ? Colors.white
                  : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
