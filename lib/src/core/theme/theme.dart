import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'app_theme_config.dart';

class ThemeManager extends ChangeNotifier {
  AppThemeConfig _currentTheme;

  ThemeManager(this._currentTheme);

  AppThemeConfig get current => _currentTheme;

  static const _themePrefsKey = 'app_theme_config';

  Future<void> updateTheme(AppThemeConfig config) async {
    _currentTheme = config;
    notifyListeners();
    await _saveThemeToPrefs(config);
  }

  static Future<AppThemeConfig?> loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_themePrefsKey);
    if (jsonString == null) return null;
    final map = json.decode(jsonString) as Map<String, dynamic>;
    return AppThemeConfig.fromMap(map);
  }

  Future<void> _saveThemeToPrefs(AppThemeConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(config.toMap());
    await prefs.setString(_themePrefsKey, jsonString);
  }
}
