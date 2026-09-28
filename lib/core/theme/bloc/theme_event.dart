part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

final class LoadThemeEvent extends ThemeEvent {
  const LoadThemeEvent();
}

final class ChangeThemeEvent extends ThemeEvent {
  final ThemeMode themeMode;

  const ChangeThemeEvent(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}