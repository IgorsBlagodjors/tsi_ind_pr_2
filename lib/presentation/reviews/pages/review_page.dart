import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/domain/repositories/reviews_repository.dart';
import 'package:tsi_ind_pr_2/domain/repositories/auth_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/domain/models/doctors/doctor.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/components/app_inputs.dart';
import 'package:tsi_ind_pr_2/design_system/theme/app_colors.dart';
import 'package:tsi_ind_pr_2/design_system/theme/text_styles.dart';
import 'package:tsi_ind_pr_2/presentation/authentication/widgets/auth_scaffold.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

class ReviewArgs {
  const ReviewArgs({required this.doctor, required this.appointmentId});
  final Doctor doctor;
  final String appointmentId;
}

class Review extends StatefulWidget {
  const Review({super.key, required this.doctor, required this.appointmentId});
  final Doctor doctor;
  final String appointmentId;

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final TextEditingController _inputTextController = TextEditingController();
  int _selectedRating = 5;
  bool _loading = true;
  bool _saving = false;
  bool _submitted = false;
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      backRoute: 'apointment',
      title: 'Review',
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : _loadFailed
          ? Center(
              child: TextButton(
                onPressed: _load,
                child: const Text('Could not load your review. Retry'),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 25.h),
                    Text(
                      _submitted
                          ? 'Thank you for sharing your experience. Your review is saved.'
                          : 'How was your appointment? Select a rating and share your experience.',
                      style: AppTextStyles.light12White.copyWith(
                        color: AppColors.text2,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    AppContainers.cachedNetworkImage(
                      imageUrl: widget.doctor.image,
                      size: 139,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.doctor.name,
                      style: AppTextStyles.medium24Prime.copyWith(height: 1.h),
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.doctor.specialization,
                      style: AppTextStyles.light15Blacke.copyWith(height: 1.h),
                    ),
                    SizedBox(height: 13.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButtons.gradientCircleIconBTN(
                          onPressed: () => showActionMessage(
                            context,
                            'Saving favorites is not connected yet.',
                          ),
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 15.h,
                          ),
                          radius: 12.h,
                        ),
                        SizedBox(width: 3.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 11.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
                            border: BoxBorder.all(
                              width: 2.w,
                              color: AppColors.primary,
                            ),
                          ),
                          child: Row(
                            children: List.generate(5, (index) {
                              final starNumber = index + 1;

                              return GestureDetector(
                                onTap: () {
                                  if (_saving || _submitted) return;
                                  setState(() {
                                    _selectedRating = starNumber;
                                  });
                                },
                                child: Icon(
                                  starNumber <= _selectedRating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: AppColors.primary,
                                  size: 20.sp,
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 19.h),
                    AbsorbPointer(
                      absorbing: _saving || _submitted,
                      child: AppInputs.inputText(
                        fillColor: AppColors.elements,
                        hint: 'Enter your comment here...',
                        controller: _inputTextController,
                        height: 151.h,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: AppButtons.singleTextButton(
                        isGradient: true,
                        text: _submitted
                            ? 'Review added'
                            : _saving
                            ? 'Saving…'
                            : 'Add Review',
                        onPressed: _submit,
                        height: 48.h,
                        horizontalPadding: 1.w,
                        textStyle: AppTextStyles.semiBold20White,
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadFailed = false;
    });
    try {
      final existing = await context
          .read<ReviewsRepository>()
          .getForAppointment(widget.appointmentId);
      if (!mounted) return;
      if (existing != null) {
        _inputTextController.text = existing.text;
        _selectedRating = existing.rating;
        _submitted = true;
      }
    } catch (_) {
      if (mounted) _loadFailed = true;
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _submit() async {
    if (_saving || _submitted || _loading || _loadFailed) return;
    FocusScope.of(context).unfocus();
    setState(() => _saving = true);
    try {
      await context.read<ReviewsRepository>().add(
        appointmentId: widget.appointmentId,
        userId: context.read<AuthRepository>().currentUser?.id ?? '',
        doctorId: widget.doctor.id,
        rating: _selectedRating,
        text: _inputTextController.text,
      );
      if (!mounted) return;
      setState(() => _submitted = true);
      showActionMessage(context, 'Thank you! Your review has been saved.');
    } on ReviewFailure catch (error) {
      if (mounted) showActionMessage(context, error.message);
    } catch (_) {
      if (mounted) {
        showActionMessage(
          context,
          'Could not save your review. Please try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
