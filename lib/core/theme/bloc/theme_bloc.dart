import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pravago/core/di/app_storage.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final AppStorage _appStorage;

  ThemeBloc({required AppStorage appStorage})
    : _appStorage = appStorage,
      super(ThemeState.initial(appStorage.themeModeString)) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ChangeThemeEvent>(_onChangeTheme);
  }

  void _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) {
    final modeString = _appStorage.themeModeString;
    emit(state.copyWith(themeMode: ThemeState._parseThemeMode(modeString)));
  }

  Future<void> _onChangeTheme(
    ChangeThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await _appStorage.setThemeMode(event.themeMode.name);
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
