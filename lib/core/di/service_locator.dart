import 'package:get_it/get_it.dart';
import 'package:pravago/core/di/app_storage.dart';
import 'package:pravago/core/theme/bloc/theme_bloc.dart';
import 'package:pravago/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pravago/features/auth/domain/repositories/auth_repository.dart';
import 'package:pravago/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pravago/features/profile/bloc/profile_bloc.dart';
import 'package:pravago/features/profile/data/repository/profile_repository_impl.dart';
import 'package:pravago/features/profile/domain/repository/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  sl.registerLazySingleton<AppStorage>(
    () => AppStorage(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<SupabaseClient>(), sl<AppStorage>()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl<SupabaseClient>()),
  );
  // Blocs
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(appStorage: sl<AppStorage>()));

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl<AuthRepository>()),
  );
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(sl<ProfileRepository>()),
  );
}
