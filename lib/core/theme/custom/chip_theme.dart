import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';

sealed class AppChipTheme {
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: AppColors.grey200,
    backgroundColor: AppColors.grey100,
    selectedColor: AppColors.blue500,
    secondarySelectedColor: AppColors.blue500,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: AppColors.blue950),
    secondaryLabelStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 13.sp,
      color: AppColors.white,
    ),
    checkmarkColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
      side: BorderSide.none,
    ),
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: AppColors.grey800,
    backgroundColor: AppColors.blue900,
    selectedColor: AppColors.blue500,
    secondarySelectedColor: AppColors.blue500,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: AppColors.white),
    secondaryLabelStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 13.sp,
      color: AppColors.white,
    ),
    checkmarkColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
      side: BorderSide.none,
    ),
  );
}