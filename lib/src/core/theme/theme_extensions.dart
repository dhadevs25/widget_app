import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

extension ThemeColorExtension on BuildContext {
  Color get primaryColor =>
      Provider.of<ThemeManager>(this, listen: true).current.colorPreset.primary;
  Color get secondaryColor =>
      Provider.of<ThemeManager>(this, listen: true).current.colorPreset.light;
  Color get lighterColor =>
      Provider.of<ThemeManager>(this, listen: true).current.colorPreset.lighter;
  Color get darkColor =>
      Provider.of<ThemeManager>(this, listen: true).current.colorPreset.dark;
  Color get darkerColor =>
      Provider.of<ThemeManager>(this, listen: true).current.colorPreset.darker;
  Color get backgroundColor {
    final theme = Provider.of<ThemeManager>(this, listen: true).current;
    return theme.brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : CupertinoColors.white;
  }

  Color get errorColor => CupertinoColors.systemRed;
}
