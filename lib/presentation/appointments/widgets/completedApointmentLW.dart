import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:go_router/go_router.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class CompletedApointmentlw extends StatelessWidget {
  const CompletedApointmentlw({super.key, required this.doctors});
  final List<Doctor> doctors;
  @override
  Widget build(BuildContext context) => Expanded(
    child: ListView.separated(
      key: const PageStorageKey('CompletedApointmentlw'),
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: doctors.length,
      itemBuilder: (context, index) => _appointment(context, doctors[index]),
      separatorBuilder: (context, index) =>
          Divider(height: 1, thickness: 1, color: AppColors.outline),
    ),
  );
  Widget _appointment(BuildContext context, Doctor doctor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 33,
                backgroundImage: AssetImage(doctor.image),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.1,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      doctor.specialization,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.15,
                        color: AppColors.text2,
                      ),
                    ),

                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.outline),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 13,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              const Text('5', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          doctor.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 15,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: AppButtons.singleTextButton(
                  text: 'Re-Book',
                  onPressed: () => context.pushNamed('schedule', extra: doctor),
                  height: 30,
                  horizontalPadding: 6.0,
                  adaptiveHeight: true,
                  textStyle: TextStyle(fontSize: 18, color: AppColors.text2),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: AppButtons.singleTextButton(
                  text: 'Add Review',
                  onPressed: () => showActionMessage(context, 'Add Review'),
                  height: 30,
                  horizontalPadding: 6.0,
                  adaptiveHeight: true,
                  textStyle: TextStyle(fontSize: 18, color: AppColors.text2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
