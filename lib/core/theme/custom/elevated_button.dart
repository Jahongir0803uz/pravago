import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';

sealed class AppElevatedButtonTheme {
  static final lightElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.transparent,
      disabledBackgroundColor: AppColors.transparent,
      disabledForegroundColor: AppColors.white,
      overlayColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      minimumSize: Size(double.infinity, 52.h),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      textStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
  );

  static final darkElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.transparent,
      disabledBackgroundColor: AppColors.transparent,
      disabledForegroundColor: AppColors.white,
      minimumSize: Size(double.infinity, 52.h),
      overlayColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      textStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
  );
}
