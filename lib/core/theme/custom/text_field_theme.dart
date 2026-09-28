import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';

sealed class AppTextFormFieldTheme {
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: AppColors.blue500,
    suffixIconColor: AppColors.blue500,
    filled: true,
    fillColor: AppColors.grey50,
    labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: AppColors.grey600),
    hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: AppColors.grey400),
    errorStyle: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: AppColors.error),
    floatingLabelStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: AppColors.blue600,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.w, color: AppColors.grey300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.w, color: AppColors.grey300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.5.w, color: AppColors.blue600),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.w, color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.5.w, color: AppColors.error),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: AppColors.white,
    suffixIconColor: AppColors.white,
    filled: true,
    fillColor: AppColors.blue900,
    labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: AppColors.grey400),
    hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: AppColors.grey500),
    errorStyle: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: AppColors.error),
    floatingLabelStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: AppColors.blue300,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.w, color: AppColors.blue800),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.w, color: AppColors.blue800),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.5.w, color: AppColors.blue400),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.w, color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(width: 1.5.w, color: AppColors.error),
    ),
  );
}