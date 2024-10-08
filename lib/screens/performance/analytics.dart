import 'package:PALMHR_MOBILE/main.dart';
import 'package:PALMHR_MOBILE/services/queries.dart';
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
    return const Scaffold(
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
            style:
                GoogleFonts.dmSans(fontSize: 25, fontWeight: FontWeight.bold)),
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
  late Future<Map<String, double>> _attendancePercentages;
  late Future<int> _totalDaysAbsent;
  late Future<int> _allowedLeaves;
  @override
  void initState() {
    super.initState();
    _attendancePercentages = calculateAttendancePercentages(userId);
    _totalDaysAbsent = calculateTotalDaysAbsent(userId);
    _allowedLeaves = fetchAllowedLeaves(userId);
  }

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
          FutureBuilder<List<dynamic>>(
              future: Future.wait(
                  [_attendancePercentages, _totalDaysAbsent, _allowedLeaves]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('No data available');
                } else {
                  final percentages = snapshot.data![0] as Map<String, double>;
                  final totalDaysAbsent = snapshot.data![1] as int;
                  final allowedLeaves = snapshot.data![2] as int;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GlassContainer.frostedGlass(
                            borderRadius: BorderRadius.circular(15),
                            height: 315,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("OnTime Attendance",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 20,
                                      )),
                                  const Gap(10),
                                  Text(
                                      "${percentages['onTimePercentage']?.toStringAsFixed(2)}%",
                                      style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                            )),
                                  const Gap(30),
                                  Text("Late Attendance",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 20,
                                      )),
                                  const Gap(10),
                                  Text(
                                      "${percentages['latePercentage']?.toStringAsFixed(2)}%",
                                      style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
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
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Total Days Absent",
                                          style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                          )),
                                      const Gap(10),
                                      Text("$totalDaysAbsent Days",
                                          style: GoogleFonts.dmSans(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                     )),
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 15),
                            GlassContainer.frostedGlass(
                                borderRadius: BorderRadius.circular(15),
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Leaves Balance",
                                          style: GoogleFonts.dmSans(
                                            fontSize: 20,
                                          )),
                                      const Gap(10),
                                      Text("$allowedLeaves Days",
                                          style: GoogleFonts.dmSans(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
