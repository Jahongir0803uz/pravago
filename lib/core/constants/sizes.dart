import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

sealed class AppSize {
  // Sizes
  static double get logoSize => 200.r;
  static double get googleLogoSize => 24.r;

  // Loader sizes
  static double get loader24 => 24.r;
  static double get loader34 => 34.r;
  static double get loader40 => 40.r;
  static double get loader44 => 44.r;
  static double get loader60 => 60.r;
  static double get loader76 => 76.r;

}

sealed class AppFontSize {
  static double get fs10 => 10.sp;
  static double get fs14 => 14.sp;
  static double get fs24 => 24.sp;
}

sealed class AppSpacing {
  static SizedBox get h4 => SizedBox(height: 4.h);
  static SizedBox get h8 => SizedBox(height: 8.h);
  static SizedBox get h14 => SizedBox(height: 14.h);
  static SizedBox get h20 => SizedBox(height: 20.h);
  static SizedBox get h24 => SizedBox(height: 24.h);
  static SizedBox get h30 => SizedBox(height: 30.h);

  static SizedBox get w6 => SizedBox(width: 6.w);
  static SizedBox get w10 => SizedBox(width: 10.w);

}

sealed class AppPadding {

  static EdgeInsets get mB20L16R16 =>
      EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w);

  // Padding
  static EdgeInsets get pA8 => EdgeInsets.all(8.r);
  static EdgeInsets get pA14 => EdgeInsets.all(14.r);
  static EdgeInsets get pH6 => EdgeInsets.symmetric(horizontal: 6.w);
  static EdgeInsets get pH24 => EdgeInsets.symmetric(horizontal: 24.w);
  static EdgeInsets get pH14V10 => EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h);
  static EdgeInsets get pB30 => EdgeInsets.only(bottom: 30.h);
  static EdgeInsets get pB100 => EdgeInsets.only(bottom: 100.h);


  static EdgeInsets pL24R24T24B(BuildContext context) => EdgeInsets.only(
    bottom: MediaQuery.of(context).viewInsets.bottom,
    left: 24.w,
    right: 24.w,
    top: 24.h,
  );

  static EdgeInsets get pL16R16T0B12 => EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h);
  static EdgeInsets get pL24R24T28B20 => EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 20.h);
}

sealed class AppRadius {
  static BorderRadius get r10 => BorderRadius.circular(10.r);
  static BorderRadius get r14 => BorderRadius.circular(14.r);
  static BorderRadius get r20 => BorderRadius.circular(20.r);
  static BorderRadius get r40 => BorderRadius.circular(40.r);

  static BorderRadius get rVT20 =>
      BorderRadius.vertical(top: Radius.circular(20.r));
}