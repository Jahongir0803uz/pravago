import 'package:flutter/material.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/theme/custom/appbar_theme.dart';
import 'package:pravago/core/theme/custom/bottom_sheet_theme.dart';
import 'package:pravago/core/theme/custom/checkbox_theme.dart';
import 'package:pravago/core/theme/custom/chip_theme.dart';
import 'package:pravago/core/theme/custom/elevated_button.dart';
import 'package:pravago/core/theme/custom/outlined_button_theme.dart';
import 'package:pravago/core/theme/custom/text_field_theme.dart';
import 'package:pravago/core/theme/custom/text_theme.dart';

sealed class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.blue500,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    appBarTheme: AppbarTheme.lightAppBarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButton,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.blue950,
    primaryColor: AppColors.blue500,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    appBarTheme: AppbarTheme.darkAppBarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButton,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
  );
}