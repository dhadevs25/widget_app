import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:widget_app/src/core/theme/theme.dart';
import 'app_color_preset.dart';
import 'app_theme_config.dart';

enum ThemeColorPreset { defaultPreset, cyan, purple, blue, red, orange }

class ThemeColorSelector extends StatefulWidget {
  const ThemeColorSelector({super.key});

  @override
  State<ThemeColorSelector> createState() => _ThemeColorSelectorState();
}

class _ThemeColorSelectorState extends State<ThemeColorSelector> {
  final List<String> fonts = ['Roboto', 'Arial', 'Times New Roman'];
  final List<double> fontSizes = [14.0, 16.0, 18.0, 20.0];

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final currentTheme = themeManager.current;
    final selectedPreset = _mapColorToPreset(currentTheme.colorPreset);
    final selectedFont = currentTheme.fontFamily;
    final selectedFontSize = currentTheme.fontSize;

    return Column(
      children: [
        CupertinoSegmentedControl<ThemeColorPreset>(
          groupValue: selectedPreset,
          onValueChanged: (value) {
            _updateTheme(context, preset: value);
          },
          children: const {
            ThemeColorPreset.defaultPreset: Text('Default'),
            ThemeColorPreset.cyan: Text('Cyan'),
            ThemeColorPreset.purple: Text('Purple'),
            ThemeColorPreset.blue: Text('Blue'),
            ThemeColorPreset.red: Text('Red'),
            ThemeColorPreset.orange: Text('Orange'),
          },
        ),
        const SizedBox(height: 16),
        CupertinoSegmentedControl<String>(
          groupValue: selectedFont,
          onValueChanged: (value) {
            _updateTheme(context, font: value);
          },
          children: {for (var font in fonts) font: Text(font)},
        ),
        const SizedBox(height: 16),
        CupertinoSegmentedControl<double>(
          groupValue: selectedFontSize,
          onValueChanged: (value) {
            _updateTheme(context, fontSize: value);
          },
          children: {for (var size in fontSizes) size: Text(size.toString())},
        ),
      ],
    );
  }

  void _updateTheme(
    BuildContext context, {
    ThemeColorPreset? preset,
    String? font,
    double? fontSize,
  }) {
    final themeManager = context.read<ThemeManager>();
    final current = themeManager.current;
    themeManager.updateTheme(
      AppThemeConfig(
        brightness: current.brightness,
        colorPreset: _mapPresetToColor(
          preset ?? _mapColorToPreset(current.colorPreset),
        ),
        fontFamily: font ?? current.fontFamily,
        fontSize: fontSize ?? current.fontSize,
      ),
    );
  }

  ThemeColorPreset _mapColorToPreset(AppColorPreset color) {
    if (color == PresetColors.cyan) return ThemeColorPreset.cyan;
    if (color == PresetColors.purple) return ThemeColorPreset.purple;
    if (color == PresetColors.blue) return ThemeColorPreset.blue;
    if (color == PresetColors.orange) return ThemeColorPreset.orange;
    if (color == PresetColors.red) return ThemeColorPreset.red;
    return ThemeColorPreset.defaultPreset;
  }

  AppColorPreset _mapPresetToColor(ThemeColorPreset preset) {
    switch (preset) {
      case ThemeColorPreset.cyan:
        return PresetColors.cyan;
      case ThemeColorPreset.purple:
        return PresetColors.purple;
      case ThemeColorPreset.red:
        return PresetColors.red;
      case ThemeColorPreset.orange:
        return PresetColors.orange;
      case ThemeColorPreset.blue:
        return PresetColors.blue;
      default:
        return PresetColors.defaultPreset;
    }
  }
}
