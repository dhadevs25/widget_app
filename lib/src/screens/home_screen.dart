import 'package:flutter/cupertino.dart';
import 'package:widget_app/src/core/theme/theme_extensions.dart';
import '../widgets/theme_settings_popup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: context.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: context.backgroundColor.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: context.primaryColor.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        middle: Text(
          'Widget App',
          style: TextStyle(
            color: context.primaryColor,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: context.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CupertinoButton(
            padding: const EdgeInsets.all(8),
            onPressed: () => _showThemeSettings(context),
            child: Icon(
              CupertinoIcons.settings,
              color: context.primaryColor,
              size: 22,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: context.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  CupertinoIcons.paintbrush_fill,
                  size: 80,
                  color: context.primaryColor,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome to Widget App',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: context.primaryColor,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Tap the settings icon to customize your theme and make it truly yours',
                  style: TextStyle(
                    fontSize: 16,
                    color: context.primaryColor.withOpacity(0.7),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemeSettings(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const ThemeSettingsPopup(),
    );
  }
}
