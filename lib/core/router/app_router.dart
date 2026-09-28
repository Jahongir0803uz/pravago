import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pravago/core/di/service_locator.dart';
import 'package:pravago/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pravago/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:pravago/features/auth/presentation/screens/login_screen.dart';
import 'package:pravago/features/main/main_screen.dart';
import 'package:pravago/features/onboarding/onboarding_screen.dart';
import 'package:pravago/features/splash/splash_screen.dart';

class AppRouter {
  // Routes paths
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String forgotPassword = '/forgot_password';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRouter.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRouter.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRouter.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRouter.forgotPassword,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: AppRouter.main,
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}