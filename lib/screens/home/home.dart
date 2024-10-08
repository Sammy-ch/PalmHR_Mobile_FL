import 'dart:async';
import 'package:PALMHR_MOBILE/services/queries.dart';
import 'package:PALMHR_MOBILE/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:action_slider/action_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gap/gap.dart';
import 'package:PALMHR_MOBILE/services/checkingFeature.dart';
import 'package:unicons/unicons.dart';

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
              Gap(15),
              AttendanceAnalyticsComponent(),
              Gap(10),
              CheckingComponent(),
              Gap(20),
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
  String _position = '';
  String _profileImage = '';

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data = await supabase
          .from("EmployeeProfile")
          .select("*")
          .eq("profile_id", userId)
          .single();

      _firstName = data['first_name'] ?? '';
      _lastName = data['last_name'] ?? '';
      _position = data['position'] ?? '';
      _profileImage = data['profile_image'] ?? '';
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
          content: Text(error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
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
            GFAvatar(
              backgroundColor: Colors.grey,
              shape: GFAvatarShape.standard,
              backgroundImage:
                  _profileImage.isNotEmpty ? NetworkImage(_profileImage) : null,
              child: _profileImage.isEmpty
                  ? const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black45,
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText("$_firstName $_lastName",
                    maxFontSize: 20,
                    minFontSize: 18,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,)

                        ),
                AutoSizeText(_position,
                    maxFontSize: 18,
                    minFontSize: 16,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
              ],
            )
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
  late Future<List<Map<String, dynamic>>> _attendanceAnalytics;
  late Future<int> _workingDays;

  @override
  void initState() {
    super.initState();
    final userId = supabase.auth.currentSession!.user.id;
    _attendanceAnalytics = fetchClockingData(userId);
    _workingDays = fetchTotalWorkingDays(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            child: Text("Latest Attendance",
                style: GoogleFonts.lato(fontSize: 16, color: Colors.grey.shade700))),
        SizedBox(
          height: 150,
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _attendanceAnalytics,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                final attendanceData = snapshot.data!;
                return ListView(
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
                            Text(attendanceData[0]['checkin_time'] ?? '--:--',
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
                                const FaIcon(FontAwesomeIcons
                                    .personWalkingArrowLoopLeft),
                                const SizedBox(width: 20),
                                Text("Check Out",
                                    style: GoogleFonts.poppins(fontSize: 18))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(attendanceData[0]['checkout_time'] ?? '--:--',
                                style: GoogleFonts.montserrat(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            Text("Go Home", style: GoogleFonts.montserrat())
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    FutureBuilder<int>(
                      future: _workingDays,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData) {
                          return const Center(child: Text('No data available'));
                        } else {
                          final totalWorkingDays = snapshot.data!;
                          return GlassContainer.frostedGlass(
                            borderRadius: BorderRadius.circular(15),
                            width: 180,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const FaIcon(FontAwesomeIcons
                                          .personWalkingArrowRight),
                                      const SizedBox(width: 20),
                                      Text("Total Days",
                                          style:
                                              GoogleFonts.poppins(fontSize: 18))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(totalWorkingDays.toString(),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Text("Working Days",
                                      style: GoogleFonts.montserrat())
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const Gap(15),
                  ],
                );
              }
            },
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
        final isDarkMode =  Theme.of(context).brightness == Brightness.dark;
    final sliderBackgroundColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;

    return Column(
      children: [
        SizedBox(
            child: ActionSlider.standard(
              icon: const FaIcon(Icons.chevron_right_sharp,size: 40,color:Colors.white) ,
          height: 60,
          backgroundBorderRadius:
              const BorderRadius.all(Radius.elliptical(10, 10)),
          foregroundBorderRadius:
              const BorderRadius.all(Radius.elliptical(10, 10)),
          sliderBehavior: SliderBehavior.stretch,
          backgroundColor: sliderBackgroundColor,
          toggleColor: Colors.green.shade600,
          action: (controller) async {
            controller.loading(); //starts loading animation
            await handleCheckIn(userId);
            await Future.delayed(const Duration(seconds: 3));
            controller.success(); //starts success animation
            controller.reset();
          },
          child: Text("Slide to Check In",
              style: GoogleFonts.poppins(fontSize: 18)),
        )),
        const Gap(20.0),
        SizedBox(
            child: ActionSlider.standard(
              icon: const FaIcon(Icons.chevron_right_sharp,size: 40,color: Colors.white) ,
          height: 60,
          backgroundBorderRadius:
              const BorderRadius.all(Radius.elliptical(10, 10)),
          foregroundBorderRadius:
              const BorderRadius.all(Radius.elliptical(10, 10)),
          sliderBehavior: SliderBehavior.stretch,
          backgroundColor: sliderBackgroundColor,
          toggleColor: Colors.deepOrange,
          action: (controller) async {
            controller.loading(); //starts loading animation
            await handleCheckOut(userId);
            await Future.delayed(const Duration(seconds: 3));
            controller.success(); //starts success animation
            controller.reset();
          },
          child: Text("Slide to Check Out",
              style: GoogleFonts.poppins(fontSize: 18)),
        )),
      ],
    );
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
  late Future<List<Map<String, dynamic>>> _attendanceHistory;

  @override
  void initState() {
    super.initState();
    _attendanceHistory = fetchAttendanceHistory(userId);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =  Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor = isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recent Activity",
                  style: GoogleFonts.lato(fontSize: 16.0,)),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _attendanceHistory,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final attendanceData = snapshot.data!;
                      return ListView.builder(
                        itemCount: attendanceData.length,
                        itemBuilder: (context, index) {
                          final attendance = attendanceData[index];
                          return Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      const Icon(UniconsLine.user_check),
                                      const Gap(10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                              attendance['checking_date'] ??
                                                  "N/A",
                                              style: GoogleFonts.poppins()),
                                              AutoSizeText(
                                                  "MIREGO AFRICA",
                                              style: GoogleFonts.poppins())
                                  
                                        ],
                                      ),
                                      const Spacer(
                                        flex: 1,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          AutoSizeText(
                                              attendance['attendance_tag'] ??
                                              'N/A'),
                                              const Gap(10),
                                          AutoSizeText(
                                              "${attendance['checkin_time'] ?? '--:--'} - ${attendance['checkout_time'] ?? '--:--'}",
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
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
