import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/constants/app_colors.dart';

sealed class AppCheckboxTheme {
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    checkColor: WidgetStateProperty.resolveWith((states) => AppColors.white),
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.blue500
          : AppColors.transparent,
    ),
    side: BorderSide(color: AppColors.blue500, width: 2.r),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: const VisualDensity(
      horizontal: VisualDensity.minimumDensity,
      vertical: VisualDensity.minimumDensity,
    ),
  );

  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    checkColor: WidgetStateProperty.resolveWith((states) => AppColors.white),
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.blue500
          : AppColors.transparent,
    ),
    side: BorderSide(color: AppColors.grey200, width: 2.r),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: const VisualDensity(
      horizontal: VisualDensity.minimumDensity,
      vertical: VisualDensity.minimumDensity,
    ),
  );
}
