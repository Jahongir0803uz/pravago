import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';

sealed class AppbarTheme {
  static final lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    iconTheme: IconThemeData(color: AppColors.blue950, size: 24.sp),
    actionsIconTheme: IconThemeData(color: AppColors.blue950, size: 24.sp),
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18.sp,
      color: AppColors.blue950,
      fontWeight: FontWeight.w600,
    ),
  );

  static final darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    iconTheme: IconThemeData(color: AppColors.white, size: 24.sp),
    actionsIconTheme: IconThemeData(color: AppColors.white, size: 24.sp),
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18.sp,
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
  );
}