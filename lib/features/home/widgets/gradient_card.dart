import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pravago/core/constants/app_colors.dart';

class GradientCard extends StatelessWidget {
  final String? subtitleTop;
  final String title;
  final String description;
  final Widget icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  final bool isFullWidth;

  const GradientCard({
    super.key,
    this.subtitleTop,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isFullWidth ? 160.h : 180.h,
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: isFullWidth
            ? _buildFullWidthLayout(context)
            : _buildGridLayout(context),
      ),
    );
  }

  // Shablonlar uchun (Full Width Card)
  Widget _buildFullWidthLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (subtitleTop != null) ...[
                Text(
                  subtitleTop!,
                  style: TextStyle(
                    color: AppColors.blue200,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
              ],
              Text(
                title,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                description,
                style: TextStyle(
                  color: AppColors.blue100.withValues(alpha: 0.8),
                  fontSize: 12.sp,
                ),
                maxLines: 2,
              ),
              SizedBox(height: 12.h),
              _buildArrowButton(),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(child: icon),
        ),
      ],
    );
  }

  // Grid Kartalar uchun (Mavzular, Imtihon, Xatolarim va hokazo)
  Widget _buildGridLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 3D Ikonka va konteyneri
        Container(
          width: 50.r,
          height: 50.r,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(child: icon),
        ),
        const Spacer(),

        // Sarlavha
        Text(
          title,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),

        // Tavsif
        Text(
          description,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11.sp,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),

        // Pastki o'ngdagi strelka tugmasi
        Align(
          alignment: Alignment.bottomRight,
          child: _buildArrowButton(),
        ),
      ],
    );
  }

  Widget _buildArrowButton() {
    return Container(
      width: 32.r,
      height: 32.r,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Iconsax.arrow_right_1,
        color: AppColors.white,
        size: 16.r,
      ),
    );
  }
}