import 'dart:async';

import 'package:PALMHR_MOBILE/main.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:action_slider/action_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              HeaderComponent(),
              SizedBox(height: 25),
              AttendanceAnalyticsComponent(),
              SizedBox(height: 35),
              CheckingComponent(),
              SizedBox(height: 35),
              AttendanceActivity()
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderComponent extends StatefulWidget {
  const HeaderComponent({super.key});

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  var _loading = true;

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from("EmployeeProfile")
          .select()
          .eq("id", userId)
          .single();
    } on PostgrestException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const GFAvatar(
              backgroundColor: Colors.grey,
              shape: GFAvatarShape.standard,
              child: Icon(
                FontAwesomeIcons.user,
                color: Colors.black45,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good Morning,',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
                Text('Allan Cherubin',
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.normal)),
              ],
            )
          ],
        ),
        const Spacer(flex: 1),
        Row(
          children: [
            IconButton(
                icon: const FaIcon(FontAwesomeIcons.bell),
                onPressed: () {
                  print("Pressed");
                }),
            IconButton(
                icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                onPressed: () {
                  print("Pressed");
                })
          ],
        )
      ],
    );
  }
}

class AttendanceAnalyticsComponent extends StatefulWidget {
  const AttendanceAnalyticsComponent({super.key});

  @override
  State<AttendanceAnalyticsComponent> createState() =>
      _AttendanceAnalyticsComponentState();
}

class _AttendanceAnalyticsComponentState
    extends State<AttendanceAnalyticsComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 30,
            child: Text("Latest Attendance",
                style: GoogleFonts.lato(fontSize: 20))),
        SizedBox(
          height: 150,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ClayContainer(
                borderRadius: 12,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const FaIcon(
                              FontAwesomeIcons.personWalkingArrowRight),
                          const SizedBox(width: 20),
                          Text("Check In",
                              style: GoogleFonts.poppins(fontSize: 18))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("10:20 am",
                          style: GoogleFonts.montserrat(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Text("On Time", style: GoogleFonts.montserrat())
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              ClayContainer(
                borderRadius: 12,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const FaIcon(
                              FontAwesomeIcons.personWalkingArrowLoopLeft),
                          const SizedBox(width: 20),
                          Text("Check Out",
                              style: GoogleFonts.poppins(fontSize: 18))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("07:20 pm",
                          style: GoogleFonts.montserrat(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Text("Go Home", style: GoogleFonts.montserrat())
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              ClayContainer(
                borderRadius: 12,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const FaIcon(
                              FontAwesomeIcons.personWalkingArrowRight),
                          const SizedBox(width: 20),
                          Text("Total Days",
                              style: GoogleFonts.poppins(fontSize: 18))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("28",
                          style: GoogleFonts.montserrat(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Text("Working Days", style: GoogleFonts.montserrat())
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 160,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }
}

class CheckingComponent extends StatefulWidget {
  const CheckingComponent({super.key});

  @override
  State<CheckingComponent> createState() => _CheckingComponentState();
}

class _CheckingComponentState extends State<CheckingComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ActionSlider.standard(
      sliderBehavior: SliderBehavior.stretch,
      toggleColor: Colors.greenAccent,
      action: (controller) async {
        controller.loading(); //starts loading animation
        await Future.delayed(const Duration(seconds: 3));
        controller.success(); //starts success animation
      },
      child:
          Text("Slide to check In", style: GoogleFonts.poppins(fontSize: 18)),
    ));
  }
}

class AttendanceChart extends StatefulWidget {
  const AttendanceChart({super.key});

  @override
  State<AttendanceChart> createState() => _AttendanceChartState();
}

class _AttendanceChartState extends State<AttendanceChart> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class AttendanceActivity extends StatefulWidget {
  const AttendanceActivity({super.key});

  @override
  State<AttendanceActivity> createState() => _AttendanceActivityState();
}

class _AttendanceActivityState extends State<AttendanceActivity> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Recent Activity", style: GoogleFonts.lato(fontSize: 20.0)),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: ListView(
              children: [
                ClayContainer(
                  borderRadius: 10,
                  curveType: CurveType.concave,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.buildingCircleCheck),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("05-07-2024",
                                style: GoogleFonts.poppins(fontSize: 18)),
                            Text("MIREGO AFRICA",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10, fontWeight: FontWeight.w400))
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Time"),
                            Text("10:20 am - 07:20 pm",
                                style: GoogleFonts.montserrat())
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
