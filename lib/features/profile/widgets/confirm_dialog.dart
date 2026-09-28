import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.message,
    required this.cancelText,
    required this.confirmText,
    required this.onCancel,
    required this.onConfirm,
    this.warning,
  });

  final IconData icon;
  final Color accentColor;
  final String title;
  final String message;
  final String? warning;
  final String cancelText;
  final String confirmText;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      insetPadding: AppPadding.pH24,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.r20),
      child: Padding(
        padding: AppPadding.pL24R24T28B20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.6, end: 1.0),
              duration: const Duration(milliseconds: 450),
              curve: Curves.elasticOut,
              builder: (_, value, child) =>
                  Transform.scale(scale: value, child: child),
              child: Container(
                width: AppSize.loader76,
                height: AppSize.loader76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withValues(alpha: 0.10),
                ),
                child: Center(
                  child: Container(
                    width: AppSize.loader44,
                    height: AppSize.loader44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor.withValues(alpha: 0.16),
                    ),
                    child: Icon(icon, size: 28.sp, color: accentColor),
                  ),
                ),
              ),
            ),
            AppSpacing.h20,

            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            AppSpacing.h8,

            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4.h,
              ),
            ),

            if (warning != null) ...[
              AppSpacing.h14,
              Container(
                width: double.infinity,
                padding: AppPadding.pH14V10,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.08),
                  borderRadius: AppRadius.r14,
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.warning_2, size: 20.sp, color: accentColor),
                    AppSpacing.w6,
                    Expanded(
                      child: Text(
                        warning!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            AppSpacing.h24,

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.r14,
                      ),
                      side: BorderSide(color: theme.colorScheme.outlineVariant),
                    ),
                    child: Text(
                      cancelText,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                AppSpacing.w10,
                Expanded(
                  child: FilledButton(
                    onPressed: onConfirm,
                    style: FilledButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: AppColors.white,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.r14,
                      ),
                    ),
                    child: Text(
                      confirmText,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
