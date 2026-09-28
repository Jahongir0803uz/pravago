import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  final SharedPreferences _sharedPreferences;

  AppStorage(this._sharedPreferences);

  static const String _themeKey = 'theme_mode';
  static const String _firstTimeKey = 'is_first_time';
  static const String _rememberMeKey = 'is_remember_me';
  static const String _savedEmailKey = 'saved_email';

  Future<void> saveRememberMe({required bool isRememberMe, String? email}) async {
    await _sharedPreferences.setBool(_rememberMeKey, isRememberMe);
    if (isRememberMe && email != null) {
      await _sharedPreferences.setString(_savedEmailKey, email);
    } else {
      await _sharedPreferences.remove(_savedEmailKey);
    }
  }

  bool get isRememberMe => _sharedPreferences.getBool(_rememberMeKey) ?? false;
  String? get savedEmail => _sharedPreferences.getString(_savedEmailKey);

  Future<bool> setThemeMode(String mode) async {
    return await _sharedPreferences.setString(_themeKey, mode);
  }

  String get themeModeString =>
      _sharedPreferences.getString(_themeKey) ?? 'system';

  Future<bool> setFirstTimeCompleted() async {
    return await _sharedPreferences.setBool(_firstTimeKey, false);
  }

  bool get isFirstTime => _sharedPreferences.getBool(_firstTimeKey) ?? true;
}
