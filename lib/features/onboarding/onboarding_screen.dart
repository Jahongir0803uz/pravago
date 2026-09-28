import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';
import 'package:pravago/core/di/app_storage.dart';
import 'package:pravago/core/di/service_locator.dart';
import 'package:pravago/core/router/app_router.dart';
import 'package:pravago/features/onboarding/widgets/features_card.dart';
import 'package:pravago/features/onboarding/widgets/header.dart';
import 'package:pravago/features/onboarding/widgets/illustration_card.dart';
import 'package:pravago/features/onboarding/widgets/slide_items.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _completedOnboarding(BuildContext context) async {
    await sl<AppStorage>().setFirstTimeCompleted();
    if (!context.mounted) return;
    context.go(AppRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColorList = isDark
        ? const [AppColors.blue950, AppColors.blue900, AppColors.blue800]
        : const [AppColors.blue300, AppColors.blue200, AppColors.blue100];
    final titleColor = isDark ? AppColors.blue50 : AppColors.blue900;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundColorList,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Padding(
                    padding: AppPadding.pH24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fadeSlideItem(
                          HeaderWidget(titleColor: titleColor),
                          0.0,
                          0.35,
                          _controller,
                        ),
                        AppSpacing.h20,
                        fadeSlideItem(
                          IllustrationCardWidget(isDark: isDark),
                          0.08,
                          0.45,
                          _controller,
                        ),
                        AppSpacing.h20,
                        fadeSlideItem(
                          Text(
                            AppTextStrings.onboardingTitle,
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: isDark ? AppColors.white : AppColors.blue950,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          0.18,
                          0.55,
                          _controller,
                        ),
                        AppSpacing.h14,
                        fadeSlideItem(
                          Container(
                            height: 4.h,
                            width: 36.w,
                            decoration: BoxDecoration(
                              color: AppColors.blue500,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          0.22,
                          0.58,
                          _controller,
                        ),
                        AppSpacing.h14,
                        fadeSlideItem(
                          Text(
                            AppTextStrings.onboardingSubtitle,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: isDark
                                  ? AppColors.blue100
                                  : AppColors.blue900.withValues(alpha: 0.8),
                            ),
                          ),
                          0.3,
                          0.65,
                          _controller,
                        ),
                        AppSpacing.h24,
                        fadeSlideItem(
                          FeaturesCardWidget(isDark: isDark),
                          0.42,
                          0.8,
                          _controller,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 20.h),
                child: FadeTransition(
                  opacity: fade(0.6, 1.0, _controller),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(
                          0.6,
                          1.0,
                          curve: Curves.easeOutBack,
                        ),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: AppRadius.r10,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.blue400, AppColors.blue600],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: AppRadius.r10,
                        ),
                        child: InkWell(
                          onTap: () => _completedOnboarding(context),
                          borderRadius: AppRadius.r10,
                          child: Container(
                            height: 52.h,
                            alignment: Alignment.center,
                            child: Text(
                              AppTextStrings.getStarted,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}