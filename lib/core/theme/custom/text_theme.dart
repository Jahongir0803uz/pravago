import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';

sealed class AppTextTheme {
  static TextTheme get lightTextTheme => TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 26.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.blue950,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.blue950,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.blue950,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.blue950,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.blue950,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.blue950,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.blue950,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.blue900,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.grey500,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.blue950,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.grey600,
    ),
  );

  static TextTheme get darkTextTheme => TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 26.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.blue100,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.grey400,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 11.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.grey400,
    ),
  );
}