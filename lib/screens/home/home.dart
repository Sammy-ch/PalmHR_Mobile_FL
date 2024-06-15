import 'dart:async';

import 'package:PALMHR_MOBILE/main.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:action_slider/action_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  String _firstName = '';
  String _lastName = '';

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data = await supabase
          .from("EmployeeProfile")
          .select()
          .eq("profile_id", userId)
          .single();

      _firstName = data['first_name'];
      _lastName = data['last_name'];
    } on PostgrestException catch (e) {
      if (mounted) {
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBar(
          content: const Text('Unexpected error occured'),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
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
                Text(_firstName,
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white)),
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
                onPressed: () async {
                  await supabase.auth.signOut();
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
                style: GoogleFonts.lato(fontSize: 18, color: Colors.grey))),
        SizedBox(
          height: 150,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              GlassContainer.frostedGlass(
                borderRadius: BorderRadius.circular(15),
                width: 180,
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
              const SizedBox(width: 10),
              GlassContainer.frostedGlass(
                borderRadius: BorderRadius.circular(15),
                width: 180,
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
              const SizedBox(width: 10),
              GlassContainer.frostedGlass(
                borderRadius: BorderRadius.circular(15),
                width: 180,
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
              const SizedBox(width: 15),
              GlassContainer.frostedGlass(
                borderRadius: BorderRadius.circular(15),
                width: 180,
              ),
              const SizedBox(width: 15),
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
  Future<void> _insertCheckIn() async {
    try {
      final userId = supabase.auth.currentSession!.user.id;
      final now = DateTime.now();

      await supabase.from('CheckingRequestQueue').insert({
        'employee_id': userId,
        'checking_date': now.toIso8601String(),
        'checking_time': "${now.hour}:${now.minute}",
        'checking_type': "CHECKIN",
        'checking_status': "PENDING"
      });
    } on PostgrestException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unexpected error occurred'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ActionSlider.standard(
      sliderBehavior: SliderBehavior.stretch,
      backgroundColor: Colors.grey.shade800,
      toggleColor: Colors.green.shade600,
      action: (controller) async {
        controller.loading(); //starts loading animation
        await _insertCheckIn();
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
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recent Activity",
                  style: GoogleFonts.lato(fontSize: 18.0, color: Colors.grey)),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView(
                  children: [
                    Container(
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
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("Present"),
                                Text("10:20 am - 07:20 pm",
                                    style: GoogleFonts.montserrat())
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                      thickness: 0.5,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
