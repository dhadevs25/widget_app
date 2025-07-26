import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_app/src/core/theme/theme.dart';
import '../core/theme/app_color_preset.dart';
import '../core/theme/app_theme_config.dart';

enum ThemeColorPreset { defaultPreset, cyan, purple, blue, red, orange }

class ThemeSettingsPopup extends StatefulWidget {
  const ThemeSettingsPopup({super.key});

  @override
  State<ThemeSettingsPopup> createState() => _ThemeSettingsPopupState();
}

class _ThemeSettingsPopupState extends State<ThemeSettingsPopup>
    with TickerProviderStateMixin {
  final List<_FontOption> fonts = [
    _FontOption('Roboto', 'Roboto', CupertinoIcons.textformat),
    _FontOption('Arial', 'Arial', CupertinoIcons.textformat_alt),
    _FontOption('Times New Roman', 'Times', CupertinoIcons.textformat_size),
  ];

  final List<double> fontSizes = [14.0, 16.0, 18.0, 20.0];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final currentTheme = themeManager.current;
    final selectedPreset = _mapColorToPreset(currentTheme.colorPreset);
    final selectedFont = currentTheme.fontFamily;
    final selectedFontSize = currentTheme.fontSize;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildColorSection(selectedPreset),
                      const SizedBox(height: 32),
                      _buildFontSection(selectedFont),
                      const SizedBox(height: 32),
                      _buildFontSizeSection(selectedFontSize),
                    ],
                  ),
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6.resolveFrom(context),
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.separator.resolveFrom(context),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.paintbrush_fill,
            color: CupertinoColors.systemBlue.resolveFrom(context),
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            'Theme Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.label.resolveFrom(context),
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSection(ThemeColorPreset selectedPreset) {
    final colorOptions = [
      _ColorOption(
        ThemeColorPreset.defaultPreset,
        'Default',
        const Color(0xFF007AFF),
        CupertinoIcons.circle_fill,
      ),
      _ColorOption(
        ThemeColorPreset.cyan,
        'Cyan',
        const Color(0xFF32D74B),
        CupertinoIcons.drop_fill,
      ),
      _ColorOption(
        ThemeColorPreset.purple,
        'Purple',
        const Color(0xFFAF52DE),
        CupertinoIcons.star_fill,
      ),
      _ColorOption(
        ThemeColorPreset.blue,
        'Blue',
        const Color(0xFF007AFF),
        CupertinoIcons.cloud_fill,
      ),
      _ColorOption(
        ThemeColorPreset.red,
        'Red',
        const Color(0xFFFF3B30),
        CupertinoIcons.heart_fill,
      ),
      _ColorOption(
        ThemeColorPreset.orange,
        'Orange',
        const Color(0xFFFF9500),
        CupertinoIcons.sun_max_fill,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Color Theme', CupertinoIcons.paintbrush),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6
                .resolveFrom(context)
                .withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: colorOptions.length,
            itemBuilder: (context, index) {
              final option = colorOptions[index];
              final isSelected = selectedPreset == option.preset;

              return GestureDetector(
                onTap: () => _updateTheme(context, preset: option.preset),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        option.color,
                        option.color.withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected
                        ? Border.all(
                            color: CupertinoColors.label.resolveFrom(context),
                            width: 3,
                          )
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: option.color.withValues(alpha: 0.3),
                        blurRadius: isSelected ? 12 : 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isSelected
                            ? CupertinoIcons.checkmark_circle_fill
                            : option.icon,
                        color: CupertinoColors.white,
                        size: isSelected ? 28 : 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        option.name,
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFontSection(String selectedFont) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Font Family', CupertinoIcons.textformat),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6
                .resolveFrom(context)
                .withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: fonts.asMap().entries.map((entry) {
              final index = entry.key;
              final font = entry.value;
              final isSelected = selectedFont == font.value;
              final isFirst = index == 0;
              final isLast = index == fonts.length - 1;

              return GestureDetector(
                onTap: () => _updateTheme(context, font: font.value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? CupertinoColors.systemBlue
                              .resolveFrom(context)
                              .withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.vertical(
                      top: isFirst ? const Radius.circular(16) : Radius.zero,
                      bottom: isLast ? const Radius.circular(16) : Radius.zero,
                    ),
                    border: !isLast
                        ? Border(
                            bottom: BorderSide(
                              color: CupertinoColors.separator.resolveFrom(
                                context,
                              ),
                              width: 0.5,
                            ),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        font.icon,
                        color: isSelected
                            ? CupertinoColors.systemBlue.resolveFrom(context)
                            : CupertinoColors.secondaryLabel.resolveFrom(
                                context,
                              ),
                        size: 20,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          font.name,
                          style: TextStyle(
                            fontFamily: font.value,
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected
                                ? CupertinoColors.systemBlue.resolveFrom(
                                    context,
                                  )
                                : CupertinoColors.label.resolveFrom(context),
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          CupertinoIcons.checkmark,
                          color: CupertinoColors.systemBlue.resolveFrom(
                            context,
                          ),
                          size: 18,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFontSizeSection(double selectedFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Font Size', CupertinoIcons.textformat_size),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6
                .resolveFrom(context)
                .withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: fontSizes.asMap().entries.map((entry) {
              final index = entry.key;
              final size = entry.value;
              final isSelected = selectedFontSize == size;

              return Expanded(
                child: GestureDetector(
                  onTap: () => _updateTheme(context, fontSize: size),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(
                      left: index == 0 ? 0 : 4,
                      right: index == fontSizes.length - 1 ? 0 : 4,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? CupertinoColors.systemBlue.resolveFrom(context)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: CupertinoColors.systemBlue
                                    .resolveFrom(context)
                                    .withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      '${size.toInt()}px',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isSelected
                            ? CupertinoColors.white
                            : CupertinoColors.label.resolveFrom(context),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: CupertinoColors.systemBlue.resolveFrom(context),
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.label.resolveFrom(context),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6.resolveFrom(context),
        border: Border(
          top: BorderSide(
            color: CupertinoColors.separator.resolveFrom(context),
            width: 0.5,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          color: CupertinoColors.systemBlue.resolveFrom(context),
          borderRadius: BorderRadius.circular(12),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: const Text(
            'Done',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ),
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

class _ColorOption {
  final ThemeColorPreset preset;
  final String name;
  final Color color;
  final IconData icon;

  _ColorOption(this.preset, this.name, this.color, this.icon);
}

class _FontOption {
  final String name;
  final String value;
  final IconData icon;

  _FontOption(this.name, this.value, this.icon);
}
