import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:widget_app/src/app.dart';
import 'package:widget_app/src/core/theme/app_color_preset.dart';
import 'package:widget_app/src/core/theme/app_theme_config.dart';
import 'package:widget_app/src/core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedTheme = await ThemeManager.loadThemeFromPrefs();
  final defaultTheme = AppThemeConfig(
    brightness: Brightness.light,
    colorPreset: PresetColors.defaultPreset,
    fontFamily: 'Roboto',
    fontSize: 16,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(savedTheme ?? defaultTheme),
      child: const MyApp(),
    ),
  );
}
