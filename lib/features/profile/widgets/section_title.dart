import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: AppColors.grey500,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
