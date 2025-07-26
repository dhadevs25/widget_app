import 'package:flutter/cupertino.dart';

enum ThemeColorPreset { defaultPreset, cyan, purple, blue, orange, red }


class AppColorPreset {
  final Color lighter;
  final Color light;
  final Color primary;
  final Color dark;
  final Color darker;

  const AppColorPreset({
    required this.lighter,
    required this.light,
    required this.primary,
    required this.dark,
    required this.darker,
  });
}


class PresetColors {
  static const defaultPreset = AppColorPreset(
    lighter: Color(0xFFC8FAD6),
    light: Color(0xFF5BE49B),
    primary: Color(0xFF00A76F),
    dark: Color(0xFF007867),
    darker: Color(0xFF004B50),
  );

  static const cyan = AppColorPreset(
    lighter: Color(0xFFCCF4FE),
    light: Color(0xFF68CDF9),
    primary: Color(0xFF078DEE),
    dark: Color(0xFF0351AB),
    darker: Color(0xFF012972),
  );

  static const purple = AppColorPreset(
    lighter: Color(0xFFEBD6FD),
    light: Color(0xFFB985F4),
    primary: Color(0xFF7635DC),
    dark: Color(0xFF431A9E),
    darker: Color(0xFF200A69),
  );

  static const blue = AppColorPreset(
    lighter: Color(0xFFD1E9FC),
    light: Color(0xFF76B0F1),
    primary: Color(0xFF2065D1),
    dark: Color(0xFF103996),
    darker: Color(0xFF061B64),
  );

  static const orange = AppColorPreset(
    lighter: Color(0xFFFEF4D4),
    light: Color(0xFFFED680),
    primary: Color(0xFFFDA92D),
    dark: Color(0xFFB66816),
    darker: Color(0xFF793908),
  );

  static const red = AppColorPreset(
    lighter: Color(0xFFFFE3D5),
    light: Color(0xFFFF9882),
    primary: Color(0xFFFF3030),
    dark: Color(0xFFB71833),
    darker: Color(0xFF7A0930),
  );
}
