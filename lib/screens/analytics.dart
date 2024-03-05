import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AnalyticScreen extends StatelessWidget {
  const AnalyticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                AnalyticHeader()
              ],
            ),
          ),
        )
    );
  }
}


class AnalyticHeader extends StatefulWidget {
  const AnalyticHeader({super.key});

  @override
  State<AnalyticHeader> createState() => _AnalyticHeaderState();
}

class _AnalyticHeaderState extends State<AnalyticHeader> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text("Analytics",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))
      ],
    );
  }
}

