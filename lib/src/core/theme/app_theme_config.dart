import 'package:flutter/cupertino.dart';

import 'app_color_preset.dart';

class AppThemeConfig {
  final Brightness brightness;
  final AppColorPreset colorPreset;
  final String fontFamily;
  final double fontSize;

  const AppThemeConfig({
    required this.brightness,
    required this.colorPreset,
    required this.fontFamily,
    required this.fontSize,
  });

  CupertinoThemeData toCupertinoTheme() {
    return CupertinoThemeData(
      brightness: brightness,
      primaryColor: colorPreset.primary,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: brightness == Brightness.dark
              ? CupertinoColors.white
              : CupertinoColors.black,
        ),
      ),
      scaffoldBackgroundColor: brightness == Brightness.dark
          ? Color(0xFF09090B) // từ commonColors.black
          : CupertinoColors.white,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brightness': brightness == Brightness.dark ? 'dark' : 'light',
      'colorPreset': colorPresetToString(colorPreset),
      'fontFamily': fontFamily,
      'fontSize': fontSize,
    };
  }

  static AppThemeConfig fromMap(Map<String, dynamic> map) {
    return AppThemeConfig(
      brightness: map['brightness'] == 'dark'
          ? Brightness.dark
          : Brightness.light,
      colorPreset: colorPresetFromString(map['colorPreset'] ?? 'defaultPreset'),
      fontFamily: map['fontFamily'] ?? 'Roboto',
      fontSize: (map['fontSize'] is int)
          ? (map['fontSize'] as int).toDouble()
          : (map['fontSize'] as double? ?? 16.0),
    );
  }

  static String colorPresetToString(AppColorPreset preset) {
    if (preset == PresetColors.cyan) return 'cyan';
    if (preset == PresetColors.purple) return 'purple';
    if (preset == PresetColors.blue) return 'blue';
    if (preset == PresetColors.orange) return 'orange';
    if (preset == PresetColors.red) return 'red';
    return 'defaultPreset';
  }

  static AppColorPreset colorPresetFromString(String value) {
    switch (value) {
      case 'cyan':
        return PresetColors.cyan;
      case 'purple':
        return PresetColors.purple;
      case 'blue':
        return PresetColors.blue;
      case 'orange':
        return PresetColors.orange;
      case 'red':
        return PresetColors.red;
      default:
        return PresetColors.defaultPreset;
    }
  }
}
