import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [LeaveHeader(), Gap(50), LeaveActivity()],
        ),
      )),
    );
  }
}

class LeaveHeader extends StatelessWidget {
  const LeaveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Leave Request",
            style:
                GoogleFonts.dmSans(fontSize: 25, fontWeight: FontWeight.bold)),
        IconButton(
            onPressed: () => context.go('/newLeaveRequest'),
            icon: const Icon(UniconsLine.file_plus_alt,
                size: 30, color: Colors.green))
      ],
    );
  }
}

class LeaveActivity extends StatefulWidget {
  const LeaveActivity({super.key});

  @override
  State<LeaveActivity> createState() => _LeaveActivityState();
}

class _LeaveActivityState extends State<LeaveActivity> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;
    return Container(
      decoration: BoxDecoration(
          color: cardBackgroundColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Half Day Application",
                    style: GoogleFonts.dmSans(
                        color: Colors.grey.shade600, fontSize: 18)),
                Text("Mon, 28 Nov",
                    style: GoogleFonts.dmSans(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Sick",
                    style:
                        GoogleFonts.dmSans(color: Colors.orange, fontSize: 15))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Approved",
                  style: GoogleFonts.dmMono(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewLeaveRequest extends StatefulWidget {
  const NewLeaveRequest({super.key});

  @override
  State<NewLeaveRequest> createState() => _NewLeaveRequestState();
}

class _NewLeaveRequestState extends State<NewLeaveRequest> {
  DateTime? _firstDate;
  DateTime? _secondDate;
  @override
  Widget build(BuildContext context) {
    final calendarController = CleanCalendarController(
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(const Duration(days: 365)),
      onRangeSelected: (firstDate, secondDate) {
        firstDate;
        secondDate;
        // setState(() {
        //   _firstDate = firstDate;
        //   _secondDate = secondDate;
        // });
      },
      onDayTapped: (date) {},
      // readOnly: true,
      onPreviousMinDateTapped: (date) {},
      onAfterMaxDateTapped: (date) {},
      weekdayStart: DateTime.monday,
      // initialFocusDate: DateTime.now(),
      // initialDateSelected: DateTime.now(),
      // endDateSelected: DateTime(2022, 3, 20),
    );

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final ModalBackgroundColor =
        isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: ModalBackgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go("/leave");
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    Gap(10),
                    Text(
                      "New Leave",
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey.shade800
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Type",
                                style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500)),
                            Text("Holiday",
                                style: GoogleFonts.dmSans(
                                    fontSize: 17, fontWeight: FontWeight.w600)),
                            Gap(20),
                            Text("Cause",
                                style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500)),
                            Text("Trip to Gitega",
                                style: GoogleFonts.dmSans(
                                    fontSize: 17, fontWeight: FontWeight.w600)),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("From",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                        _firstDate != null
                                            ? DateFormat('EEE, dd MMM yyyy')
                                                .format(_firstDate!)
                                            : 'Select a date',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("to",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                        _secondDate != null
                                            ? DateFormat('EEE, dd MMM yyyy')
                                                .format(_secondDate!)
                                            : 'Select a date',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                )
                              ],
                            ),
                            Gap(10),
                            SizedBox(
                              height:
                                  350, // Set a fixed height for the calendar
                              child: ScrollableCleanCalendar(
                                calendarController: calendarController,
                                layout: Layout.BEAUTY,
                                calendarCrossAxisSpacing: 0,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Gap(30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.all(15)),
                        backgroundColor: WidgetStateProperty.all(Colors.green),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      print(calendarController.onRangeSelected);
                    },
                    child: Text("Apply for 18 Days Leave",
                        style: GoogleFonts.lato(
                            fontSize: 18, color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
