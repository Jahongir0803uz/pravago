import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/image_strings.dart';
import 'package:pravago/core/constants/sizes.dart';

class IllustrationCardWidget extends StatelessWidget {
  final bool isDark;

  const IllustrationCardWidget({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBgColor = isDark ? AppColors.blue600 : AppColors.blue400;
    final cardBorderColor = isDark ? AppColors.blue200 : AppColors.blue100;

    return SizedBox(
      height: 420.h,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            top: 24.h,
            right: 0,
            left: 20.h,
            child: Transform.rotate(
              angle: 0.1,
              child: Container(
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: AppRadius.r40,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 10.w,
            right: 14.w,
            bottom: 14.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: cardBgColor,
                borderRadius: AppRadius.r40,
                border: Border.all(color: cardBorderColor, width: 4.w),
              ),
              child: ClipRRect(
                borderRadius: AppRadius.r40,
                child: Image.asset(
                  AppImageStrings.onboarding,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}