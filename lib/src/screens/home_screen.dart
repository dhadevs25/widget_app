import 'package:flutter/cupertino.dart';
import 'package:widget_app/src/core/theme/app_color.dart';

import '../core/theme/theme_color_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Chọn Màu Chủ Đạo', style: TextStyle(color: AppColor.get(context, AppColor.primary))),
          ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(height: 10),
            ThemeColorSelector(),
          ],
        ),
      ),
    );
  }
}
