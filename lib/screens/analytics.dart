import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AnalyticScreen extends StatelessWidget {
  const AnalyticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.black,
        body: const Center(
            child: Text("Analytics Screen"),
        ),
    );
  }
}