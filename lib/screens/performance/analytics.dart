import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:PALMHR_MOBILE/screens/widgets/attendanceBarChart.dart';

class AnalyticScreen extends StatelessWidget {
  const AnalyticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnalyticHeader(),
              Gap(30),
              PerformanceMetrics(),
              Gap(30),
              BarChartSample2()
            ],
          ),
        ),
      ),
    ));
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Performance",
            style: GoogleFonts.dmSans(
                fontSize: 25, fontWeight: FontWeight.bold)),
        EasyDateTimeLine(
          headerProps: const EasyHeaderProps(
            selectedDateStyle: TextStyle(fontSize: 18),
          ),
          activeColor: Colors.green,
          initialDate: DateTime.now(),
          dayProps: const EasyDayProps(
              width: 50,
              height: 80,
              inactiveDayStyle: DayStyle(
                dayNumStyle: TextStyle(fontSize: 20),
              )),
        )
      ],
    ));
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Attendance Stats",
              style: GoogleFonts.dmSans(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GlassContainer.frostedGlass(
                    borderRadius: BorderRadius.circular(15),
                    height: 275,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("Attendance Percentage",
                              style: GoogleFonts.dmSans(
                                fontSize: 20,
                              )),
                          Gap(20),
                          Text("42%",
                              style: GoogleFonts.roboto(
                                fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic
                              )),
                        ],
                      ),
                    )),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  children: [
                    GlassContainer.frostedGlass(
                        borderRadius: BorderRadius.circular(15),
                        height: 130,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Days Absent",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 20,
                                  )),
                              Gap(20),
                              Text("12 Days",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic
                                  )),
                            ],
                          ),
                        )),
                    const SizedBox(height: 15),
                    GlassContainer.frostedGlass(
                        borderRadius: BorderRadius.circular(15),
                        height: 130,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Leaves Taken",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 20,
                                  )),
                              Gap(20),

                              Text("02",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic
                                  )),
                            ],
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


