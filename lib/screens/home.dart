import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:action_slider/action_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              CheckingComponent()
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const GFAvatar(
              backgroundColor: Colors.grey,
              shape: GFAvatarShape.standard,
              child: Icon(FontAwesomeIcons.user,color: Colors.black45,),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good Morning,',
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.normal,color: Colors.grey)),
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
            icon:const  FaIcon(FontAwesomeIcons.bell), 
            onPressed: () { print("Pressed");
              }
            ),
         IconButton(
           icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket), 
           onPressed: () { print("Pressed");
             }
           
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 30,
            child: Text("Latest Attendance",
                style: GoogleFonts.lato(fontSize: 15))),
        SizedBox(
          height: 150,
          child: ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 200,
                  color: Colors.greenAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.personWalkingArrowRight),
                            const SizedBox(width: 20),
                            Text("Check In", style: GoogleFonts.poppins(fontSize: 18))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("10:20 am",style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.bold)),
                        Text("On Time",style: GoogleFonts.montserrat())
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 200,
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.personWalkingArrowLoopLeft),
                            const SizedBox(width: 20),
                            Text("Check Out", style: GoogleFonts.poppins(fontSize: 18))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("07:20 pm",style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.bold)),
                        Text("Go Home",style: GoogleFonts.montserrat())
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 200,
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.personWalkingArrowRight),
                            const SizedBox(width: 20),
                            Text("Total Days", style: GoogleFonts.poppins(fontSize: 18))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("28",style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.bold)),
                        Text("Working Days",style: GoogleFonts.montserrat())
                      ],
                    ),
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
    return const SizedBox(
    );
  }
}