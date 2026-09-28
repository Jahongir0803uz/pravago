import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';

sealed class AppSnackBar {
  static void showError(
      BuildContext context, {
        required String message,
        String? title,
      }) {
    _showCustomSnackBar(
      context,
      message: message,
      title: title ?? AppTextStrings.error,
      icon: Iconsax.warning_2,
      backgroundColor: AppColors.error,
      iconColor: AppColors.error,
    );
  }

  static void showSuccess(
      BuildContext context, {
        required String message,
        String? title,
      }) {
    _showCustomSnackBar(
      context,
      message: message,
      title: title ?? AppTextStrings.success,
      icon: Iconsax.tick_circle,
      backgroundColor: AppColors.success,
      iconColor: AppColors.success,
    );
  }

  static void showInfo(
      BuildContext context, {
        required String message,
        String? title,
      }) {
    _showCustomSnackBar(
      context,
      message: message,
      title: title ?? AppTextStrings.info,
      icon: Iconsax.info_circle,
      backgroundColor: AppColors.info,
      iconColor: AppColors.info,
    );
  }

  static void _showCustomSnackBar(
      BuildContext context, {
        required String message,
        required String title,
        required IconData icon,
        required Color backgroundColor,
        required Color iconColor,
      }) {

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.transparent,
          margin: AppPadding.mB20L16R16,
          duration: const Duration(seconds: 3),
          content: Container(
            padding: AppPadding.pA8,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: AppRadius.r20,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 20.r),
                ),
                AppSpacing.w10,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: AppFontSize.fs14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      AppSpacing.h4,
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: AppFontSize.fs10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}