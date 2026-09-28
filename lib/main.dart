import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pravago/core/di/service_locator.dart';
import 'package:pravago/core/router/app_router.dart';
import 'package:pravago/core/theme/bloc/theme_bloc.dart';
import 'package:pravago/core/theme/theme.dart';
import 'package:pravago/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pravago/features/profile/bloc/profile_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://clfplsjzwcfhicnpqzag.supabase.co',
    publishableKey: 'sb_publishable_17j4x-MaBj1caCiu6w5TJg_bCtf-zCs',
  );

  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<ThemeBloc>()..add(const LoadThemeEvent()),
            ),
            BlocProvider(create: (context) => sl<AuthBloc>()),
            BlocProvider(create: (context) => sl<ProfileBloc>()),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'PravaGo',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: state.themeMode,
                routerConfig: AppRouter.router,
              );
            },
          ),
        );
      },
    );
  }
}
