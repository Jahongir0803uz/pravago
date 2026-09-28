import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/features/home/widgets/gradient_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: AppPadding.pH24,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppSpacing.h30,

                GradientCard(
                  isFullWidth: true,
                  title: 'Shablonlar',
                  subtitleTop: 'Xush kelibsiz,',
                  description: '1000+ savollar bilan tayyorlaning',
                  icon: Icon(Iconsax.teacher, size: 50.sp, color: AppColors.warning),
                  gradientColors: const [AppColors.blue500, AppColors.blue800],
                  onTap: () {},
                ),

                AppSpacing.h24,

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio: 0.9,
                  children: [
                    GradientCard(
                      title: 'Mavzular',
                      description: "Mavzular bo'yicha tayyorlaning",
                      icon: Icon(Iconsax.folder, size: 28.sp, color: AppColors.blue600),
                      gradientColors: const [AppColors.grey800, AppColors.blue900],
                      onTap: () {},
                    ),

                    GradientCard(
                      title: 'Statistika',
                      description: "O'z ko'rsatkichlaringizni kuzating",
                      icon: Icon(Iconsax.chart_2, size: 28.sp, color: AppColors.blue400),
                      gradientColors: const [AppColors.blue500,AppColors.blue900],
                      onTap: () {},
                    ),

                    // Imtihon
                    GradientCard(
                      title: 'Imtihon',
                      description: 'Haqiqiy imtihon kabi sinab ko\'ring',
                      icon: Icon(Iconsax.teacher, size: 28.sp, color: Colors.purpleAccent),
                      gradientColors: const [Color(0xFF311B92), Color(0xFF1A237E)],
                      onTap: () {},
                    ),

                    // Xatolarim
                    GradientCard(
                      title: 'Xatolarim',
                      description: "O'z xatolaringizni ko'ring",
                      icon: const Icon(Iconsax.warning_2, size: 28, color: Colors.orangeAccent),
                      gradientColors: const [Color(0xFF451A03), Color(0xFF1C1917)],
                      onTap: () {},
                    ),
                  ],
                ),

                AppSpacing.h24,
              ],
            ),
          ),
        ),
      ),
    );
  }
}