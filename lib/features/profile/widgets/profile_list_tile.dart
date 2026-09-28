import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pravago/core/constants/app_colors.dart';

class ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final String? subtitle;
  final String? trailingText;
  final Color? iconColor;
  final Color? textColor;
  final bool enabled;

  const ProfileListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailingText,
    this.iconColor,
    this.textColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      enabled: enabled,
      leading: Icon(
        icon,
        color: enabled ? (iconColor ?? AppColors.blue400) : AppColors.grey500,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: enabled
              ? (textColor ?? (isDark ? AppColors.white : AppColors.blue950))
              : AppColors.grey500,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(fontSize: 11.sp, color: AppColors.grey500),
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText!,
              style: TextStyle(
                color: isDark ? AppColors.blue200 : AppColors.grey500,
                fontSize: 12.sp,
              ),
            ),
          SizedBox(width: 4.w),
          Icon(
            Iconsax.arrow_right_3,
            size: 15.r,
            color: isDark ? AppColors.blue300 : AppColors.grey400,
          ),
        ],
      ),
      onTap: enabled ? onTap : null,
    );
  }
}
