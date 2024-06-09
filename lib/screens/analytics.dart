import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:glass_kit/glass_kit.dart';


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
                AnalyticHeader(),
                SizedBox(height: 20),
                PerformanceMetrics()
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

class PerformanceMetrics extends StatefulWidget {
  const PerformanceMetrics({super.key});

  @override
  State<PerformanceMetrics> createState() => _PerformanceMetricsState();
}

class _PerformanceMetricsState extends State<PerformanceMetrics> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GlassContainer.frostedGlass(
              borderRadius: BorderRadius.circular(15),
              height: 305,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Performance Metrics",style: GoogleFonts.dmSans(fontSize: 25,)),
              )
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                children: [
                  GlassContainer.frostedGlass(
                    borderRadius: BorderRadius.circular(15),
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Performance Metrics", style: GoogleFonts.dmSans(fontSize: 25,)),
                    )
                  ),
                  const SizedBox(height: 5),
                  GlassContainer.frostedGlass(
                    borderRadius: BorderRadius.circular(15),
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Additional Metrics", style: GoogleFonts.dmSans(fontSize: 25,)),
                    )
                  ),
                ],
              ),
          )
      ],),
    );
  }
}