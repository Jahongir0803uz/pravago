import 'package:flutter/material.dart';
import 'package:pravago/core/constants/image_strings.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';

class HeaderWidget extends StatelessWidget {
  final Color titleColor;

  const HeaderWidget({super.key, required this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImageStrings.appLogo,
          height: AppSize.loader60,
          width: AppSize.loader60,
        ),
        AppSpacing.w10,
        Text(
          AppTextStrings.appName,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: AppFontSize.fs24,
            fontWeight: FontWeight.w900,
            color: titleColor,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}