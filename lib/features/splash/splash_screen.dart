import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pravago/core/constants/app_colors.dart';
import 'package:pravago/core/constants/image_strings.dart';
import 'package:pravago/core/constants/sizes.dart';
import 'package:pravago/core/constants/text_strings.dart';
import 'package:pravago/core/di/app_storage.dart';
import 'package:pravago/core/di/service_locator.dart';
import 'package:pravago/core/router/app_router.dart';
import 'package:pravago/features/auth/domain/repositories/auth_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _loaderOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _setupAnimations();

    _controller.forward();
    _checkNavigation();
  }

  void _setupAnimations() {
    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );

    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.55, curve: Curves.elasticOut),
      ),
    );

    final textAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.75, curve: Curves.easeOut),
    );

    _textOpacity = textAnimation;

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(textAnimation);

    _loaderOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.65, 1.0, curve: Curves.easeIn),
    );
  }

  Future<void> _checkNavigation() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final appStorage = sl<AppStorage>();
    final authRepository = sl<AuthRepository>();
    final isAuthenticated = authRepository.isAuthenticated;
    if (appStorage.isFirstTime) {
      context.go(AppRouter.onboarding);
      return;
    }

    if (!isAuthenticated) {
      context.go(AppRouter.login);
      return;
    }

    context.go(AppRouter.main);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            FadeTransition(
              opacity: _logoOpacity,
              child: ScaleTransition(
                scale: _logoScale,
                child: Image.asset(
                  AppImageStrings.appLogo,
                  height: AppSize.logoSize,
                  width: AppSize.logoSize,
                ),
              ),
            ),

            FadeTransition(
              opacity: _textOpacity,
              child: SlideTransition(
                position: _textSlide,
                child: Text(
                  AppTextStrings.appName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),

            const Spacer(),

            FadeTransition(
              opacity: _loaderOpacity,
              child: SizedBox(
                height: AppSize.loader60,
                width: AppSize.loader60,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: const [
                    AppColors.blue100,
                    AppColors.blue300,
                    AppColors.blue500,
                    AppColors.blue700,
                  ],
                  strokeWidth: 2.w,
                ),
              ),
            ),
            AppSpacing.h20,
          ],
        ),
      ),
    );
  }
}