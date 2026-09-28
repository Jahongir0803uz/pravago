import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';

class FeaturesCardWidget extends StatelessWidget {
  final bool isDark;

  const FeaturesCardWidget({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBgColor = isDark ? AppColors.blue950 : AppColors.blue200;
    final borderColor = isDark ? AppColors.blue200 : AppColors.blue500;

    return Container(
      padding: AppPadding.pA14,
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: AppRadius.r20,
        border: Border.all(color: borderColor, width: 2.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FeatureItem(
            icon: Iconsax.task_square,
            title: AppTextStrings.featuresTitleOne,
            isDark: isDark,
          ),
          _FeatureItem(
            icon: Iconsax.route_square,
            title: AppTextStrings.featuresTitleTwo,
            isDark: isDark,
          ),
          _FeatureItem(
            icon: Iconsax.teacher,
            title: AppTextStrings.featuresTitleThree,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDark;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final iconBgColor = isDark ? AppColors.blue900 : AppColors.blue400;
    final textColor = isDark ? AppColors.white : AppColors.blue950;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSize.loader34,
          height: AppSize.loader34,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: AppRadius.r10,
          ),
          child: Icon(icon, size: 20.r, color: AppColors.grey200),
        ),
        AppSpacing.w10,
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontSize: AppFontSize.fs10,
              fontWeight: FontWeight.w600,
              color: textColor,
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}
