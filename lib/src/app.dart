import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:widget_app/src/screens/home_screen.dart';
import 'package:widget_app/src/screens/login_screen.dart';

import 'core/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: themeManager.current.toCupertinoTheme(),
          home: const HomeScreen(),
        );
      },
    );
  }
}
