import 'package:PALMHR_MOBILE/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Text.rich(TextSpan(
              text: 'Welcome to ',
              style: TextStyle(
                  color: Colors.teal, decoration: TextDecoration.none))),
        ],
      ),
    );
  }
}
