import 'package:flutter/cupertino.dart';
import 'package:widget_app/src/core/theme/theme_extensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Text(
          'Login Screen',
          style: TextStyle(fontSize: 24, color: context.primaryColor),
        ),
      ),
    );
  }
}
