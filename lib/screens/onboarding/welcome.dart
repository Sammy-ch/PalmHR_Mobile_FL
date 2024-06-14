import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Text.rich(TextSpan(
              text: 'Welcome to ',
              style: TextStyle(
                  color: Colors.teal, decoration: TextDecoration.none))),
          ElevatedButton(
              onPressed: () {
                context.goNamed('/register');
              },
              child: const Text("Home Page"))
        ],
      ),
    );
  }
}
