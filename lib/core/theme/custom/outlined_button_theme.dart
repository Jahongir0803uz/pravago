import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';

sealed class AppOutlinedButtonTheme {
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.blue600,
      side: BorderSide(color: AppColors.blue500, width: 1.5.w),
      minimumSize: Size(double.infinity, 52.h),
      textStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.blue300,
      side: BorderSide(color: AppColors.blue400, width: 1.5.w),
      minimumSize: Size(double.infinity, 52.h),
      textStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
  );
}