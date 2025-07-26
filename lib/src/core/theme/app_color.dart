import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

class AppColor {
  static const String primary = 'primary';
  static const String secondary = 'secondary';
  static const String background = 'background';
  static const String surface = 'surface';
  static const String error = 'error';

  static Color get(BuildContext context, String key) {
    final theme = Provider.of<ThemeManager>(context, listen: true).current;
    switch (key) {
      case primary:
        return theme.colorPreset.primary;
      case secondary:
        return theme.colorPreset.light;
      case background:
        return theme.brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : CupertinoColors.white;
      case surface:
        return theme.colorPreset.lighter;
      case error:
        return CupertinoColors.systemRed;
      default:
        return theme.colorPreset.primary;
    }
  }
}