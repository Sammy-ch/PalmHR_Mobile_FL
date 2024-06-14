import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:modular_ui/modular_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MUISignInCard(
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          onSignInPressed: () async {
            context.goNamed("/home");
          },
          onRegisterNow: () async {},
        ),
      ),
    );
  }
}
