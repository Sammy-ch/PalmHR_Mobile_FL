import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

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
    return Container(
      child: 
        Column(
          children: [
            Center(child: Text("Analytics",style: GoogleFonts.dmSans(fontSize: 25,fontWeight: FontWeight.bold))),
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              dayProps: const EasyDayProps(
                width: 60,
                height: 80
              ),
              )
          ],
        )
    );
  }
}

